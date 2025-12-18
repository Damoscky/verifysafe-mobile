import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';
// import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/view_models/general_data_view_model.dart';
import 'package:verifysafe/core/data/view_models/user_view_model.dart';
import 'package:verifysafe/core/utilities/input_formatters/nigerian_phone_number_formatter.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/core/utilities/utilities.dart';
import 'package:verifysafe/core/utilities/validator.dart';
// import 'package:verifysafe/ui/widgets/bottom_sheets/base_bottom_sheet.dart';
// import 'package:verifysafe/ui/widgets/bottom_sheets/birth_date_selector_view.dart';
import 'package:verifysafe/ui/widgets/busy_overlay.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/custom_button.dart';
import 'package:verifysafe/ui/widgets/custom_drop_down.dart';
// import 'package:verifysafe/ui/widgets/custom_svg.dart';
import 'package:verifysafe/ui/widgets/custom_text_field.dart';
import 'package:verifysafe/ui/widgets/screen_title.dart';
import 'package:verifysafe/ui/widgets/show_flush_bar.dart';

class EditUserInformation extends ConsumerStatefulWidget {
  const EditUserInformation({super.key});

  @override
  ConsumerState<EditUserInformation> createState() =>
      _EditUserInformationState();
}

class _EditUserInformationState extends ConsumerState<EditUserInformation> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _address = TextEditingController();
  // final TextEditingController _dob = TextEditingController();

  // final _formKey = GlobalKey<FormState>();

  int? _gender;
  String? _maritalStatus;
  // String? _nationality, _lga, _state;

  updateUserInfo() {
    final userVm = ref.watch(userViewModel);
    final userData = userVm.userData;
    if (userData != null) {
      _firstName.text = userData.name?.split(" ").first ?? '';
      _lastName.text = userData.name?.split(" ").last ?? '';
      _email.text = userData.email ?? '';
      _phoneNumber.text = Utilities.formatPhoneWithCode(
        phoneNumber: userData.phone ?? '',
      );
      _gender = userData.gender == 'male' ? 1 : 0;
      _maritalStatus = Utilities.capitalizeWord(userData.maritalStatus ?? "");
      _address.text = userData.residentialAddress ?? '';
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      updateUserInfo();
      _fetchCountries();
    });
  }

  _fetchCountries() async {
    if (ref.read(generalDataViewModel).countries.isEmpty) {
      ref.read(generalDataViewModel).fetchCountries();
    }
  }

  @override
  Widget build(BuildContext context) {
    final userVm = ref.watch(userViewModel);
    // final generalVm = ref.watch(generalDataViewModel);

    return BusyOverlay(
      show: userVm.state == ViewState.busy,
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          title:
              "${Utilities.capitalizeWord(userVm.userData?.userType ?? "")} Information",
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: AppDimension.paddingLeft,
            right: AppDimension.paddingRight,
            bottom: 40.h,
          ),
          child: Form(
            // key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenTitle(
                  //firstSubWidget: StepCounter(currentStep: 'basic info'),
                  // headerText: 'Basic Information',
                  secondSub:
                      "Update ${Utilities.capitalizeWord(userVm.userData?.userType ?? "")} Information below",
                ),
                SizedBox(height: 16.h),
                //Not updating
                CustomTextField(
                  hintText: 'first name',
                  label: 'First name',
                  keyboardType: TextInputType.text,
                  controller: _firstName,
                  validator: FieldValidator.validate,
                ),
                SizedBox(height: 16.h),
                   //Not updating
                CustomTextField(
                  hintText: 'last name',
                  label: 'Last name',
                  keyboardType: TextInputType.text,
                  controller: _lastName,
                  validator: FieldValidator.validate,
                ),
                SizedBox(height: 16.h),
                   //Not updating
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
                  items: ['Married', 'Single', "Widowed","Divorced",],
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  hintText: 'Email',
                  readOnly: true,
                  enabled: false,
                  fillColor: ColorPath.athensGrey5,
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  controller: _email,
                  validator: EmailValidator.validateEmail,
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  label: 'Phone Number',
                  hintText: '+234 000 000 0000',
                  readOnly: true,
                  enabled: false,
                  fillColor: ColorPath.athensGrey5,
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

                // Column(
                //   children: [
                //     SizedBox(height: 16.h),
                //     CustomDropdown(
                //       hintText: "Select Nationality",
                //       label: 'Nationality',
                //       value: _nationality,
                //       onChanged: (value) async {
                //         _nationality = value;
                //         generalVm.selectedCountry = generalVm.countries.firstWhere(
                //           (element) => element.name == value,
                //         );
                //         setState(() {});
                //         await generalVm.fetchStates();
                //       },
                //       enableSearch: true,
                //       items: generalVm.countries.map((e) => e.name ?? '').toList(),
                //     ),
                //     SizedBox(height: 16.h),
                //     CustomDropdown(
                //       hintText: "Select State",
                //       label: 'State',
                //       value: _state,
                //       enableSearch: true,
                //       onChanged: (value) async {
                //         _state = value;
                //         generalVm.selectedState = generalVm.states.firstWhere(
                //           (element) => element.name == value,
                //         );
                //         setState(() {});
                //         await generalVm.fetchCities();
                //       },
                //       items: generalVm.states.map((e) => e.name ?? '').toList(),
                //     ),
                //     SizedBox(height: 16.h),
                //     CustomDropdown(
                //       hintText: "Select City",
                //       label: 'City',
                //       value: _lga,
                //       enableSearch: true,
                //       onChanged: (value) {
                //         _lga = value;
                //         generalVm.selectedCity = generalVm.cities.firstWhere(
                //           (element) => element.name == value,
                //         );
                //         setState(() {});
                //       },
                //       items: generalVm.cities.map((e) => e.name ?? '').toList(),
                //     ),
                //   ],
                // ),
                SizedBox(height: 16.h),

                // Clickable(
                //   onPressed: () {
                //     baseBottomSheet(
                //       context: context,
                //       content: BirthdaySelectorView(
                //         initialDate: DateFormat(
                //           "dd-MM-yyyy",
                //         ).tryParse(_dob.text),
                //         returningValue: (value) {
                //           setState(() {
                //             //set birthdate text controller
                //             _dob.text = value;
                //             print(_dob.text);
                //           });
                //         },
                //       ),
                //     );
                //   },
                //   child: CustomTextField(
                //     label: 'Date Of Birth',
                //     hintText: 'Select Birth Date',
                //     enabled: false,
                //     controller: _dob,
                //     keyboardType: TextInputType.text,
                //     suffixIcon: Padding(
                //       padding: EdgeInsets.only(right: 16.w, left: 16.w),
                //       child: const CustomSvg(asset: AppAsset.calendar),
                //     ),
                //     //validator: FieldValidator.validate,
                //   ),
                // ),
                // SizedBox(height: 16.h),

                //worker-> "residential_address"
                CustomTextField(
                  hintText: 'address',
                  label: 'Address',
                  keyboardType: TextInputType.text,
                  controller: _address,
                  validator: FieldValidator.validate,
                ),
                SizedBox(height: 32.h),

                CustomButton(
                  buttonText: 'Continue',
                  onPressed: () async {
                    // final validate = _formKey.currentState!.validate();
                    // if (validate) {
                    Utilities.hideKeyboard(context);
                    await userVm.updateUserData(
                      details: {
                        "marital_status": _maritalStatus?.toLowerCase(),
                        "name": "${_firstName.text} ${_lastName.text}",
                        "residential_address": _address.text,
                        "gender": _gender == 0 ? 'female' : 'male',
                      },
                    );

                    if (userVm.state == ViewState.retrieved) {
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
                    // }
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
