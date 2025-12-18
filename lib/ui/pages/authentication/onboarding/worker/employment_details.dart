import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/data/enum/user_type.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/view_models/authentication_vms/authentication_view_model.dart';
import 'package:verifysafe/core/data/view_models/authentication_vms/onboarding_vms/onboarding_vm.dart';
import 'package:verifysafe/core/data/view_models/general_data_view_model.dart';
import 'package:verifysafe/core/utilities/image_and_doc_utils.dart';
import 'package:verifysafe/ui/widgets/busy_overlay.dart';
import 'package:verifysafe/ui/widgets/show_flush_bar.dart';
import '../../../../../core/constants/app_dimension.dart';
import '../../../../../core/utilities/validator.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../../widgets/screen_title.dart';
import '../../../../widgets/upload_attachment.dart';
class EmploymentDetails extends ConsumerStatefulWidget {
  const EmploymentDetails({super.key});

  @override
  ConsumerState<EmploymentDetails> createState() => _EmploymentDetailsState();
}

class _EmploymentDetailsState extends ConsumerState<EmploymentDetails> {
  String? _jobCategory, _willingToRelocate;
  final _role = TextEditingController();
  final _language = TextEditingController();
  final _experience = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String fileUrl = '';

  @override
  Widget build(BuildContext context) {
    final authVm = ref.watch(authenticationViewModel);
    final onboardingVm = ref.watch(onboardingViewModel);
    final generalVm = ref.watch(generalDataViewModel);

    return BusyOverlay(
      show: onboardingVm.state == ViewState.busy,
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
                  headerText: 'Employment Details',
                  secondSub: 'Please enter details below.',
                ),
                SizedBox(height: 16.h),
                CustomDropdown(
                  hintText: "Select Job Category",
                  label: 'Job Category',
                  value: _jobCategory,
                  onChanged: (value) {
                    _jobCategory = value;
                    setState(() {});
                  },
                  items: generalVm.jobCategory,
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  label: 'Specific Role',
                  hintText: 'Enter Specific Role',
                  keyboardType: TextInputType.text,
                  controller: _role,
                  //focusNode: _phoneFn,
                  validator: FieldValidator.validate,
                  onChanged: (value) {},
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  label: 'Languages Spoken',
                  hintText: 'Enter Languages Spoken',
                  keyboardType: TextInputType.text,
                  controller: _language,
                  //focusNode: _phoneFn,
                  validator: FieldValidator.validate,
                  onChanged: (value) {},
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  label: 'Years of Experience',
                  hintText: 'Enter Years of Experience',
                  keyboardType: TextInputType.text,
                  controller: _experience,
                  //focusNode: _phoneFn,
                  validator: FieldValidator.validate,
                  onChanged: (value) {},
                ),
                SizedBox(height: 16.h),
                CustomDropdown(
                  hintText: "Select",
                  label: 'Willingness to Relocate?',
                  value: _willingToRelocate,
                  onChanged: (value) {
                    _willingToRelocate = value;
                    setState(() {});
                  },
                  items: ['Yes', 'No'],
                ),
                SizedBox(height: 16.h),
                UploadAttachment(
                  title: 'Upload Resume',
                  onPressed: () async {
                  //TODO::: handle uploaded state and loading state
                  /// - use generalVM to upload image here.
                  final data = await ImageAndDocUtils.pickDocument();
                  await generalVm.uploadImage(base64String: data);

                  if (generalVm.generalState == ViewState.retrieved) {
                    fileUrl = generalVm.fileUploadsResponse.first.url ?? "";
                  } else {
                    showFlushBar(
                      context: context,
                      message: generalVm.message,
                      success: false,
                    );
                  }
                  },
                ),
                SizedBox(height: 16.h),
                CustomButton(
                  buttonText: 'Continue',
                  onPressed: () async {

                    final validate = _formKey.currentState!.validate();
                    if (validate) {
                      if (_jobCategory == null) {
                        showFlushBar(
                          context: context,
                          message: "Select Job Category",
                          success: false,
                        );
                        return;
                      }
                      if (_willingToRelocate == null) {
                        showFlushBar(
                          context: context,
                          message: "Select Willingness to Relocate",
                          success: false,
                        );
                        return;
                      }

                      await onboardingVm.createEmploymentInfo(
                        category: _jobCategory!,
                        jobrole: _role.text,
                        experience: _experience.text,
                        language: _language.text,
                        relocatable: _willingToRelocate == "Yes" ? "1" : "0",
                        resumeUrl: fileUrl
                      );
                      if (onboardingVm.state == ViewState.retrieved) {
                        //update user onboarding data
                        authVm.authorizationResponse?.onboarding =
                            onboardingVm.userOnboardingData;
                        authVm.updateUI();
                        onboardingVm.handleOnboardingNavigation(
                          context: context,
                          userType:
                              authVm
                                  .authorizationResponse
                                  ?.user
                                  ?.userEnumType ??
                              UserType.worker,
                          currentStep:
                              onboardingVm.userOnboardingData?.currentStep ??
                              '',
                        );
                      } else {
                        showFlushBar(
                          context: context,
                          message: onboardingVm.message,
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
