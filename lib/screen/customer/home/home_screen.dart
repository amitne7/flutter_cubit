import 'package:flutter/material.dart';
import 'package:personal_security_officer/cubits/home_screen_cubit.dart';
import 'package:personal_security_officer/utils/app_quick_actions.dart';
import 'package:personal_security_officer/widget/bottomsheets/layout/location_bottom_sheet.dart';
import 'package:personal_security_officer/widget/marquee_widget.dart';

import '../../../app/general_imports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({required this.scrollController, final Key? key})
      : super(key: key);
  final ScrollController scrollController;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  FocusNode searchBarFocusNode = FocusNode();

  List<String> searchValues = [
    "searchProviders",
    "searchServices",
    "searchElectronics",
    "searchHairCutting",
    "searchFanRepair"
  ];

  late ValueNotifier<int> currentSearchValueIndex = ValueNotifier(0);
  late final AnimationController _animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 2500));

  late final Animation<double> _bottomToCenterTextAnimation =
  Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(
      parent: _animationController, curve: const Interval(0.0, 0.25)));

  late final Animation<double> _centerToTopTextAnimation =
  Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animationController, curve: const Interval(0.75, 1.0)));

  late Timer? _timer;
  ValueNotifier<bool> showShadowBelowSearchBar = ValueNotifier(false);

  @override
  void dispose() {
    showShadowBelowSearchBar.dispose();
    searchBarFocusNode.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    //_initialiseAnimation();
    AppQuickActions.initAppQuickActions();
    AppQuickActions.createAppQuickActions();
    //
    checkLocationPermission();
    //
// Commented by Amit
    //LocalAwesomeNotification.init(context);

    widget.scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (widget.scrollController.position.pixels > 7 &&
        !showShadowBelowSearchBar.value) {
      showShadowBelowSearchBar.value = true;
    } else if (widget.scrollController.position.pixels < 7 &&
        showShadowBelowSearchBar.value) {
      showShadowBelowSearchBar.value = false;
    }
  }

  Future<void> fetchHomeScreenData() async {
    //
    final Map<String, dynamic> currencyData =
    context.read<SystemSettingCubit>().getSystemCurrencyDetails();

    UiUtils.systemCurrency = currencyData['currencySymbol'];
    UiUtils.systemCurrencyCountryCode = currencyData['currencyCountryCode'];
    UiUtils.decimalPointsForPrice = currencyData['decimalPoints'];
    //
    final List<Future> futureAPIs = <Future>[
      context.read<HomeScreenCubit>().fetchHomeScreenData(),

    ];
    await Future.wait(futureAPIs);
  }

  @override
  Widget build(BuildContext context)  =>
      AnnotatedRegion<SystemUiOverlayStyle>(
        value: UiUtils.getSystemUiOverlayStyle(context: context),
        child: SafeArea(
          top: false,
          child: Scaffold(
            appBar: _getAppBar(),
            body: Stack(
              children: [
                Column(
                  children: [
                    const CustomSizedBox(
                      height: 70,
                    ),

                  ],
                ),
                ValueListenableBuilder(
                  builder: (final BuildContext context, final Object? value,
                      final Widget? child) =>
                      CustomContainer(
                        color: context.colorScheme.primaryColor,
                        borderRadius: 12,
                        boxShadow: showShadowBelowSearchBar.value
                            ? [
                          BoxShadow(
                            offset: const Offset(0, 0.75),
                            spreadRadius: 1,
                            blurRadius: 5,
                            color: context.colorScheme.lightGreyColor
                                .withAlpha(80),
                          )
                        ]
                            : [],
                        child: _getSearchBarContainer(),
                      ),
                  valueListenable: showShadowBelowSearchBar,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: UiUtils.bottomNavigationBarHeight,
                      right: 5,
                      left: 5),
                  child: const SizedBox(height: 10,),
                ),
              ],
            ),
          ),
        ),
      );
  AppBar _getAppBar() => AppBar(
    elevation: 0.5,
    surfaceTintColor: context.colorScheme.secondaryColor,
    backgroundColor: context.colorScheme.secondaryColor,
    leadingWidth: 0,
    leading: const CustomSizedBox(),
    title: CustomInkWellContainer(
      onTap: () {
        UiUtils.showBottomSheet(
          enableDrag: true,
          isScrollControlled: true,
          useSafeArea: true,
          child: CustomContainer(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: const LocationBottomSheet(),
          ),
          context: context,
        ).then((final value) {
          if (value != null) {
            if (value['navigateToMap']) {
              Navigator.pushNamed(
                context,
                googleMapRoute,
                arguments: {
                  "defaultLatitude": value['latitude'].toString(),
                  "defaultLongitude": value['longitude'].toString(),
                  'showAddressForm': false
                },
              );
            }
          }
        });
      },
      child: Row(
        children: [
          CustomContainer(
            width: 44,
            height: 44,
            color: context.colorScheme.accentColor.withAlpha(15),
            borderRadius: UiUtils.borderRadiusOf10,
            padding: const EdgeInsets.all(10),
            child: CustomSvgPicture(
              height: 24,
              width: 24,
              svgImage: AppAssets.currentLocation,
              color: context.colorScheme.blackColor,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  'your_location'.translate(context: context),
                  color: context.colorScheme.lightGreyColor,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 12,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 3,
                ),
                Stack(
                  children: [
                    MarqueeWidget(
                      direction: Axis.horizontal,
                      child: ValueListenableBuilder(
                        valueListenable:
                        Hive.box(HiveRepository.userDetailBoxKey)
                            .listenable(),
                        builder: (BuildContext context, Box box, _) =>
                            CustomText(
                              " ${HiveRepository.getLocationName ?? "selectYourLocation".translate(context: context)} ",
                              color: context.colorScheme.blackColor,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              maxLines: 1,
                            ),
                      ),
                    ),
                    PositionedDirectional(
                      start: 0,
                      child: Container(
                        width: 5,
                        height: 70,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              context.colorScheme.secondaryColor,
                              context.colorScheme.secondaryColor
                                  .withValues(alpha: 0.0005),
                            ],
                            stops: const [0.1, 1],
                            begin: AlignmentDirectional.centerStart,
                            end: AlignmentDirectional.centerEnd,
                          ),
                        ),
                      ),
                    ),
                    PositionedDirectional(
                      end: 0,
                      child: Container(
                        width: 5,
                        height: 70,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              context.colorScheme.secondaryColor
                                  .withValues(alpha: 0.0005),
                              context.colorScheme.secondaryColor,
                            ],
                            stops: const [0.1, 1],
                            end: AlignmentDirectional.centerEnd,
                            begin: AlignmentDirectional.centerStart,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    actions: [
      CustomInkWellContainer(
        onTap: () {
          final authStatus = context.read<AuthenticationCubit>().state;
          if (authStatus is UnAuthenticatedState) {
            UiUtils.showAnimatedDialog(
                context: context, child: const LogInAccountDialog());

            return;
          }
          Navigator.pushNamed(context, notificationRoute);
        },
        child: CustomContainer(
          width: 44,
          height: 44,
          margin: const EdgeInsetsDirectional.only(end: 15, start: 12),
          color: context.colorScheme.accentColor.withAlpha(15),
          borderRadius: UiUtils.borderRadiusOf10,
          padding: const EdgeInsets.all(10),
          child: CustomSvgPicture(
            height: 24,
            width: 24,
            svgImage: AppAssets.notification,
            color: context.colorScheme.blackColor,
          ),
        ),
      ),
    ],
  );


  Widget _getSearchBarContainer() {
    return CustomContainer(
      color: context.colorScheme.secondaryColor,
      borderRadiusStyle: const BorderRadius.only(
        bottomLeft: Radius.circular(12),
        bottomRight: Radius.circular(12),
      ),
      child: CustomInkWellContainer(
        onTap: () async {
          await Navigator.pushNamed(context, searchScreen);
        },
        child: CustomContainer(
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          color: context.colorScheme.primaryColor,
          borderRadius: UiUtils.borderRadiusOf10,
          child: Row(
            children: [
              CustomContainer(
                width: 30,
                height: 30,
                margin: const EdgeInsetsDirectional.only(end: 10),
                padding: const EdgeInsets.all(5),
                child: CustomSvgPicture(
                  svgImage: AppAssets.search,
                  color: context.colorScheme.blackColor,
                ),
              ),
              Expanded(
                flex: 8,
                child: ValueListenableBuilder(
                    valueListenable: currentSearchValueIndex,
                    builder: (context, int searchValueIndex, _) {
                      return AnimatedBuilder(
                          animation: _bottomToCenterTextAnimation,
                          builder: (context, child) {
                            final dy = _bottomToCenterTextAnimation.value -
                                _centerToTopTextAnimation.value;

                            final opacity = 1 -
                                _bottomToCenterTextAnimation.value -
                                _centerToTopTextAnimation.value;

                            return Container(
                              height: 50,
                              alignment: Alignment(-1, dy),
                              child: Opacity(
                                  opacity: opacity,
                                  child: CustomText(
                                    searchValues[searchValueIndex]
                                        .translate(context: context),
                                    color: context.colorScheme.lightGreyColor,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14,
                                    maxLines: 1,
                                  )),
                            );
                          });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> checkLocationPermission() async {
    //
    final LocationPermission permission = await Geolocator.checkPermission();
    //
    if ((permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) &&
        ((HiveRepository.getLatitude == "0.0" ||
            HiveRepository.getLatitude == "") &&
            (HiveRepository.getLongitude == "0.0" ||
                HiveRepository.getLongitude == ""))) {
      Future.delayed(Duration.zero, () {
        Navigator.pushNamed(context, allowLocationScreenRoute);
        /*Navigator.pushReplacement(
            context, CupertinoPageRoute(builder: (_) => const AllowLocationScreen()));*/
      });
    }
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      Position position;

      if (HiveRepository.getLatitude != null &&
          HiveRepository.getLongitude != null &&
          HiveRepository.getLatitude != "" &&
          HiveRepository.getLongitude != "") {
        final latitude = HiveRepository.getLatitude ?? "0.0";
        final longitude = HiveRepository.getLongitude ?? "0.0";

        await GeocodingPlatform.instance!.placemarkFromCoordinates(
          double.parse(latitude.toString()),
          double.parse(longitude.toString()),
        );
      } else {
        position = await Geolocator.getCurrentPosition();
        await GeocodingPlatform.instance!
            .placemarkFromCoordinates(position.latitude, position.longitude);
      }

      setState(() {});
    }
  }
  void _initialiseAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 2500), (timer) {
      if (currentSearchValueIndex.value != searchValues.length - 1) {
        currentSearchValueIndex.value += 1;
      } else {
        currentSearchValueIndex.value = 0;
      }
      _animationController.forward(from: 0.0);
    });
    //
    _animationController.forward();
  }
}