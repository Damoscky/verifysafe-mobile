import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/named_routes.dart';
import 'package:verifysafe/core/data/enum/otp_type.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/pages/authentication/otp.dart';

import '../../../core/utilities/validator.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/screen_title.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
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
              headerText: 'Forgot password',
            ),
            SizedBox(height: 24.h,),
            CustomTextField(
              hintText: 'Your email',
              label: 'Email',
              keyboardType: TextInputType.emailAddress,
              //controller: _email,
              validator: EmailValidator.validateEmail,
              bottomHintText: 'A password reset link will be sent to the email you entered.',
            ),
            SizedBox(height: 62.h,),
            Align(
              alignment: Alignment.centerRight,
              child: CustomButton(
                buttonWidth: null,
                  buttonText: 'Submit',
                  onPressed: (){
                    pushNavigation(context: context, widget: const Otp(
                      otpType: OtpType.forgotPassword,
                      identifier: 'dejbaba@gmail.com', //todo: update to text controller value
                    ), routeName: NamedRoutes.otp);
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
