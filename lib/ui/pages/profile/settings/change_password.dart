import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/named_routes.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/view_models/authentication_vms/password_vm.dart';
import 'package:verifysafe/core/data/view_models/user_view_model.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/core/utilities/utilities.dart';
import 'package:verifysafe/core/utilities/validator.dart';
import 'package:verifysafe/ui/pages/authentication/login.dart';
import 'package:verifysafe/ui/widgets/authentication/password_requirement.dart';
import 'package:verifysafe/ui/widgets/bottom_sheets/action_completed.dart';
import 'package:verifysafe/ui/widgets/bottom_sheets/base_bottom_sheet.dart';
import 'package:verifysafe/ui/widgets/busy_overlay.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/custom_button.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';
import 'package:verifysafe/ui/widgets/custom_text_field.dart';

class ChangePassword extends ConsumerStatefulWidget {
  const ChangePassword({super.key});

  @override
  ConsumerState<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends ConsumerState<ChangePassword> {
  final _pwd = TextEditingController();
  final _newPwd = TextEditingController();
  final _confirmPwd = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _hidePwd = true;
  bool _hideNewPwd = true;
  bool _hideConfirmPwd = true;
  @override
  Widget build(BuildContext context) {
    final passwordVm = ref.watch(passwordViewModel);
    final userVm = ref.watch(userViewModel);

    return BusyOverlay(
      show: userVm.passwordState == ViewState.busy,
      child: Scaffold(
        appBar: customAppBar(context: context, title: "Change Password"),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.only(
              left: AppDimension.paddingLeft,
              right: AppDimension.paddingRight,
              bottom: 40.h,
              top: 32.h,
            ),
            children: [
              CustomTextField(
                label: 'Current Password',
                hintText: 'Enter your password',
                obscure: _hidePwd,
                controller: _pwd,
                validator: PasswordValidator.validatePassword,
                keyboardType: TextInputType.text,
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 16.w, left: 16.w),
                  child: Clickable(
                    onPressed: () {
                      setState(() {
                        _hidePwd = !_hidePwd;
                      });
                    },
                    child: CustomAssetViewer(
                      asset: _hidePwd
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
                // onChanged: (value) => vm.checkPassWordRequirement(password: _pwd.text),
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                label: 'Enter New Password',
                hintText: 'Create new password',
                obscure: _hideNewPwd,
                controller: _newPwd,
                validator: PasswordValidator.validatePassword,
                keyboardType: TextInputType.text,
                onChanged: (val) =>
                    passwordVm.checkPassWordRequirement(password: _newPwd.text),
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 16.w, left: 16.w),
                  child: Clickable(
                    onPressed: () {
                      setState(() {
                        _hideNewPwd = !_hideNewPwd;
                      });
                    },
                    child: CustomAssetViewer(
                      asset: _hideNewPwd
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
              SizedBox(height: 16.h),
              CustomTextField(
                label: 'Confirm Password',
                hintText: 'Confirm your password',
                obscure: _hideConfirmPwd,
                controller: _confirmPwd,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (val != _newPwd.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 16.w, left: 16.w),
                  child: Clickable(
                    onPressed: () {
                      setState(() {
                        _hideConfirmPwd = !_hideConfirmPwd;
                      });
                    },
                    child: CustomAssetViewer(
                      asset: _hideConfirmPwd
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
              PasswordRequirement(),
              Padding(
                padding: EdgeInsets.only(top: 56.h),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: CustomButton(
                    // buttonWidth: null,
                    // buttonHorizontalPadding: 43.w,
                    buttonText: 'Update Password',
                    onPressed: () async {
                      final validate = _formKey.currentState!.validate();
                      if (validate) {
                        Utilities.hideKeyboard(context);
                        await userVm.updatePassword(
                          password: _pwd.text,
                          newPassword: _newPwd.text,
                          confirmPassword: _confirmPwd.text,
                        );

                        if (userVm.passwordState == ViewState.retrieved) {
                          baseBottomSheet(
                            context: context,
                            isDismissible: false,
                            enableDrag: false,
                            content: ActionCompleted(
                              title: 'Success!',
                              subtitle:
                                  'You have successfully changed your password.',
                              buttonText: 'Sign in',
                              onPressed: () {
                                pushAndClearAllNavigation(
                                  context: context,
                                  widget: Login(),
                                  routeName: NamedRoutes.login,
                                );
                              },
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
