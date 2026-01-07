import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/named_routes.dart';
import 'package:verifysafe/core/data/enum/password_type.dart';
import 'package:verifysafe/core/data/enum/user_type.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/view_models/authentication_vms/authentication_view_model.dart';
import 'package:verifysafe/core/data/view_models/authentication_vms/onboarding_vms/onboarding_vm.dart';
import 'package:verifysafe/core/data/view_models/authentication_vms/password_vm.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/core/utilities/utilities.dart';
import 'package:verifysafe/ui/pages/authentication/onboarding/agency/agency_info.dart';
import 'package:verifysafe/ui/pages/authentication/onboarding/employer/employer_info.dart';
import 'package:verifysafe/ui/pages/bottom_nav.dart';
import 'package:verifysafe/ui/widgets/bottom_sheets/action_completed.dart';
import 'package:verifysafe/ui/widgets/authentication/password_requirement.dart';
import 'package:verifysafe/ui/widgets/authentication/terms.dart';
import 'package:verifysafe/ui/widgets/busy_overlay.dart';
import 'package:verifysafe/ui/widgets/show_flush_bar.dart';

import '../../../core/constants/app_asset.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/utilities/validator.dart';
import '../../widgets/bottom_sheets/base_bottom_sheet.dart';
import '../../widgets/clickable.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_svg.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/screen_title.dart';

class CreatePassword extends ConsumerStatefulWidget {
  final PasswordType passwordType;
  final String? onboardingId; // for account creation
  const CreatePassword({
    super.key,
    required this.passwordType,
    this.onboardingId,
  });

  @override
  ConsumerState<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends ConsumerState<CreatePassword> {
  final _pwd = TextEditingController();
  final _confirmPwd = TextEditingController();

  bool _hidePwd = true;
  bool _hideConfirmPwd = true;

  bool validatePassword() => _pwd.text == _confirmPwd.text;

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(passwordViewModel);
    final onboardingVm = ref.watch(onboardingViewModel);
    final authVm = ref.watch(authenticationViewModel);

    return BusyOverlay(
      show:
          vm.restPasswordState == ViewState.busy ||
          onboardingVm.state == ViewState.busy,
      child: Scaffold(
        appBar: customAppBar(context: context),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppDimension.paddingLeft),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScreenTitle(
                headerText: widget.passwordType == PasswordType.createdUser
                    ? 'Reset your password'
                    : 'Create your new password',
                secondSub: 'Please enter password below.',
              ),
              SizedBox(height: 24.h),
              CustomTextField(
                label: 'Password',
                hintText: 'Enter your password',
                obscure: _hidePwd,
                controller: _pwd,
                validator: FieldValidator.validate,
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
                onChanged: (value) =>
                    vm.checkPassWordRequirement(password: _pwd.text),
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                label: 'Confirm Password',
                hintText: 'Confirm your password',
                obscure: _hideConfirmPwd,
                controller: _confirmPwd,
                validator: FieldValidator.validate,
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
              //::: FORGOT PASSWORD CREATION
              if (widget.passwordType == PasswordType.forgotPassword ||
                  widget.passwordType == PasswordType.createdUser)
                Padding(
                  padding: EdgeInsets.only(top: 45.h),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: CustomButton(
                      buttonWidth: null,
                      buttonHorizontalPadding: 43.w,
                      buttonText: 'Save',
                      onPressed: () async {
                        if (validatePassword()) {
                          if (!vm.isPwdValid()) {
                            showFlushBar(
                              context: context,
                              message: "Provide Strong Password!",
                              success: false,
                            );
                            return;
                          }
                          await vm.createForgetPassword(
                            password: _pwd.text,
                            confirmPassword: _confirmPwd.text,
                          );
                          if (vm.restPasswordState == ViewState.retrieved) {
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
                                  if (widget.passwordType ==
                                      PasswordType.createdUser) {
                                    //todo: perform action
                                    return;
                                  }
                                  popUntilNavigation(
                                    context: context,
                                    route: NamedRoutes.login,
                                  );
                                },
                              ),
                            );
                          } else {
                            showFlushBar(
                              context: context,
                              message: vm.message,
                              success: false,
                            );
                          }
                        } else {
                          showFlushBar(
                            context: context,
                            message: "Password Mismatch",
                            success: false,
                          );
                        }
                      },
                    ),
                  ),
                )
              else
                //::: ONBOARDING PASSWORD CREATION
                Padding(
                  padding: EdgeInsets.only(top: 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Terms(textAlign: TextAlign.left),
                      SizedBox(height: 24.h),
                      CustomButton(
                        buttonText: 'Submit',
                        onPressed: () async {
                          if (validatePassword()) {
                            if (!vm.isPwdValid()) {
                              showFlushBar(
                                context: context,
                                message: "Provide Strong Password!",
                                success: false,
                              );
                              return;
                            }
                            Utilities.hideKeyboard(context);
                            await onboardingVm.setupPassword(
                              password: _pwd.text,
                              confirmPassword: _confirmPwd.text,
                              onboardingId: widget.onboardingId ?? "",
                            );
                            if (onboardingVm.state == ViewState.retrieved) {
                              baseBottomSheet(
                                context: context,
                                isDismissible: false,
                                enableDrag: false,
                                content: ActionCompleted(
                                  title: 'Success!',
                                  subtitle:
                                      'You have successfully created your password.',
                                  buttonText:
                                      onboardingVm.currentUserType ==
                                          UserType.worker
                                      ? 'Sign in'
                                      : "Continue",
                                  onPressed: () {
                                    if (onboardingVm.currentUserType ==
                                        UserType.agency) {
                                      //LOGIN USER
                                      authVm.authorizationResponse =
                                          onboardingVm.authorizationResponse;
                                      pushNavigation(
                                        context: context,
                                        widget: const AgencyInfo(),
                                        routeName: NamedRoutes.agencyInfo,
                                      );
                                      return;
                                    }
                                    if (onboardingVm.currentUserType ==
                                        UserType.employer) {
                                      //LOGIN USER
                                      authVm.authorizationResponse =
                                          onboardingVm.authorizationResponse;
                                      pushNavigation(
                                        context: context,
                                        widget: const EmployerInfo(),
                                        routeName: NamedRoutes.employerInfo,
                                      );
                                      return;
                                    }
                                    //LOGIN USER
                                    authVm.authorizationResponse =
                                        onboardingVm.authorizationResponse;
                                    pushAndClearAllNavigation(
                                      context: context,
                                      widget: BottomNav(
                                        userData: onboardingVm
                                            .authorizationResponse
                                            ?.user,
                                      ),
                                      routeName: NamedRoutes.bottomNav,
                                    );
                                  },
                                ),
                              );
                            } else {
                              showFlushBar(
                                context: context,
                                message: onboardingVm.message,
                                success: false,
                              );
                            }
                          } else {
                            showFlushBar(
                              context: context,
                              message: "Password Mismatch",
                              success: false,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
