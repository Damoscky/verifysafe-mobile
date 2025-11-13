import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';

import '../../../../core/constants/app_dimension.dart';
import '../../../../core/constants/color_path.dart';
import '../../../../core/utilities/input_formatters/nigerian_phone_number_formatter.dart';
import '../../../../core/utilities/validator.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_drop_down.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/screen_title.dart';

class GuarantorDetails extends StatefulWidget {
  const GuarantorDetails({super.key});

  @override
  State<GuarantorDetails> createState() => _GuarantorDetailsState();
}

class _GuarantorDetailsState extends State<GuarantorDetails> {

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
              headerText: 'Guarantor Details',
              secondSub: 'Please enter details below.',
            ),
            SizedBox(height: 16.h,),
            CustomTextField(
              hintText: 'Full name',
              label: 'Full name',
              keyboardType: TextInputType.text,
              //controller: _email,
              validator: FieldValidator.validate,
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
            CustomTextField(
              label: 'Phone Number 1',
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
            CustomTextField(
              label: 'Phone Number 2',
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
            CustomTextField(
              hintText: 'Email',
              label: 'Email',
              keyboardType: TextInputType.emailAddress,
              //controller: _email,
              validator: EmailValidator.validateEmail,
            ),
            SizedBox(height: 20.h,),
            CustomTextField(
              hintText: 'Enter Current Resident Address',
              label: 'Current Resident Address',
              keyboardType: TextInputType.text,
              //controller: _email,
              validator: FieldValidator.validate,
            ),
            SizedBox(height: 18.h,),
            ScreenTitle(
              headerText: 'Emergency Contact',
              secondSub: 'Please enter details below.',
            ),
            SizedBox(height: 16.h,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 24.h,
                  width: 24.w,
                  decoration: BoxDecoration(
                    color: 1 + 1 == 2 ? Colors.transparent:ColorPath.shamrockGreen,
                    border: Border.all(color: ColorPath.mischkaGrey, width: 1.w),
                    borderRadius: BorderRadius.all(Radius.circular(4.r))
                  ),
                  child: Center(
                    child: Icon(Icons.check, size: 16.w, color: Colors.white,),
                  ),
                ),
                SizedBox(width: 10.w,),
                Expanded(
                  child:  Text(
                    'My emergency contact is same as my GUARANTOR',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.textPrimary
                    ),
                  ),
                )
              ],
            ),
            emergencyContactForm(),
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

  emergencyContactForm(){
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            hintText: 'Full name',
            label: 'Full name',
            keyboardType: TextInputType.text,
            //controller: _email,
            validator: FieldValidator.validate,
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
          CustomTextField(
            label: 'Phone Number 1',
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
          CustomTextField(
            label: 'Phone Number 2',
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
        ],
      ),
    );
  }
}
