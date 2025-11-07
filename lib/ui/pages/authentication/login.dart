import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/named_routes.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/pages/authentication/forgot_password.dart';
import 'package:verifysafe/ui/pages/authentication/onboarding/biometrics_setup.dart';
import 'package:verifysafe/ui/pages/authentication/onboarding/select_user_type.dart';
import 'package:verifysafe/ui/pages/guarantor/manage_guarantor.dart';
import 'package:verifysafe/ui/pages/authentication/onboarding/sign_up_successful.dart';
import 'package:verifysafe/ui/pages/bottom_nav.dart';
import 'package:verifysafe/ui/widgets/authentication/terms.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';
import 'package:verifysafe/ui/widgets/screen_title.dart';

import '../../../core/constants/app_asset.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/utilities/validator.dart';
import '../../widgets/clickable.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool _hidePwd = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          context: context,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: AppDimension.paddingLeft),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ScreenTitle(
                    firstSub: 'Welcome!',
                    headerText: 'Login to VerifySafe',
                  ),
                  SizedBox(height: 24.h,),
                  CustomTextField(
                    hintText: 'Email',
                    label: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    //controller: _email,
                    validator: EmailValidator.validateEmail,
                  ),
                  SizedBox(height: 16.h,),
                  CustomTextField(
                    label: 'Password',
                    hintText: 'Enter your password',
                    obscure: _hidePwd,
                   // controller: _password,
                    validator: FieldValidator.validate,
                    keyboardType: TextInputType.text,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 16.w, left: 16.w),
                      child: Clickable(
                        onPressed: (){
                          setState(() {
                            _hidePwd= !_hidePwd;
                          });
                        },
                        child: CustomAssetViewer(
                          asset:  _hidePwd
                              ? AppAsset.pwdHidden
                              : AppAsset.pwdVisible,
                          height: 16.h,
                          width: 16.w,
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.textFieldSuffixIcon,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h,),
                  Align(
                    alignment: Alignment.center,
                    child: Clickable(
                      onPressed: (){
                        pushNavigation(context: context, widget: const ForgotPassword(), routeName: NamedRoutes.forgotPassword);
                      },
                      child: Text(
                       'Forgot password',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 15.sp,
                            color: Theme.of(context).colorScheme.text4
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h,),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                            buttonText: 'Log in',
                            onPressed: (){
                              pushNavigation(context: context, widget: BottomNav(), routeName: NamedRoutes.bottomNav);
                            }
                        ),
                      ),
                      Clickable(
                        onPressed: (){
                          pushNavigation(context: context, widget: const SignUpSuccessful(), routeName: NamedRoutes.signupSuccessful);
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 16.w),
                          height: 56.h,
                          width: 56.w,
                          decoration: BoxDecoration(
                            color: ColorPath.athensGrey3,
                            borderRadius: BorderRadius.all(Radius.circular(12.r))
                          ),
                          child: Center(
                            child: CustomAssetViewer(asset: Platform.isIOS ? AppAsset.faceId:AppAsset.fingerprint),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16.h,),
                  CustomButton(
                      buttonText: 'Create an account',
                      useBorderColor: true,
                      borderColor: ColorPath.meadowGreen,
                      buttonTextColor: Theme.of(context).colorScheme.textPrimary,
                      onPressed: (){
                        pushNavigation(context: context, widget: const SelectUserType(), routeName: NamedRoutes.selectUserType);
                      }
                  ),

                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 63.w, right: 63.w, bottom: 15.h),
            child: SafeArea(
              child: Terms(),
            ),
          )
        ],
      ),
    );
  }
}
