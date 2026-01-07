import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/core/data/enum/user_type.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/view_models/authentication_vms/authentication_view_model.dart';
import 'package:verifysafe/core/data/view_models/authentication_vms/onboarding_vms/onboarding_vm.dart';
import 'package:verifysafe/core/data/view_models/general_data_view_model.dart';
import 'package:verifysafe/core/data/view_models/user_view_model.dart';
import 'package:verifysafe/core/utilities/image_and_doc_utils.dart';
import 'package:verifysafe/core/utilities/validator.dart';
import 'package:verifysafe/ui/widgets/busy_overlay.dart';
import 'package:verifysafe/ui/widgets/display_image.dart';
import 'package:verifysafe/ui/widgets/show_flush_bar.dart';
import 'package:verifysafe/ui/widgets/verifysafe_container.dart';

import '../../../../core/constants/app_asset.dart';
import '../../../../core/constants/app_dimension.dart';
import '../../../widgets/bottom_sheets/base_bottom_sheet.dart';
import '../../../widgets/bottom_sheets/birth_date_selector_view.dart';
import '../../../widgets/clickable.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_radio_button.dart';
import '../../../widgets/custom_svg.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/screen_title.dart';
import '../../../widgets/upload_attachment.dart';

class IdentityVerification extends ConsumerStatefulWidget {
  final UserType userType;
  const IdentityVerification({super.key, required this.userType});

  @override
  ConsumerState<IdentityVerification> createState() =>
      _IdentityVerificationState();
}

class _IdentityVerificationState extends ConsumerState<IdentityVerification> {
  final _date = TextEditingController();
  final _identityNumber = TextEditingController();
  String photoUrl = 'userimage.jpg';
  String fileUrl = '';

  int? isRegisteredBusiness;

  bool showNINForm() =>
      widget.userType == UserType.worker ||
      (widget.userType == UserType.employer && isRegisteredBusiness == 1);

  _uploadImage() async {
    final generalVm = ref.watch(generalDataViewModel);
    final userVm = ref.watch(userViewModel);

    /// - use generalVM to upload image here.
    final base64String = await ImageAndDocUtils.pickAndCropImage(
      context: context,
    );
    if (base64String != null) {
      await generalVm.uploadImage(base64String: base64String);

      if (generalVm.generalUploadState == ViewState.retrieved) {
        photoUrl = generalVm.fileUploadsResponse.first.url ?? "";
        final details = {"avatar": generalVm.fileUploadsResponse.first.url};
        await userVm.updateUserData(details: details);
      } else {
        showFlushBar(
          context: context,
          message: generalVm.message,
          success: false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authVm = ref.watch(authenticationViewModel);
    final onboardingVm = ref.watch(onboardingViewModel);
    final generalVm = ref.watch(generalDataViewModel);
    final userVm = ref.watch(userViewModel);

    return BusyOverlay(
      show: onboardingVm.state == ViewState.busy,
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          showBottom: true,
          appbarBottomPadding: 10.h,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: AppDimension.paddingLeft,
            right: AppDimension.paddingRight,
            bottom: 40.h,
            top: 20.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScreenTitle(
                headerText: 'Identity Verification',
                secondSub: 'Please enter details below.',
              ),
              SizedBox(height: 16.h),
              userVm.avatar != null
                  ? VerifySafeContainer(
                      padding: EdgeInsets.all(16.w),
                      child: Row(
                        children: [
                          DisplayImage(image: userVm.avatar, size: 45),

                          SizedBox(width: 12.w),
                          Text(photoUrl.split("/").last),
                          SizedBox(width: 24.w),
                          Spacer(),
                          CustomButton(
                            buttonWidth: null,
                            buttonHeight: 36.h,
                            buttonHorizontalPadding: 14.w,
                            borderRadius: 16.r,
                            buttonText: 'Change Photo',
                            onPressed: _uploadImage,
                          ),
                        ],
                      ),
                    )
                  : UploadAttachment(
                      showPrefixIcon: false,
                      title: 'Upload Photo',
                      subtitle: 'PNG, JPG , JPEG',
                      buttonText:
                          generalVm.generalUploadState != ViewState.retrieved
                          ? 'Upload Photo'
                          : generalVm.fileUploadsResponse.first.url
                                    ?.split("/")
                                    .last ??
                                "",
                      onPressed: _uploadImage,
                    ),
              if (generalVm.generalUploadState == ViewState.busy)
                LinearProgressIndicator(
                  backgroundColor: Colors.transparent,
                  color: ColorPath.gulfBlue,
                  borderRadius: BorderRadius.circular(12.r),
                ),
              if (widget.userType == UserType.employer) businessType(),
              SizedBox(height: 24.h),
              if (showNINForm())
                CustomTextField(
                  hintText: 'Enter NIN',
                  label: 'National Identification Number (NIN)',
                  keyboardType: TextInputType.number,
                  controller: _identityNumber,
                  validator: FieldValidator.validate,
                  // suffixIcon: Padding(
                  //   padding: EdgeInsets.only(right: 16.w, left: 16.w),
                  //   child: CustomAssetViewer(
                  //     asset: AppAsset.check2,
                  //     height: 16.h,
                  //     width: 16.w,
                  //   ),
                  // ),
                )
              else
                CustomTextField(
                  hintText: 'Enter RC Number',
                  label: 'RC Number',
                  keyboardType: TextInputType.number,
                  controller: _identityNumber,
                  validator: FieldValidator.validate,
                  // suffixIcon: Padding(
                  //   padding: EdgeInsets.only(right: 16.w, left: 16.w),
                  //   child: CustomAssetViewer(
                  //     asset: AppAsset.check2,
                  //     height: 16.h,
                  //     width: 16.w,
                  //   ),
                  // ),
                ),
              SizedBox(height: 24.h),
              Clickable(
                onPressed: () {
                  baseBottomSheet(
                    context: context,
                    content: BirthdaySelectorView(
                      initialDate: DateFormat(
                        "yyyy-MM-dd",
                      ).tryParse(_date.text),
                      returningValue: (value) {
                        setState(() {
                          //set birthdate text controller
                          _date.text = value;
                        });
                      },
                    ),
                  );
                },
                child: CustomTextField(
                  label: showNINForm() ? 'Date of Birth' : 'Incorporation Date',
                  hintText: showNINForm()
                      ? 'Select D.O.B'
                      : 'Select Incorporation Date',
                  enabled: false,
                  controller: _date,
                  keyboardType: TextInputType.text,
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(right: 16.w, left: 16.w),
                    child: const CustomSvg(asset: AppAsset.calendar),
                  ),
                  //validator: FieldValidator.validate,
                ),
              ),
              SizedBox(height: 20.h),
              fileUrl.isNotEmpty
                  ? VerifySafeContainer(
                      padding: EdgeInsets.all(16.w),
                      child: Row(
                        children: [
                          CustomSvg(
                            asset: AppAsset.pdf,
                            height: 40.w,
                            width: 40.w,
                          ),

                          SizedBox(width: 12.w),
                          Text(fileUrl.split("/").last),
                          SizedBox(width: 24.w),
                          Spacer(),
                          CustomButton(
                            buttonWidth: null,
                            buttonHeight: 36.h,
                            buttonHorizontalPadding: 14.w,
                            borderRadius: 16.r,
                            buttonText: 'Change File',
                            onPressed: () async {
                              /// - use generalVM to upload image here.
                              final data =
                                  await ImageAndDocUtils.pickAndCropImage(
                                    context: context,
                                  );
                              if (data != null) {
                                await generalVm.uploadImage(
                                  base64String: data,
                                  isDoc: true,
                                );

                                if (generalVm.generalUploadState ==
                                    ViewState.retrieved) {
                                  fileUrl =
                                      generalVm.fileUploadsResponse.first.url ??
                                      "";
                                } else {
                                  showFlushBar(
                                    context: context,
                                    message: generalVm.message,
                                    success: false,
                                  );
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    )
                  : UploadAttachment(
                      title: showNINForm()
                          ? 'Upload (NIN)'
                          : 'Upload  CAC Certificate',
                      onPressed: () async {
                        /// - use generalVM to upload image here.
                        final data = await ImageAndDocUtils.pickAndCropImage(
                          context: context,
                        );
                        if (data != null) {
                          await generalVm.uploadImage(
                            base64String: data,
                            isDoc: true,
                          );

                          if (generalVm.generalUploadState ==
                              ViewState.retrieved) {
                            fileUrl =
                                generalVm.fileUploadsResponse.first.url ?? "";
                          } else {
                            showFlushBar(
                              context: context,
                              message: generalVm.message,
                              success: false,
                            );
                          }
                        }
                      },
                    ),
              if (generalVm.generalDocUploadState == ViewState.busy)
                LinearProgressIndicator(
                  backgroundColor: Colors.transparent,
                  color: ColorPath.gulfBlue,
                  borderRadius: BorderRadius.circular(12.r),
                ),
              SizedBox(height: 16.h),
              CustomButton(
                buttonText: 'Continue',
                onPressed: () async {
                  //validations:::
                  if (_identityNumber.text.isEmpty) {
                    return showFlushBar(
                      context: context,
                      message: "Enter ${showNINForm() ? "NIN" : "RC"} number",
                      success: false,
                    );
                  }
                  if (_date.text.isEmpty) {
                    return showFlushBar(
                      context: context,
                      message:
                          "Select ${showNINForm() ? "Date of Birth" : "Date of Incorporation"} number",
                      success: false,
                    );
                  }
                  await onboardingVm.verifyIdentity(
                    identityName: showNINForm() ? "nin" : "cac",
                    identityNumber: _identityNumber.text.trim(),
                    fileUrl: fileUrl,
                    associatedDate: _date.text,
                    userType: widget.userType,
                  );
                  if (onboardingVm.state == ViewState.retrieved) {
                    //update user onboarding data
                    authVm.authorizationResponse?.onboarding =
                        onboardingVm.userOnboardingData;
                    authVm.updateUI();
                    onboardingVm.handleOnboardingNavigation(
                      context: context,
                      userType: widget.userType,
                      currentStep:
                          onboardingVm.userOnboardingData?.currentStep ?? '',
                    );
                  } else {
                    showFlushBar(
                      context: context,
                      message: onboardingVm.message,
                      success: false,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  //for employer
  businessType() {
    return Padding(
      padding: EdgeInsets.only(top: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomRadioButton(
                onchanged: (value) {
                  if (value) {
                    setState(() {
                      isRegisteredBusiness = 0;
                    });
                  }
                },
                value: isRegisteredBusiness == 0,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'I have a registered business',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              CustomRadioButton(
                onchanged: (value) {
                  if (value) {
                    setState(() {
                      isRegisteredBusiness = 1;
                    });
                  }
                },
                value: isRegisteredBusiness == 1,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'I don’t have a registered business',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
