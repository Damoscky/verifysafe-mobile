import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/view_models/authentication_vms/authentication_view_model.dart';
import 'package:verifysafe/core/data/view_models/authentication_vms/onboarding_vms/onboarding_vm.dart';
import 'package:verifysafe/core/data/view_models/general_data_view_model.dart';
import 'package:verifysafe/ui/pages/bottom_nav.dart';
import 'package:verifysafe/ui/widgets/busy_overlay.dart';
import 'package:verifysafe/ui/widgets/error_state.dart';
import 'package:verifysafe/ui/widgets/show_flush_bar.dart';

import '../../../../../core/constants/app_dimension.dart';
import '../../../../../core/constants/named_routes.dart';
import '../../../../../core/utilities/input_formatters/nigerian_phone_number_formatter.dart';
import '../../../../../core/utilities/navigator.dart';
import '../../../../../core/utilities/validator.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../../widgets/screen_title.dart';

class AgencyInfo extends ConsumerStatefulWidget {
  const AgencyInfo({super.key});

  @override
  ConsumerState<AgencyInfo> createState() => _AgencyInfoState();
}

class _AgencyInfoState extends ConsumerState<AgencyInfo> {
  String? _businessType, _nationality, _state;
  final TextEditingController _agencyName = TextEditingController();
  final TextEditingController _phone1 = TextEditingController();
  final TextEditingController _phone2 = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _officeAddress = TextEditingController();
  final TextEditingController _website = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchCountries();
    });
  }

  _fetchCountries() async {
    await ref.read(generalDataViewModel).fetchCountries();
  }

  @override
  Widget build(BuildContext context) {
    final generalVm = ref.watch(generalDataViewModel);
    final onboardingVm = ref.watch(onboardingViewModel);
    final authVm = ref.watch(authenticationViewModel);

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
          child: Builder(
            builder: (context) {
              if (generalVm.generalState == ViewState.error) {
                return Padding(
                  padding: const EdgeInsets.only(top: 175.0),
                  child: Center(
                    child: ErrorState(
                      onPressed: () {
                        _fetchCountries();
                      },
                      message: generalVm.message,
                    ),
                  ),
                );
              }
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ScreenTitle(
                      headerText: 'Agency Information',
                      secondSub: 'Please enter details below.',
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      hintText: 'Agency name',
                      label: 'Agency  Name',
                      keyboardType: TextInputType.text,
                      controller: _agencyName,
                      validator: FieldValidator.validate,
                    ),
                    SizedBox(height: 16.h),
                    CustomDropdown(
                      hintText: "Select Business Type",
                      label: 'Business Type',
                      value: _businessType,
                      onChanged: (value) {
                        _businessType = value;
                        setState(() {});
                      },
                      items: generalVm.businessType,
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      label: 'Phone Number 1',
                      hintText: '+234 000 000 0000',
                      keyboardType: TextInputType.number,
                      controller: _phone1,
                      //focusNode: _phoneFn,
                      validator: FieldValidator.validate,
                      onChanged: (value) {},
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(18),
                        NigerianPhoneNumberFormatter(),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      label: 'Phone Number 2',
                      hintText: '+234 000 000 0000',
                      keyboardType: TextInputType.number,
                      controller: _phone2,
                      //focusNode: _phoneFn,
                      // validator: FieldValidator.validate,
                      onChanged: (value) {},
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(18),
                        NigerianPhoneNumberFormatter(),
                      ],
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
                    CustomDropdown(
                      hintText: "Select Nationality",
                      label: 'Nationality',
                      value: _nationality,
                      onChanged: (value) async {
                        _nationality = value;
                        generalVm.selectedCountry = generalVm.countries
                            .firstWhere((element) => element.name == value);
                        setState(() {});
                        await generalVm.fetchStates();
                      },
                      enableSearch: true,
                      items: generalVm.countries
                          .map((e) => e.name ?? '')
                          .toList(),
                    ),
                    SizedBox(height: 16.h),
                    CustomDropdown(
                      hintText: "Select State",
                      label: 'State',
                      value: _state,
                      enableSearch: true,
                      onChanged: (value) {
                        _state = value;
                        generalVm.selectedState = generalVm.states.firstWhere(
                          (element) => element.name == value,
                        );
                        setState(() {});
                      },
                      items: generalVm.states.map((e) => e.name ?? '').toList(),
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      hintText: 'Office address',
                      label: 'Office Address',
                      keyboardType: TextInputType.text,
                      controller: _officeAddress,
                      validator: FieldValidator.validate,
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      hintText: 'website',
                      label: 'Website',
                      keyboardType: TextInputType.text,
                      controller: _website,
                      // validator: FieldValidator.validate,
                    ),
                    SizedBox(height: 16.h),
                    CustomButton(
                      buttonText: 'Continue',
                      onPressed: () async {
                        final validate = _formKey.currentState!.validate();
                        if (validate) {
                          if (_businessType == null) {
                            showFlushBar(
                              context: context,
                              message: "Select Business Type",
                              success: false,
                            );
                            return;
                          }
                          if (_nationality == null) {
                            showFlushBar(
                              context: context,
                              message: "Select Nationlity",
                              success: false,
                            );
                            return;
                          }
                          if (_state == null) {
                            showFlushBar(
                              context: context,
                              message: "Select State",
                              success: false,
                            );
                            return;
                          }

                          await onboardingVm.createAgencyInfo(
                            agencyName: _agencyName.text.trim(),
                            businessType: _businessType!,
                            email: _email.text.trim(),
                            phone: _phone1.text.replaceAll(" ", ""),
                            address: _officeAddress.text,
                            countryId: generalVm.selectedCountry?.id,
                            stateId: generalVm.selectedState?.id,
                            website: _website.text,
                            phone2: _phone2.text.replaceAll(" ", ""),
                          );

                          if (onboardingVm.state == ViewState.retrieved) {
                            //LOGIN USER
                            authVm.authorizationResponse =
                                onboardingVm.authorizationResponse;
                            pushAndClearAllNavigation(
                              context: context,
                              widget: BottomNav(
                                userData:
                                    onboardingVm.authorizationResponse?.user,
                              ),
                              routeName: NamedRoutes.bottomNav,
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
              );
            },
          ),
        ),
      ),
    );
  }
}
