import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/data/view_models/guarantor_view_models/guarantor_view_model.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/widgets/busy_overlay.dart';

import '../../../core/constants/app_dimension.dart';
import '../../../core/data/enum/view_state.dart';
import '../../../core/data/view_models/general_data_view_model.dart';
import '../../../core/utilities/input_formatters/nigerian_phone_number_formatter.dart';
import '../../../core/utilities/validator.dart';
import '../../widgets/bottom_sheets/action_completed.dart';
import '../../widgets/bottom_sheets/base_bottom_sheet.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_drop_down.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/show_flush_bar.dart';

class AddGuarantor extends ConsumerStatefulWidget {
  const AddGuarantor({super.key});

  @override
  ConsumerState<AddGuarantor> createState() => _AddGuarantorState();
}

class _AddGuarantorState extends ConsumerState<AddGuarantor> {

  final _formKey = GlobalKey<FormState>();
  String? _relationship, _lga, _state;
  final _guarantorName = TextEditingController();
  final _guarantorPhone = TextEditingController();
  final _guarantorEmail = TextEditingController();
  final _guarantorAddress = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(generalDataViewModel).fetchStates(isNigerian: 1);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final generalVm = ref.watch(generalDataViewModel);
    final vm = ref.watch(guarantorViewModel);
    return BusyOverlay(
      show: vm.secondState == ViewState.busy,
      child: Scaffold(
        appBar: customAppBar(
            context: context,
            title: 'Add Guarantor',
            showBottom: true,
            appbarBottomPadding: 10.h,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: AppDimension.paddingLeft, right: AppDimension.paddingRight, bottom: 40.h, top: 20.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  hintText: 'Full name',
                  label: 'Full Name',
                  keyboardType: TextInputType.text,
                  controller: _guarantorName,
                  validator: FieldValidator.validate,
                ),

                SizedBox(height: 16.h,),
                CustomDropdown(
                  hintText: "Select Relationship",
                  label: 'Relationship',
                  value: _relationship,
                  onChanged: (value){
                    _relationship = value;
                    setState(() {});
                  },
                  items: generalVm.relationships,
                ),
                SizedBox(height: 16.h,),
                CustomTextField(
                  hintText: 'Email',
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  controller: _guarantorEmail,
                  validator: EmailValidator.validateEmail,
                ),
                SizedBox(height: 16.h,),
                CustomTextField(
                  label: 'Phone Number',
                  hintText: '+234 000 000 0000',
                  keyboardType: TextInputType.number,
                  controller: _guarantorPhone,
                  //focusNode: _phoneFn,
                  validator: FieldValidator.validate,
                  onChanged: (value){
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(18),
                    NigerianPhoneNumberFormatter()
                  ],
                ),
                SizedBox(height: 16.h,),
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
                SizedBox(height: 16.h,),
                CustomTextField(
                  hintText: 'Address',
                  label: 'Address',
                  keyboardType: TextInputType.text,
                  controller: _guarantorAddress,
                  validator: FieldValidator.validate,
                ),
                SizedBox(height: 16.h,),
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
                SizedBox(height: 32.h,),
                CustomButton(
                    buttonText: 'Save',
                    onPressed: (){
                      final validate = _formKey.currentState!.validate();
                      if(validate){
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

                        baseBottomSheet(
                          context: context,
                          content: ActionCompleted(
                            asset: AppAsset.actionConfirmation,
                            title: 'Submit',
                            subtitle: 'Are you sure you want to add new Guarantor?',
                            buttonText: 'Yes, Submit',
                            onPressed: ()async{
                              popNavigation(context: context);

                              await vm.addGuarantor(
                                name: _guarantorName.text,
                                email: _guarantorEmail.text,
                                address: _guarantorAddress.text,
                                 relationship: _relationship,
                                phone: _guarantorPhone.text,
                                stateId: generalVm.selectedState?.id,
                                  cityId: generalVm.selectedCity?.id
                              );

                              if(vm.secondState == ViewState.retrieved){
                                popNavigation(context: context);
                              }

                              showFlushBar(
                                  context: context,
                                  message: vm.message,
                                success: vm.secondState == ViewState.retrieved
                              );


                            },
                          ),
                        );

                      }

                    }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
