import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/core/constants/named_routes.dart';
import 'package:verifysafe/core/data/models/user.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/core/utilities/secure_storage/secure_storage_utils.dart';
import 'package:verifysafe/ui/pages/authentication/login.dart';
import 'package:verifysafe/ui/pages/bottom_nav.dart';
import 'package:verifysafe/ui/pages/landing.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  User? _savedUser;

  @override
  void initState() {
    initUserAndNavigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: ColorPath.gulfBlue,
          padding: EdgeInsets.only(top: 221.h),
          child: Align(
            alignment: Alignment.topCenter,
              child: CustomSvg(asset: AppAsset.logo, height: 64.h, width: 155.w,)),
        ),
      ),
    );
  }

  initUserAndNavigate()async{
    _savedUser = await SecureStorageUtils.retrieveUser();
   bool userExist = _savedUser != null;
    Timer(const Duration(seconds: 3), () {
      if(userExist){
        //nav returning user to login screen
        replaceNavigation(
            context: context,
            // transitionType: PageTransitionType.rightToLeft,
            widget: const Login(),
            routeName: NamedRoutes.login);
        return;
      }
      //nav user to landing screen
      replaceNavigation(
          context: context,
          widget: const Landing(),
          routeName: NamedRoutes.landing);
    });
  }
}
