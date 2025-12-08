import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/data/enum/user_type.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/view_models/authentication_vms/authentication_view_model.dart';
import 'package:verifysafe/core/data/view_models/authentication_vms/onboarding_vms/onboarding_vm.dart';
import 'package:verifysafe/core/data/view_models/general_data_view_model.dart';
import 'package:verifysafe/ui/widgets/busy_overlay.dart';
import 'package:verifysafe/ui/widgets/show_flush_bar.dart';

import '../../../../../core/constants/app_dimension.dart';
import '../../../../../core/utilities/input_formatters/nigerian_phone_number_formatter.dart';
import '../../../../../core/utilities/validator.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../../widgets/screen_title.dart';

class ContactPerson extends ConsumerStatefulWidget {
  const ContactPerson({super.key});

  @override
  ConsumerState<ContactPerson> createState() => _ContactPersonState();
}

class _ContactPersonState extends ConsumerState<ContactPerson> {
  String? _relationship, _lga, _state;
  final _name = TextEditingController();
  final _role = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _address = TextEditingController();

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
                  headerText: 'Contact Person',
                  secondSub: 'Please enter details below.',
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  hintText: 'Name',
                  label: 'Name',
                  keyboardType: TextInputType.text,
                  controller: _name,
                  validator: FieldValidator.validate,
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  hintText: 'Position/Role',
                  label: 'Position/Role',
                  keyboardType: TextInputType.text,
                  controller: _role,
                  validator: FieldValidator.validate,
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  hintText: 'Email',
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  controller: _email,
                  validator: EmailValidator.validateEmail,
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  label: 'Phone Number',
                  hintText: '+234 000 000 0000',
                  keyboardType: TextInputType.number,
                  controller: _phone,
                  //focusNode: _phoneFn,
                  validator: FieldValidator.validate,
                  onChanged: (value) {},
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(18),
                    NigerianPhoneNumberFormatter(),
                  ],
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
                  hintText: "Select Local Government Area",
                  label: 'Local Government Area',
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
                  hintText: 'Enter address',
                  label: 'Address',
                  keyboardType: TextInputType.text,
                  controller: _address,
                  validator: FieldValidator.validate,
                ),
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
                          message: "Select Contact Person Relationship",
                          success: false,
                        );
                        return;
                      }
                      if (_state == null) {
                        showFlushBar(
                          context: context,
                          message: "Select Contact Person State of Residence",
                          success: false,
                        );
                        return;
                      }
                      if (_lga == null) {
                        showFlushBar(
                          context: context,
                          message: "Select Contact Person LGA",
                          success: false,
                        );
                        return;
                      }

                      await onboardingVm.createContactPerson(
                        name: _name.text,
                        role: _role.text,
                        email: _email.text.trim(),
                        phone: _phone.text.replaceAll(" ", ""),
                        relationship: _relationship,
                        stateId: generalVm.selectedState?.id?.toString(),
                        cityId: generalVm.selectedState?.id?.toString(),
                        address: _address.text,
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
