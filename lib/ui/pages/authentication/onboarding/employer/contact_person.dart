import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_dimension.dart';
import '../../../../../core/utilities/input_formatters/nigerian_phone_number_formatter.dart';
import '../../../../../core/utilities/validator.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../../widgets/screen_title.dart';

class ContactPerson extends StatefulWidget {
  const ContactPerson({super.key});

  @override
  State<ContactPerson> createState() => _ContactPersonState();
}

class _ContactPersonState extends State<ContactPerson> {

  String? _relationship, _lga, _state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: AppDimension.paddingLeft, right: AppDimension.paddingRight, bottom: 40.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScreenTitle(
              headerText: 'Contact Person',
              secondSub: 'Please enter details below.',
            ),
            SizedBox(height: 16.h,),
            CustomTextField(
              hintText: 'Employer name',
              label: 'Employer Name',
              keyboardType: TextInputType.text,
              //controller: _email,
              validator: FieldValidator.validate,
            ),
            SizedBox(height: 20.h,),
            CustomTextField(
              hintText: 'Position/Role',
              label: 'Position/Role',
              keyboardType: TextInputType.text,
              //controller: _email,
              validator: FieldValidator.validate,
            ),
            SizedBox(height: 20.h,),
            CustomTextField(
              hintText: 'Email',
              label: 'Email',
              keyboardType: TextInputType.emailAddress,
              //controller: _email,
              validator: EmailValidator.validateEmail,
            ),
            SizedBox(height: 20.h,),
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
            SizedBox(height: 20.h,),
            CustomDropdown(
              hintText: "Select Relationship Type",
              label: 'Relationship',
              value: _relationship,
              onChanged: (value){

              },
              items: ['Small', 'Large'],
            ),
            SizedBox(height: 20.h,),
            CustomDropdown(
              hintText: "Select State of Residence",
              label: 'State of Residence',
              value: _relationship,
              onChanged: (value){

              },
              items: ['Small', 'Large'],
            ),
            SizedBox(height: 20.h,),
            CustomDropdown(
              hintText: "Select Local Government Area",
              label: 'Local Government Area',
              value: _lga,
              onChanged: (value){

              },
              items: ['Nigeria', 'Australia'],
            ),
            SizedBox(height: 20.h,),
            CustomTextField(
              hintText: 'Enter address',
              label: 'Address',
              keyboardType: TextInputType.text,
              //controller: _email,
              validator: FieldValidator.validate,
            ),
            SizedBox(height: 16.h,),
            CustomButton(
                buttonText: 'Continue',
                onPressed: (){

                }
            ),
          ],
        ),
      ),
    );
  }
}
