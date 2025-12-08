import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/models/reference_model.dart';
import 'package:verifysafe/core/data/view_models/authentication_vms/authentication_view_model.dart';
import 'package:verifysafe/core/data/view_models/authentication_vms/onboarding_vms/onboarding_vm.dart';
import 'package:verifysafe/core/data/view_models/general_data_view_model.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/widgets/busy_overlay.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/show_flush_bar.dart';

import '../../../../core/constants/app_dimension.dart';
import '../../../../core/constants/color_path.dart';
import '../../../../core/utilities/input_formatters/nigerian_phone_number_formatter.dart';
import '../../../../core/utilities/validator.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_drop_down.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/screen_title.dart';

class GuarantorDetails extends ConsumerStatefulWidget {
  const GuarantorDetails({super.key});

  @override
  ConsumerState<GuarantorDetails> createState() => _GuarantorDetailsState();
}

class _GuarantorDetailsState extends ConsumerState<GuarantorDetails> {
  String? _relationship, _lga, _state, _relationship2;
  final _guarantorName = TextEditingController();
  final _guarantorPhone = TextEditingController();
  final _guarantorEmail = TextEditingController();
  final _guarantorAddress = TextEditingController();

  bool isGuarantorEmergencyContact = false;

  final _emergencyName = TextEditingController();
  final _emergencyPhone = TextEditingController();
  final _emergencyEmail = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(generalDataViewModel).fetchStates(isNigerian: 1);
    });
    super.initState();
  }

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
                  headerText: 'Guarantor Details',
                  secondSub: 'Please enter details below.',
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  hintText: 'Full name',
                  label: 'Full name',
                  keyboardType: TextInputType.text,
                  controller: _guarantorName,
                  validator: FieldValidator.validate,
                ),
                SizedBox(height: 20.h),
                CustomDropdown(
                  hintText: "Select Relationship Type",
                  label: 'Relationship',
                  value: _relationship,
                  onChanged: (value) {
                    _relationship = value;
                    setState(() {});
                  },
                  items: generalVm.relationships,
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  label: 'Phone Number',
                  hintText: '+234 000 000 0000',
                  keyboardType: TextInputType.number,
                  controller: _guarantorPhone,
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
                  controller: _guarantorEmail,
                  validator: EmailValidator.validateEmail,
                ),
                SizedBox(height: 20.h),
                CustomDropdown(
                  hintText: "Select State of Residence",
                  label: 'State of Residence',
                  value: _state,
                  enableSearch: true,
                  onChanged: (value) async {
                    _state = value;
                    generalVm.selectedState = generalVm.states.firstWhere(
                      (element) => element.name == value,
                    );
                    setState(() {});
                    await generalVm.fetchCities();
                  },
                  items: generalVm.states.map((e) => e.name ?? "").toList(),
                ),
                SizedBox(height: 20.h),
                CustomDropdown(
                  hintText: "Select City",
                  label: 'City',
                  value: _lga,
                  enableSearch: true,
                  onChanged: (value) {
                    _lga = value;
                    generalVm.selectedCity = generalVm.cities.firstWhere(
                      (element) => element.name == value,
                    );
                    setState(() {});
                  },
                  items: generalVm.cities.map((e) => e.name ?? '').toList(),
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  hintText: 'Enter Current Resident Address',
                  label: 'Current Resident Address',
                  keyboardType: TextInputType.text,
                  controller: _guarantorAddress,
                  validator: FieldValidator.validate,
                ),
                SizedBox(height: 18.h),
                ScreenTitle(
                  headerText: 'Emergency Contact',
                  secondSub: 'Please enter details below.',
                ),
                SizedBox(height: 16.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Clickable(
                      onPressed: () {
                        //handle here
                        setState(() {
                          isGuarantorEmergencyContact =
                              !isGuarantorEmergencyContact;
                        });
                        // if()
                      },
                      child: Container(
                        height: 24.h,
                        width: 24.w,
                        decoration: BoxDecoration(
                          color: isGuarantorEmergencyContact
                              ? ColorPath.shamrockGreen
                              : Colors.transparent,
                          border: Border.all(
                            color: ColorPath.mischkaGrey,
                            width: 1.w,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(4.r)),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.check,
                            size: 16.w,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        'My emergency contact is same as my GUARANTOR',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                if (!isGuarantorEmergencyContact)
                  emergencyContactForm()
                else
                  SizedBox(height: 24.h),
                SizedBox(height: 16.h),
                CustomButton(
                  buttonText: 'Continue',
                  onPressed: () async {
                    final validate = _formKey.currentState!.validate();
                    if (validate) {
                      if (_relationship == null) {
                        //Validations
                        showFlushBar(
                          context: context,
                          message: "Select Guarantor Relationship",
                          success: false,
                        );
                        return;
                      }
                      if (_state == null) {
                        showFlushBar(
                          context: context,
                          message: "Select Guarantor State of Residence",
                          success: false,
                        );
                        return;
                      }
                      if (_lga == null) {
                        showFlushBar(
                          context: context,
                          message: "Select Guarantor City of Residence",
                          success: false,
                        );
                        return;
                      }
                      if (!isGuarantorEmergencyContact &&
                          _emergencyName.text.isEmpty) {
                        showFlushBar(
                          context: context,
                          message: "Provide Contact Person Name",
                          success: false,
                        );
                        return;
                      }
                      if (!isGuarantorEmergencyContact &&
                          _relationship2 == null) {
                        showFlushBar(
                          context: context,
                          message: "Select Contact Person Relationship",
                          success: false,
                        );
                        return;
                      }
                      if (!isGuarantorEmergencyContact &&
                          _emergencyPhone.text.isEmpty) {
                        showFlushBar(
                          context: context,
                          message: "Provide Contact Person Phone Number",
                          success: false,
                        );
                        return;
                      }
                      if (!isGuarantorEmergencyContact &&
                          _emergencyEmail.text.isEmpty) {
                        showFlushBar(
                          context: context,
                          message: "Provide Contact Person Email",
                          success: false,
                        );
                        return;
                      }

                      final guarantor = ReferenceModel(
                        name: _guarantorName.text,
                        relationship: _relationship,
                        phone: _guarantorPhone.text,
                        email: _guarantorEmail.text,
                        stateId: generalVm.selectedState?.id?.toString(),
                        cityId: generalVm.selectedCity?.id?.toString(),
                        address: _guarantorAddress.text,
                        referenceType: 'guarantor',
                      );
                      final contact = ReferenceModel(
                        name: isGuarantorEmergencyContact
                            ? _guarantorName.text
                            : _emergencyName.text,
                        relationship: isGuarantorEmergencyContact
                            ? _relationship
                            : _relationship2,
                        phone: isGuarantorEmergencyContact
                            ? _guarantorPhone.text
                            : _emergencyPhone.text,
                        email: isGuarantorEmergencyContact
                            ? _guarantorEmail.text
                            : _emergencyEmail.text,
                        referenceType: 'emergency_contact',
                      );
                      onboardingVm.updateReference(0, guarantor);
                      onboardingVm.updateReference(1, contact);

                      await onboardingVm.createReference();
                      if (onboardingVm.state == ViewState.retrieved) {
                        //update user onboarding data
                        authVm.authorizationResponse?.onboarding =
                            onboardingVm.userOnboardingData;
                        authVm.updateUI();

                        //pop at form completion
                        popNavigation(context: context);
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

  emergencyContactForm() {
    final generalVm = ref.watch(generalDataViewModel);

    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            hintText: 'Full name',
            label: 'Full name',
            keyboardType: TextInputType.text,
            controller: _emergencyName,
            // validator: FieldValidator.validate,
          ),
          SizedBox(height: 20.h),
          CustomDropdown(
            hintText: "Select Relationship Type",
            label: 'Relationship',
            value: _relationship2,
            onChanged: (value) {
              _relationship2 = value;
              setState(() {});
            },
            items: generalVm.relationships,
          ),
          SizedBox(height: 20.h),
          CustomTextField(
            label: 'Phone Number',
            hintText: '+234 000 000 0000',
            keyboardType: TextInputType.number,
            controller: _emergencyPhone,
            //focusNode: _phoneFn,
            // validator: FieldValidator.validate,
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
            controller: _emergencyEmail,
            // validator: EmailValidator.validateEmail,
          ),
        ],
      ),
    );
  }
}
