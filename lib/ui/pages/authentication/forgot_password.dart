import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/named_routes.dart';
import 'package:verifysafe/core/data/enum/otp_type.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/view_models/authentication_vms/password_vm.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/pages/authentication/otp.dart';
import 'package:verifysafe/ui/widgets/busy_overlay.dart';
import 'package:verifysafe/ui/widgets/show_flush_bar.dart';

import '../../../core/utilities/validator.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/screen_title.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});

  @override
  ConsumerState<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
  final TextEditingController _email = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(passwordViewModel);
    return BusyOverlay(
      show: vm.restPasswordState == ViewState.busy,
      child: Scaffold(
        appBar: customAppBar(context: context),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppDimension.paddingLeft),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenTitle(headerText: 'Forgot password'),
                SizedBox(height: 24.h),
                CustomTextField(
                  hintText: 'Your email',
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  controller: _email,
                  validator: EmailValidator.validateEmail,
                  bottomHintText:
                      'A password reset link will be sent to the email you entered.',
                ),
                SizedBox(height: 62.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomButton(
                    buttonWidth: null,
                    buttonText: 'Submit',
                    onPressed: () async {
                      final validate = _formKey.currentState!.validate();
                      if (validate) {
                        await vm.resetForgetPassword(email: _email.text);

                        if (vm.restPasswordState == ViewState.retrieved) {
                          pushNavigation(
                            context: context,
                            widget: Otp(
                              otpType: OtpType.forgotPassword,
                              token: vm.resetPasswordDetail?.token,
                              identifier: _email.text,
                            ),
                            routeName: NamedRoutes.otp,
                          );
                        }

                        showFlushBar(
                          context: context,
                          message: vm.message,
                          success: vm.restPasswordState == ViewState.retrieved,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
