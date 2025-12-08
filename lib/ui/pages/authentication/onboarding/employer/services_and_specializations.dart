import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/data/enum/user_type.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/view_models/authentication_vms/authentication_view_model.dart';
import 'package:verifysafe/core/data/view_models/authentication_vms/onboarding_vms/onboarding_vm.dart';
import 'package:verifysafe/core/data/view_models/general_data_view_model.dart';
import 'package:verifysafe/core/utilities/validator.dart';
import 'package:verifysafe/ui/widgets/busy_overlay.dart';
import 'package:verifysafe/ui/widgets/custom_text_field.dart';
import 'package:verifysafe/ui/widgets/show_flush_bar.dart';

import '../../../../../core/constants/app_dimension.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../../../../widgets/screen_title.dart';

class ServicesAndSpecializations extends ConsumerStatefulWidget {
  const ServicesAndSpecializations({super.key});

  @override
  ConsumerState<ServicesAndSpecializations> createState() =>
      _ServicesAndSpecializationsState();
}

class _ServicesAndSpecializationsState
    extends ConsumerState<ServicesAndSpecializations> {
  String? _trainingServices, _placementRegion, _placementTime;
  final _activeWorkers = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
                  headerText: 'Services & Specialisations',
                  secondSub: 'Please enter details below.',
                ),
                SizedBox(height: 16.h),
                // CustomDropdown(
                //   hintText: "Select Number of Active Workers",
                //   label: 'Number of Active Workers',
                //   value: _activeWorkers,
                //   onChanged: (value){

                //   },
                //   items: ['Small', 'Large'],
                // ),
                CustomTextField(
                  hintText: 'Enter value',
                  label: 'Number of Active Workers',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: _activeWorkers,
                  validator: FieldValidator.validate,
                ),
                SizedBox(height: 20.h),
                CustomDropdown(
                  hintText: "Select",
                  label: 'Training Services Provided?',
                  value: _trainingServices,
                  onChanged: (value) {
                    _trainingServices = value;
                    setState(() {});
                  },
                  items: ['Yes', 'No'],
                ),
                SizedBox(height: 20.h),
                CustomDropdown(
                  hintText: "Select Placement Regions",
                  label: 'Placement Regions Covered',
                  value: _placementRegion,
                  onChanged: (value) {
                    _placementRegion = value;
                    setState(() {});
                  },
                  items: generalVm.placementRegion,
                ),
                SizedBox(height: 20.h),
                CustomDropdown(
                  hintText: "Select Average Placement Time",
                  label: 'Average Placement Time',
                  value: _placementTime,
                  onChanged: (value) {
                    _placementTime = value;
                    setState(() {});
                  },
                  items: generalVm.averagePlacementTIme,
                ),
                SizedBox(height: 16.h),
                CustomButton(
                  buttonText: 'Continue',
                  onPressed: () async {
                    final validate = _formKey.currentState!.validate();
                    if (validate) {
                      if (_trainingServices == null) {
                        showFlushBar(
                          context: context,
                          message: "Select Training option",
                          success: false,
                        );
                        return;
                      }
                      if (_placementRegion == null) {
                        showFlushBar(
                          context: context,
                          message: "Select Placement Region",
                          success: false,
                        );
                        return;
                      }
                      if (_placementTime == null) {
                        showFlushBar(
                          context: context,
                          message: "Select Average Placement Time",
                          success: false,
                        );
                        return;
                      }
                      await onboardingVm.createServices(
                        activeWorkersCount: _activeWorkers.text,
                        trainingServiceProvided: _trainingServices == "Yes",
                        placementRegion: _placementRegion,
                        averagePlcementTime: _placementTime,
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
