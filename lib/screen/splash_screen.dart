// ignore_for_file: file_names, use_build_context_synchronously

import 'package:personal_security_officer/app/general_imports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({final Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();

  static Route route(final RouteSettings routeSettings) => CupertinoPageRoute(
        builder: (final _) => const SplashScreen(),
      );
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
    Future.delayed(Duration.zero).then((final value) {
      context.read<CountryCodeCubit>().loadAllCountryCode(context);
      context.read<SystemSettingCubit>().getSystemSettings();
      context.read<UserDetailsCubit>().loadUserDetails();
      if (HiveRepository.getUserToken != "") {
        context.read<UserDetailsCubit>().getUserDetailsFromServer(HiveRepository.getUserMobileNumber);
      }

      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            statusBarColor: AppColors.splashScreenGradientTopColor,
            systemNavigationBarColor: AppColors.splashScreenGradientBottomColor,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarIconBrightness: Brightness.light),
      );
    });

    _checkAuthentication(isNeedToShowAppUpdate: true);
  }

  Future<void> getLocationData() async {
    //if already we have lat-long of customer then no need to get it again
    if ((HiveRepository.getLongitude == null &&
            HiveRepository.getLatitude == null) ||
        (HiveRepository.getLongitude == "0.0" &&
            HiveRepository.getLatitude == "0.0")) {
      await LocationRepository.requestPermission();
    }
  }

  Future<void> _checkAuthentication(
      {required final bool isNeedToShowAppUpdate}) async {
    await Future.delayed(const Duration(seconds: 3), () {
      final authStatus = context.read<AuthenticationCubit>().state;

      if (authStatus is AuthenticatedState) {
        Navigator.pushReplacementNamed(context, navigationRoute);
        //
       
        return;
      }
      if (authStatus is UnAuthenticatedState) {
        //
        final isFirst = HiveRepository.isUserFirstTimeInApp;
        final isSkippedLoginBefore = HiveRepository.isUserSkippedTheLoginBefore;
        //
        Navigator.pushReplacementNamed(
            context,
            loginRoute,
            arguments: {"source": "splashScreen"},
          );
      }
    });
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Stack(
              children: [
                CustomContainer(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.splashScreenGradientTopColor,
                      AppColors.splashScreenGradientBottomColor,
                    ],
                    stops: [0, 1],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  width: context.screenWidth,
                  height: context.screenHeight,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Center(
                    child: Image.asset(
                        AppAssets.appLogo,
                        height: 240,
                        width: 220),
                  ),
                ),
                if (isDemoMode)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 50),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomSvgPicture(
                          svgImage: AppAssets.splashScreenBottomLogo,
                          width: 135,
                          height: 25),
                    ),
                  ),
              ],
            )
      );
}
