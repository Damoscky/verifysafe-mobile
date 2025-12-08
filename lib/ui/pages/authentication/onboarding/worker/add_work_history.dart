import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:verifysafe/core/data/models/work_history.dart';
import 'package:verifysafe/core/data/view_models/authentication_vms/onboarding_vms/onboarding_vm.dart';
import 'package:verifysafe/core/data/view_models/general_data_view_model.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/widgets/show_flush_bar.dart';

import '../../../../../core/constants/app_asset.dart';
import '../../../../../core/constants/app_dimension.dart';
import '../../../../../core/utilities/input_formatters/nigerian_phone_number_formatter.dart';
import '../../../../../core/utilities/validator.dart';
import '../../../../widgets/bottom_sheets/base_bottom_sheet.dart';
import '../../../../widgets/bottom_sheets/birth_date_selector_view.dart';
import '../../../../widgets/clickable.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../../../../widgets/custom_svg.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../../widgets/screen_title.dart';

class AddWorkHistory extends ConsumerStatefulWidget {
  const AddWorkHistory({super.key});

  @override
  ConsumerState<AddWorkHistory> createState() => _AddWorkHistoryState();
}

class _AddWorkHistoryState extends ConsumerState<AddWorkHistory> {
  String? _jobCategory, _jobRole, _employmentType;
  final _startDate = TextEditingController();
  final _endDate = TextEditingController();
  final _employerName = TextEditingController();
  final _employerPhone = TextEditingController();
  final _employerEmail = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final onboardingVm = ref.watch(onboardingViewModel);
    final generalVm = ref.watch(generalDataViewModel);
    return Scaffold(
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
                headerText: 'Work History',
                secondSub: 'Please enter details below.',
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                hintText: 'Employer name',
                label: 'Employer Name',
                keyboardType: TextInputType.text,
                controller: _employerName,
                validator: FieldValidator.validate,
              ),
              SizedBox(height: 20.h),
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
              SizedBox(height: 20.h),
              CustomDropdown(
                hintText: "Select Specific Role",
                label: 'Specific Role',
                value: _jobRole,
                onChanged: (value) {
                  _jobRole = value;
                  setState(() {});
                },
                items: generalVm.jobRole,
              ),
              // CustomTextField(
              //   hintText: 'Enter Specific Role',
              //   label: 'Specific Role',
              //   keyboardType: TextInputType.text,
              //   //controller: _email,
              //   validator: FieldValidator.validate,
              // ),
              SizedBox(height: 20.h),
              CustomDropdown(
                hintText: "Select Employment Type",
                label: 'Employment Type',
                value: _employmentType,
                onChanged: (value) {
                  _employmentType = value;
                  setState(() {});
                },
                items: ["Full TIme", "Part Time", "Contract"],
              ),
              SizedBox(height: 20.h),
              CustomTextField(
                label: 'Employer Phone',
                hintText: '+234 000 000 0000',
                keyboardType: TextInputType.number,
                controller: _employerPhone,
                //focusNode: _phoneFn,
                validator: FieldValidator.validate,
                onChanged: (value) {},
                inputFormatters: [
                  LengthLimitingTextInputFormatter(18),
                  NigerianPhoneNumberFormatter(),
                ],
              ),
              SizedBox(height: 20.h),
              CustomTextField(
                hintText: 'Email',
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                controller: _employerEmail,
                validator: EmailValidator.validateEmail,
              ),
              SizedBox(height: 20.h),
              Clickable(
                onPressed: () {
                  baseBottomSheet(
                    context: context,
                    content: BirthdaySelectorView(
                      initialDate: DateFormat(
                        "dd-MM-yyyy",
                      ).tryParse(_startDate.text),
                      returningValue: (value) {
                        setState(() {
                          //set birthdate text controller
                          _startDate.text = value;
                          print(_startDate.text);

                        });
                      },
                    ),
                  );
                },
                child: CustomTextField(
                  label: 'Start Date',
                  hintText: 'Select Start Date',
                  enabled: false,
                  controller: _startDate,
                  keyboardType: TextInputType.text,
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(right: 16.w, left: 16.w),
                    child: const CustomSvg(asset: AppAsset.calendar),
                  ),
                  //validator: FieldValidator.validate,
                ),
              ),
              SizedBox(height: 20.h),
              Clickable(
                onPressed: () {
                  baseBottomSheet(
                    context: context,
                    content: BirthdaySelectorView(
                      initialDate: DateFormat(
                        "dd-MM-yyyy",
                      ).tryParse(_endDate.text),
                      returningValue: (value) {
                        setState(() {
                          //set birthdate text controller
                          _endDate.text = value;
                        });
                      },
                    ),
                  );
                },
                child: CustomTextField(
                  label: 'End Date',
                  hintText: 'Select End Date',
                  enabled: false,
                  controller: _endDate,
                  keyboardType: TextInputType.text,
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(right: 16.w, left: 16.w),
                    child: const CustomSvg(asset: AppAsset.calendar),
                  ),
                  //validator: FieldValidator.validate,
                ),
              ),
              SizedBox(height: 16.h),
              CustomButton(
                buttonText: 'Add',
                onPressed: () {
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
                    if (_jobRole == null) {
                      showFlushBar(
                        context: context,
                        message: "Select Specific Role",
                        success: false,
                      );
                      return;
                    }
                    if (_employmentType == null) {
                      showFlushBar(
                        context: context,
                        message: "Select Employment Type",
                        success: false,
                      );
                      return;
                    }
                    if (_startDate.text.isEmpty) {
                      showFlushBar(
                        context: context,
                        message: "Select Start Date",
                        success: false,
                      );
                      return;
                    }
                    final data = WorkHistoryModel(
                      employerName: _employerName.text,
                      category: _jobCategory,
                      jobRole: _jobRole,
                      phone: _employerPhone.text.replaceAll(" ", ""),
                      email: _employerEmail.text,
                      employmentType: _employmentType,
                      endDate: _endDate.text,
                      startDate: _startDate.text,
                    );

                    onboardingVm.workHistory.add(data);
                    onboardingVm.updateUI();
                    popNavigation(context: context);
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
