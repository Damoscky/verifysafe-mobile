import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/models/user.dart';
import 'package:verifysafe/core/data/view_models/general_data_view_model.dart';
import 'package:verifysafe/core/data/view_models/user_view_model.dart';
import 'package:verifysafe/core/utilities/image_and_doc_utils.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/core/utilities/utilities.dart';
import 'package:verifysafe/ui/widgets/busy_overlay.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/custom_button.dart';
import 'package:verifysafe/ui/widgets/custom_drop_down.dart';
import 'package:verifysafe/ui/widgets/custom_text_field.dart';
import 'package:verifysafe/ui/widgets/screen_title.dart';
import 'package:verifysafe/ui/widgets/show_flush_bar.dart';
import 'package:verifysafe/ui/widgets/upload_attachment.dart';
import '../../../../../core/constants/app_dimension.dart';
import '../../../../../core/utilities/validator.dart';

class EditEmploymentDetails extends ConsumerStatefulWidget {
  final WorkerInfo workerInfo;
  const EditEmploymentDetails({super.key, required this.workerInfo});

  @override
  ConsumerState<EditEmploymentDetails> createState() =>
      _EmploymentDetailsState();
}

class _EmploymentDetailsState extends ConsumerState<EditEmploymentDetails> {
  String? _jobCategory, _willingToRelocate;
  final _role = TextEditingController();
  final _language = TextEditingController();
  final _experience = TextEditingController();
  String fileUrl = '';

  @override
  void initState() {
    super.initState();
    _updateData();
  }

  _updateData() {
    _jobCategory = widget.workerInfo.jobCategory;
    _role.text = widget.workerInfo.jobRole ?? '';
    _language.text = widget.workerInfo.language ?? '';
    _experience.text = widget.workerInfo.experience ?? '';
    _willingToRelocate = (widget.workerInfo.relocatable == 1 || widget.workerInfo.relocatable == true ) ? "Yes" : "No";
    fileUrl = widget.workerInfo.resumeUrl ?? '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final userVm = ref.watch(userViewModel);
    final generalVm = ref.watch(generalDataViewModel);

    return BusyOverlay(
      show: userVm.state == ViewState.busy,
      child: Scaffold(
        appBar: customAppBar(context: context, title: "Employment Details"),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: AppDimension.paddingLeft,
            right: AppDimension.paddingRight,
            bottom: 40.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScreenTitle(secondSub: 'Update employment details below'),
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

                  if (generalVm.generalUploadState == ViewState.retrieved) {
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
                buttonText: 'Save',
                onPressed: () async {
                  Utilities.hideKeyboard(context);
                  await userVm.updateEmploymentDetails(
                    category: _jobCategory!,
                    jobRole: _role.text,
                    experience: _experience.text,
                    language: _language.text,
                    relocateable: _willingToRelocate == "Yes" ? "1" : "0",
                    resumeUrl: fileUrl,
                  );
                  if (userVm.state == ViewState.retrieved) {
                    popNavigation(context: context);
                    popNavigation(context: context);
                    showFlushBar(
                      context: context,
                      message: userVm.message,
                      success: true,
                    );
                  } else {
                    showFlushBar(
                      context: context,
                      message: userVm.message,
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
}
