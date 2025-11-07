import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/utilities/navigator.dart';

import '../../../core/constants/app_dimension.dart';
import '../../../core/utilities/input_formatters/nigerian_phone_number_formatter.dart';
import '../../../core/utilities/validator.dart';
import '../../widgets/bottom_sheets/action_completed.dart';
import '../../widgets/bottom_sheets/base_bottom_sheet.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_drop_down.dart';
import '../../widgets/custom_text_field.dart';

class AddGuarantor extends StatefulWidget {
  const AddGuarantor({super.key});

  @override
  State<AddGuarantor> createState() => _AddGuarantorState();
}

class _AddGuarantorState extends State<AddGuarantor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          context: context,
          title: 'Add Guarantor',
          showBottom: true,
          appbarBottomPadding: 10.h,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: AppDimension.paddingLeft, right: AppDimension.paddingRight, bottom: 40.h, top: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              hintText: 'Full name',
              label: 'Full Name',
              keyboardType: TextInputType.text,
              //controller: _email,
              validator: FieldValidator.validate,
            ),

            SizedBox(height: 16.h,),
            CustomDropdown(
              hintText: "Select Relationship",
              label: 'Relationship',
              onChanged: (value){

              },
              items: ['Small', 'Large'],
            ),
            SizedBox(height: 16.h,),
            CustomTextField(
              hintText: 'Email',
              label: 'Email',
              keyboardType: TextInputType.emailAddress,
              //controller: _email,
              validator: EmailValidator.validateEmail,
            ),
            SizedBox(height: 16.h,),
            CustomTextField(
              label: 'Phone Number',
              hintText: '+234 000 000 0000',
              keyboardType: TextInputType.number,
              //controller: _phone,
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
              onChanged: (value){

              },
              items: ['Nigeria', 'Australia'],
            ),
            SizedBox(height: 16.h,),
            CustomTextField(
              hintText: 'Address',
              label: 'Address',
              keyboardType: TextInputType.text,
              //controller: _email,
              validator: FieldValidator.validate,
            ),
            SizedBox(height: 16.h,),
            CustomDropdown(
              hintText: "Select Local Government Area",
              label: 'Local Government Area',
              onChanged: (value){

              },
              items: ['Nigeria', 'Australia'],
            ),
            SizedBox(height: 16.h,),
            CustomButton(
                buttonText: 'Save',
                onPressed: (){
                  baseBottomSheet(
                    context: context,
                    content: ActionCompleted(
                      asset: AppAsset.actionConfirmation,
                      title: 'Submit',
                      subtitle: 'Are you sure you want to add new Guarantor?',
                      buttonText: 'Yes, Submit',
                      onPressed: (){
                        popNavigation(context: context);
                      },
                    ),
                  );

                }
            ),
          ],
        ),
      ),
    );
  }
}
