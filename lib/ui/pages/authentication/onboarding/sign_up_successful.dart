import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';

import '../../../../core/constants/app_asset.dart';
import '../../../../core/constants/app_dimension.dart';
import '../../../../core/constants/color_path.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_svg.dart';

class SignUpSuccessful extends StatefulWidget {
  const SignUpSuccessful({super.key});

  @override
  State<SignUpSuccessful> createState() => _SignUpSuccessfulState();
}

class _SignUpSuccessfulState extends State<SignUpSuccessful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: AppDimension.paddingLeft, right: AppDimension.paddingRight, top: 74.h),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              CustomAssetViewer(asset: Platform.isIOS ? AppAsset.faceId:AppAsset.fingerprint, height: 84.h, width: 84.w,),
              SizedBox(height: 44.06.h,),
              Text(
                'You are ready to go',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.textPrimary
                ),
              ),
              SizedBox(height: 10.h,),
              Text(
                'Thank  you for taking your time to create an account with us. Now it”s the fun part, Let”s explore the app',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.text5
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 174.h,),
              CustomButton(
                  buttonText: 'Get Started',
                  useBorderColor: true,
                  borderColor: ColorPath.meadowGreen,
                  buttonTextColor: Theme.of(context).colorScheme.textPrimary,
                  onPressed: (){

                  }
              ),

            ],
          ),
        ),
      ),
    );
  }
}
