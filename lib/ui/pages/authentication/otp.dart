import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/named_routes.dart';
import 'package:verifysafe/core/data/enum/otp_type.dart';
import 'package:verifysafe/core/data/enum/password_type.dart';
import 'package:verifysafe/core/data/view_models/authentication_vms/otp_vm.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/pages/authentication/create_password.dart';

import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../widgets/alert_dialogs/action_completed.dart';
import '../../widgets/bottom_sheets/base_bottom_sheet.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/screen_title.dart';

class Otp extends ConsumerStatefulWidget {
  final OtpType otpType;
  final String identifier;
  const Otp({super.key, required this.otpType, required this.identifier});

  @override
  ConsumerState<Otp> createState() => _OtpState();
}

class _OtpState extends ConsumerState<Otp> {

  final _otp = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(otpViewModel);
    final subtitle = vm.otpSubtitle(otpType: widget.otpType);
    return Scaffold(
      appBar: customAppBar(
        context: context,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppDimension.paddingLeft),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScreenTitle(
              headerText: vm.otpTitle(otpType: widget.otpType),
            ),
            SizedBox(height: 10.h,),
            RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textPrimary,
                ),
                children: [
                  TextSpan(
                    text: '${subtitle[0]}\n',
                  ),
                  TextSpan(
                    text: widget.identifier,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.textPrimary
                    ),
                  ),
                  if(subtitle.length > 1)TextSpan(
                    text: ' ${subtitle[1]}',
                  ),

                ],
              ),
            ),
            SizedBox(height: 54.h,),
            PinCodeTextField(
              length: 4,
              controller: _otp,
              mainAxisAlignment: MainAxisAlignment.start,
              separatorBuilder: (context, index) {
                return SizedBox(width: 16.w,);
              },
              obscureText: false,
              animationType: AnimationType.fade,
              backgroundColor: Colors.transparent,
              obscuringCharacter: "*",
              keyboardType: TextInputType.number,
              cursorColor: Theme.of(context).colorScheme.textPrimary,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],

              pinTheme: PinTheme(
                disabledColor: Colors.transparent,
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.all(Radius.circular(4.r)),
                fieldHeight: 44.h,
                fieldWidth: 44.w,
                inactiveColor: Theme.of(context).colorScheme.pinCodeInactiveBorderColor,
                activeColor: Theme.of(context).colorScheme.pinCodeActiveBorderColor,
                borderWidth: 2.w,
                selectedColor: Theme.of(context).colorScheme.pinCodeInactiveBorderColor,
                selectedFillColor: Theme.of(context).colorScheme.pinCodeInactiveFillColor,
                inactiveFillColor: Theme.of(context).colorScheme.pinCodeInactiveFillColor,
                activeFillColor: Theme.of(context).colorScheme.pinCodeActiveFillColor,

              ),
              textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                //fontSize: 31.sp,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.brandColor
              ),
              enabled: true,
              appContext: context,
              animationDuration: const Duration(milliseconds: 300),
              enableActiveFill: true,
              onCompleted: (v) {
                debugPrint("Completed: $v");
              },
              onChanged: (value) {
                //model.otp = value;
              },
            ),
            SizedBox(height: 16.h,),
            RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textPrimary,
                ),
                children: [
                  TextSpan(
                    text: 'Didn’t get the code? ',
                  ),
                  TextSpan(
                    text: 'Resend',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: ColorPath.meadowGreen
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 47.h,),
            Align(
              alignment: Alignment.centerRight,
              child: CustomButton(
                  buttonWidth: null,
                  buttonText: 'Verify',
                  onPressed: (){

                    baseBottomSheet(
                      context: context,
                      isDismissible: false,
                      enableDrag: false,
                      content: ActionCompleted(
                        title: 'Email Verified!',
                        subtitle: 'Your email address verification was successful',
                        buttonText: 'Continue',
                        onPressed: (){
                          if(widget.otpType == OtpType.forgotPassword){
                            replaceNavigation(context: context, widget: const CreatePassword(passwordType: PasswordType.forgotPassword), routeName: NamedRoutes.createPassword);
                            return;
                          }

                          if(widget.otpType == OtpType.verifyEmail){
                            replaceNavigation(context: context, widget: const CreatePassword(passwordType: PasswordType.onboarding), routeName: NamedRoutes.createPassword);
                            return;
                          }
                        },
                      ),
                    );

                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
