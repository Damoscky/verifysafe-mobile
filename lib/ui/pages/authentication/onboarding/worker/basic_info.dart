import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/named_routes.dart';
import 'package:verifysafe/core/data/enum/password_type.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/view_models/authentication_vms/onboarding_vms/onboarding_vm.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/core/utilities/validator.dart';
import 'package:verifysafe/ui/pages/authentication/create_password.dart';
import 'package:verifysafe/ui/pages/authentication/otp.dart';
import 'package:verifysafe/ui/widgets/authentication/onboarding/step_counter.dart';
import 'package:verifysafe/ui/widgets/busy_overlay.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/show_flush_bar.dart';

import '../../../../../core/constants/app_dimension.dart';
import '../../../../../core/constants/color_path.dart';
import '../../../../../core/data/enum/otp_type.dart';
import '../../../../../core/utilities/input_formatters/nigerian_phone_number_formatter.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../../widgets/screen_title.dart';

class BasicInfo extends ConsumerStatefulWidget {
  const BasicInfo({super.key});

  @override
  ConsumerState<BasicInfo> createState() => _BasicInfoState();
}

class _BasicInfoState extends ConsumerState<BasicInfo> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int? _gender;
  String? _maritalStatus;

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(onboardingViewModel);
    return BusyOverlay(
      show: vm.state == ViewState.busy,
      child: Scaffold(
        appBar: customAppBar(context: context),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: AppDimension.paddingLeft,
            right: AppDimension.paddingRight,
            bottom: 40.h,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenTitle(
                  //firstSubWidget: StepCounter(currentStep: 'basic info'),
                  headerText: 'Basic Information',
                  secondSub: 'Please enter details below.',
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  hintText: 'first name',
                  label: 'First name',
                  keyboardType: TextInputType.text,
                  controller: _firstName,
                  validator: FieldValidator.validate,
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  hintText: 'last name',
                  label: 'Last name',
                  keyboardType: TextInputType.text,
                  controller: _lastName,
                  validator: FieldValidator.validate,
                ),
                SizedBox(height: 16.h),
                Text(
                  'Gender',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.textFieldLabel,
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Clickable(
                      onPressed: () {
                        setState(() {
                          _gender = 0;
                        });
                      },
                      child: Container(
                        height: 30.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                          color: _gender == 0
                              ? Theme.of(context).colorScheme.brandColor
                              : Colors.white,
                          shape: BoxShape.circle,
                          border: _gender == 0
                              ? null
                              : Border.all(
                                  color: ColorPath.athensGrey3,
                                  width: 1.5.w,
                                ),
                        ),
                        child: Center(
                          child: Container(
                            height: 10.h,
                            width: 10.w,
                            decoration: BoxDecoration(
                              color: _gender == 0
                                  ? Colors.white
                                  : ColorPath.athensGrey3,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Female',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.textPrimary,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Clickable(
                      onPressed: () {
                        setState(() {
                          _gender = 1;
                        });
                      },
                      child: Container(
                        height: 30.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                          color: _gender == 1
                              ? Theme.of(context).colorScheme.brandColor
                              : Colors.white,
                          shape: BoxShape.circle,
                          border: _gender == 1
                              ? null
                              : Border.all(
                                  color: ColorPath.athensGrey3,
                                  width: 1.5.w,
                                ),
                        ),
                        child: Center(
                          child: Container(
                            height: 10.h,
                            width: 10.w,
                            decoration: BoxDecoration(
                              color: _gender == 1
                                  ? Colors.white
                                  : ColorPath.athensGrey3,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Male',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.textPrimary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                CustomDropdown(
                  hintText: "Select Marital status",
                  label: 'Marital status',
                  value: _maritalStatus,
                  onChanged: (value) {
                    _maritalStatus = value;
                    setState(() {});
                  },
                  items: ['Married', 'Single'],
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  hintText: 'Email',
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  controller: _email,
                  validator: EmailValidator.validateEmail,
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  label: 'Phone Number',
                  hintText: '+234 000 000 0000',
                  keyboardType: TextInputType.number,
                  controller: _phoneNumber,
                  //focusNode: _phoneFn,
                  validator: FieldValidator.validate,
                  onChanged: (value) {},
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(18),
                    NigerianPhoneNumberFormatter(),
                  ],
                ),
                SizedBox(height: 16.h),
                CustomButton(
                  buttonText: 'Continue',
                  onPressed: () async {
                    final validate = _formKey.currentState!.validate();
                    if (validate) {
                      if (_gender == null) {
                        showFlushBar(
                          context: context,
                          message: "Select Gender",
                          success: false,
                        );
                        return;
                      }
                      if (_maritalStatus == null) {
                        showFlushBar(
                          context: context,
                          message: "Select Marital Status",
                          success: false,
                        );
                        return;
                      }
                      await vm.createUserBasicInfo(
                        firstName: _firstName.text,
                        lastName: _lastName.text,
                        phone: _phoneNumber.text.replaceAll(" ", ""),
                        gender: _gender == 0 ? "female" : "male",
                        maritalStatus: (_maritalStatus ?? "").toLowerCase(),
                        email: _email.text,
                      );

                      if (vm.state == ViewState.retrieved) {
                        //if email is verified route user to create Password
                        if (vm.userBasicInfoResponseData?.emailVerified ??
                            false) {
                          pushNavigation(
                            context: context,
                            widget: CreatePassword(
                              passwordType: PasswordType.onboarding,
                              onboardingId:
                                  vm.userBasicInfoResponseData?.onboardingId,
                            ),
                          );
                          return;
                        }
                        pushNavigation(
                          context: context,
                          widget: Otp(
                            otpType: OtpType.verifyEmail,
                            identifier: _email.text,
                            token:
                                vm.userBasicInfoResponseData?.verificationToken,
                          ),
                          routeName: NamedRoutes.otp,
                        );
                      } else {
                        showFlushBar(
                          context: context,
                          message: vm.message,
                          success: false,
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
