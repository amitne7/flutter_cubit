import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_security_officer/app/general_imports.dart';
import 'package:personal_security_officer/cubits/authentication/check_is_user_exist_cubit.dart';
import 'package:personal_security_officer/cubits/authentication/send_verification_code_cubit.dart';
import 'package:personal_security_officer/cubits/authentication/verify_otp_cubit.dart';
import 'package:personal_security_officer/data/model/user_model.dart';
import 'package:personal_security_officer/widget/authentication_screen_background.dart';
import 'package:personal_security_officer/widget/linear_widget.dart';
import 'package:personal_security_officer/widget/mobile_number_field.dart';

class LoginCustomerScreen extends StatefulWidget {
  const LoginCustomerScreen({required this.source, final Key? key}) : super(key: key);
  final String source;

  @override
  State<LoginCustomerScreen> createState() => _LoginCustomerScreenState();

  static Route route(final RouteSettings routeSettings) {
    print(routeSettings.name);
    final arguments = routeSettings.arguments as Map<String, dynamic>;

    return CupertinoPageRoute(
      builder: (final _) => LoginCustomerScreen(
        source: arguments['source'],
      ),
    );
  }
}

class _LoginCustomerScreenState extends State<LoginCustomerScreen> {
  String phoneNumberWithCountryCode = "";
  String onlyPhoneNumber = "";
  String countryCode = "";

  final GlobalKey<FormState> verifyPhoneNumberFormKey = GlobalKey<FormState>();
  final TextEditingController _numberFieldController = TextEditingController();

  ValueNotifier<int> numberLength = ValueNotifier(0);

  @override
  void dispose() {
    _numberFieldController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _numberFieldController.text = "";
    numberLength.value = 10;
  }
    
  void _onContinueButtonClicked() {
    UiUtils.removeFocus();
    if (numberLength.value < UiUtils.minimumMobileNumberDigit ||
        numberLength.value > UiUtils.maximumMobileNumberDigit) {
      return;
    }
    final bool isValidNumber =
        verifyPhoneNumberFormKey.currentState!.validate();

    if (isValidNumber) {
      //
      final String countryCallingCode =
          context.read<CountryCodeCubit>().getSelectedCountryCode();
      //
      phoneNumberWithCountryCode =
          countryCallingCode + _numberFieldController.text;
      onlyPhoneNumber = _numberFieldController.text;
      countryCode = countryCallingCode;
//
      context.read<CheckIsUserExistsCubit>().isUserExists(
            mobileNumber: onlyPhoneNumber,
            countryCode: countryCode,
            uid: "",
            loginType: LogInType.phone,
          );
    }
  }

  Widget _buildPhoneNumberFiled() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: MobileNumberFiled(
                controller: _numberFieldController,
                isReadOnly: false,
                onChanged: (number) {
                  numberLength.value = number.length;
                },
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            _buildSignInWithMobileButton(),
          ],
        ),
      );

  Widget _buildLoginOrSignupWidget() => CustomText(
        'loginOrSignup'.translate(context: context),
        color: Theme.of(context).colorScheme.blackColor,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        fontSize: 16,
        textAlign: TextAlign.center,
      );

  Widget _buildWelcomeHeadingWidget() => Column(
        children: [
          CustomText(
            'welcomeTo'.translate(context: context),
            color: Theme.of(context).colorScheme.blackColor,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            fontSize: 28,
            textAlign: TextAlign.center,
          ),
          CustomText(
            'appName'.translate(context: context),
            color: Theme.of(context).colorScheme.accentColor,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            fontSize: 28,
            textAlign: TextAlign.center,
          ),
        ],
      );

  @override
  Widget build(final BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: UiUtils.getSystemUiOverlayStyle(context: context),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: CustomContainer(
          gradient: LinearGradient(
            colors: [
              context.colorScheme.secondaryColor,
              context.colorScheme.primaryColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          child: BlocListener<CheckIsUserExistsCubit, CheckIsUserExistsState>(
            listener: (final BuildContext context,
                    final CheckIsUserExistsState state) =>
                _handleCheckIsUserExitListener(state),
            child: AuthenticationScreenBackground(
              child: Stack(
                children: [
                  Form(
                    key: verifyPhoneNumberFormKey,
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: context.screenHeight * 0.17),
                          _buildLogoWidget(),
                          const SizedBox(height: 40),
                          SizedBox(
                              width: context.screenWidth * 0.7,
                              child: LinearDivider()),
                          const SizedBox(height: 24),
                          _buildWelcomeHeadingWidget(),
                          const SizedBox(
                            height: 24,
                          ),
                          _buildLoginOrSignupWidget(),
                          const SizedBox(
                            height: 24,
                          ),
                          _buildPhoneNumberFiled(),
                          const SizedBox(
                            height: 32,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: [
                          //     Expanded(
                          //         child: CustomContainer(
                          //       height: 0.5,
                          //       gradient: LinearGradient(
                          //         colors: [
                          //           context.colorScheme.secondaryColor,
                          //           context.colorScheme.lightGreyColor
                          //               .withAlpha(80),
                          //           context.colorScheme.lightGreyColor,
                          //         ],
                          //       ),
                          //     )),
                          //     const SizedBox(width: 12),
                          //     CustomText(
                          //       " ${"orSignInWith".translate(context: context)} ",
                          //       fontWeight: FontWeight.w400,
                          //       color: context.colorScheme.lightGreyColor,
                          //       fontSize: 14,
                          //     ),
                          //     const SizedBox(width: 12),
                          //     Expanded(
                          //         child: CustomContainer(
                          //       height: 0.5,
                          //       gradient: LinearGradient(
                          //         colors: [
                          //           context.colorScheme.lightGreyColor,
                          //           context.colorScheme.lightGreyColor
                          //               .withAlpha(80),
                          //           context.colorScheme.secondaryColor,
                          //         ],
                          //       ),
                          //     )),
                          //   ],
                          // ),
                          const SizedBox(
                            height: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned.directional(
                    start: 0,
                    end: 0,
                    bottom: 30,
                    textDirection: Directionality.of(context),
                    child: CustomSizedBox(
                      width: size.width,
                      child: Column(
                        children: [
                          CustomText(
                              "by_continue_agree".translate(context: context),
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w400,
                              color:
                                  Theme.of(context).colorScheme.lightGreyColor,
                              fontSize: 12),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomInkWellContainer(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        appSettingsRoute,
                                        arguments: 'termsofservice');
                                  },
                                  child: CustomText(
                                    "terms_service".translate(context: context),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .blackColor,
                                    showUnderline: true,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                ),
                                CustomText(
                                  " & ",
                                  color: Theme.of(context)
                                      .colorScheme
                                      .lightGreyColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                                CustomInkWellContainer(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        appSettingsRoute,
                                        arguments: 'privacyAndPolicy');
                                  },
                                  child: CustomText(
                                    "privacyAndPolicy"
                                        .translate(context: context),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .blackColor,
                                    fontWeight: FontWeight.w400,
                                    showUnderline: true,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned.directional(
                      top: 55,
                      end: 15,
                      textDirection: Directionality.of(context),
                      child: BlocBuilder<VerifyOtpCubit, VerifyOtpState>(
                        builder: (final context, final VerifyOtpState state) =>
                            CustomInkWellContainer(
                          onTap: (state is SendVerificationCodeInProgressState)
                              ? () {
                                  UiUtils.showMessage(
                                    context,
                                    'verificationIsInProgress'
                                        .translate(context: context),
                                    ToastificationType.warning,
                                  );
                                }
                              : () async {
                                  HiveRepository.setUserSkippedTheLoginBefore =
                                      true;
                                  if (widget.source == 'dialog') {
                                    Navigator.pop(context);
                                  } else if (Routes.previousRoute ==
                                          onBoardingRoute ||
                                      Routes.previousRoute == splashRoute) {
                                    await Navigator.pushReplacementNamed(
                                        context, navigationRoute);
                                  } else if (Routes.previousRoute ==
                                          navigationRoute ||
                                      Routes.previousRoute == loginRoute) {
                                    Navigator.pop(context);
                                  } else {
                                    await Navigator.pushReplacementNamed(
                                        context, navigationRoute);
                                  }
                                },
                          child: CustomContainer(
                            border: Border.all(
                                color: context.colorScheme.lightGreyColor,
                                width: 0.5),
                            borderRadius: UiUtils.borderRadiusOf5,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            child: CustomText(
                              'skip'.translate(context: context),
                              color: Theme.of(context).colorScheme.blackColor,
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInWithMobileButton() =>
      BlocConsumer<CheckIsUserExistsCubit, CheckIsUserExistsState>(
        listener: (final BuildContext context,
            final CheckIsUserExistsState state) async {
          if (state is CheckIsUserExistsFailure) {
            UiUtils.showMessage(
              context,
              state.errorMessage.translate(context: context),
              ToastificationType.error,
            );
          } else if (state is CheckIsUserExistsSuccess) {
            if (state.loginType != LogInType.phone) {
              return;
            }

            if (state.isError) {
              UiUtils.showMessage(
                context,
                state.errorMessage,
                ToastificationType.warning,
              );
              return;
            }

            // 101:- Mobile number already registered and Active
            // 102:- Mobile number is not registered
            // 103:- Mobile number is De active
            if (state.statusCode == '103') {
              UiUtils.showMessage(
                context,
                'yourAccountIsDeActive'.translate(context: context),
                ToastificationType.warning,
              );
              Navigator.pop(context);
              return;
            } else {
              if (state.authenticationType == "sms_gateway") {
                UiUtils.showMessage(
                  context,
                  'otpSentSuccessfully'.translate(context: context),
                  ToastificationType.success,
                );
                Future.delayed(const Duration(milliseconds: 500), () {
                  Navigator.pushNamed(
                    context,
                    otpVerificationRoute,
                    arguments: {
                      'phoneNumberWithCountryCode': phoneNumberWithCountryCode,
                      'phoneNumberWithOutCountryCode': onlyPhoneNumber,
                      'countryCode': countryCode,
                      'source': widget.source,
                      "userAuthenticationCode": state.statusCode,
                      "authenticationType": state.authenticationType
                    },
                  );
                });
              } 
            }
          }
          //
        },
        builder: (context, checkIsUserExistsState) {
          final bool isCheckingUserExists =
              checkIsUserExistsState is CheckIsUserExistsInProgress;
          return BlocConsumer<SendVerificationCodeCubit,
              SendVerificationCodeState>(
            listener:
                (final BuildContext context, final verifyPhoneNumberState) =>
                    _handleVerifyPhoneNumberListener(
                        context, verifyPhoneNumberState),
            builder: (final BuildContext context,
                final SendVerificationCodeState verifyPhoneNumberState) {
              final bool isVerifyingPhoneNumber =
                  verifyPhoneNumberState is SendVerificationCodeInProgressState;

              return ValueListenableBuilder(
                  valueListenable: numberLength,
                  builder: (context, numberLength, _) {
                    return SizedBox(
                      height: 48,
                      width: 48,
                      child: CustomRoundedButton(
                          buttonTitle: "",
                          showBorder: false,
                          widthPercentage: 1,
                          onTap: () {
                            if (verifyPhoneNumberState
                                is SendVerificationCodeInProgressState) {
                              return;
                            } else if (checkIsUserExistsState
                                is CheckIsUserExistsInProgress) {
                              return;
                            }
                            _onContinueButtonClicked();
                          },
                          backgroundColor: ((numberLength <
                                  UiUtils.minimumMobileNumberDigit)
                              ? context.colorScheme.lightGreyColor.withAlpha(30)
                              : (numberLength >
                                      UiUtils.maximumMobileNumberDigit)
                                  ? AppColors.redColor.withAlpha(30)
                                  : context.colorScheme.accentColor),
                          child: (isVerifyingPhoneNumber ||
                                  isCheckingUserExists)
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CustomCircularProgressIndicator(
                                    color: AppColors.whiteColors,
                                  ),
                                )
                              : CustomSvgPicture(
                                  svgImage: AppAssets.loginArrow,
                                  color: ((numberLength <
                                          UiUtils.minimumMobileNumberDigit)
                                      ? context.colorScheme.lightGreyColor
                                      : (numberLength >
                                              UiUtils.maximumMobileNumberDigit)
                                          ? AppColors.redColor
                                          : AppColors.whiteColors))),
                    );
                  });
            },
          );
        },
      );

      void _handleVerifyPhoneNumberListener(BuildContext context,
      SendVerificationCodeState sendVerificationCodeState) {
    if (sendVerificationCodeState is SendVerificationCodeSuccessState) {
      Navigator.pushNamed(
        context,
        otpVerificationRoute,
        arguments: {
          'phoneNumberWithCountryCode': phoneNumberWithCountryCode,
          'phoneNumberWithOutCountryCode': onlyPhoneNumber,
          'countryCode': countryCode,
          'source': widget.source,
          "userAuthenticationCode":
              sendVerificationCodeState.userAuthenticationCode,
          "authenticationType": sendVerificationCodeState.authenticationType
        },
      );
    } else if (sendVerificationCodeState is SendVerificationCodeFailureState) {
      String errorMessage = '';

      errorMessage = sendVerificationCodeState.error
          .toString()
          .translate(context: context);
      UiUtils.showMessage(context, errorMessage, ToastificationType.error);
    }
  }

   Future<void> _handleCheckIsUserExitListener(
      CheckIsUserExistsState state) async {
    if (state is CheckIsUserExistsFailure) {
      UiUtils.showMessage(
        context,
        state.errorMessage.translate(context: context),
        ToastificationType.error,
      );
    } else if (state is CheckIsUserExistsSuccess) {
      if (state.loginType == LogInType.phone) {
        return;
      }
      // 101:- Mobile number already registered and Active
      // 102:- Mobile number is not registered
      // 103:- Mobile number is De active
      if (state.statusCode == '103') {
        UiUtils.showMessage(
          context,
          'yourAccountIsDeActive'.translate(context: context),
          ToastificationType.warning,
        );
        // Navigator.pop(context);
        return;
      } else if (state.statusCode == '101') {
        final latitude = HiveRepository.getLatitude ?? "0.0";
        final longitude = HiveRepository.getLongitude ?? "0.0";
        //update fcm id
        String fcmId = "";
        try {
          fcmId = await FirebaseMessaging.instance.getToken() ?? "";
        } catch (_) {}
        //
        await AuthenticationRepository.loginUser(
                uid: state.uid,
                latitude: latitude.toString(),
                longitude: longitude.toString(),
                loginType: state.loginType,
                fcmId: fcmId)
            .then(
          (final UserModel value) {
            HiveRepository.setUserFirstTimeInApp = false;
            HiveRepository.setUserLoggedIn = true;

            context.read<AuthenticationCubit>().checkStatus();
            //
            UiUtils.showMessage(
                context,
                "userLoggedInSuccessfully".translate(context: context),
                ToastificationType.success);
            //
            Future.delayed(Duration.zero, () {
              try {
                //
                // context.read<BookingCubit>().fetchBookingDetails(status: '');
                // context.read<HomeScreenCubit>().fetchHomeScreenData();
                // context.read<CartCubit>().getCartDetails(isReorderCart: false);
                // context.read<BookmarkCubit>().fetchBookmark(type: "list");
                // context.read<MyRequestListCubit>().fetchRequests();

                context.read<UserDetailsCubit>().loadUserDetails();
              } catch (_) {}
              if (widget.source == 'dialog') {
                //  Navigator.pop(context);
                Navigator.pop(context);
              } else {
                UiUtils.bottomNavigationBarGlobalKey.currentState
                    ?.selectedIndexOfBottomNavigationBar.value = 0;
                //  Navigator.pop(context);
                Navigator.of(context).pushNamedAndRemoveUntil(
                    navigationRoute, (Route<dynamic> route) => false);
                //   Navigator.pushReplacementNamed(context, navigationRoute);
              }
            });
          },
        );

        //
      } else {
        print("beforerout ${state.userName}");
        print("beforerout ${state.userEmail}");
        await Navigator.pushNamed(
          context,
          editProfileRoute,
          arguments: {
            /*'phoneNumberWithCountryCode': widget.phoneNumberWithCountryCode,
                'phoneNumberWithOutCountryCode': widget.phoneNumberWithOutCountryCode,
                'countryCode': widget.countryCode,*/
            'source': widget.source,
            'uid': state.uid,
            "userEmail": state.userEmail,
            "userName": state.userName,
            "loginType": state.loginType,
            "isNewUser": true,
          },
        );
      }
    }
  }

  Widget _buildLogoWidget() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      child: Image.asset(
          AppAssets.appLogo,
          height: 240,
          width: 220),
      // child: CustomSvgPicture(
      //   svgImage: Theme.of(context).colorScheme.brightness == Brightness.light
      //       ? AppAssets.loginLogoLight
      //       : AppAssets.loginLogoDark,
      // ),
    );
  }

}