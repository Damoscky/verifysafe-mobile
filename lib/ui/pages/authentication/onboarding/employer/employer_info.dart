import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_dimension.dart';
import '../../../../../core/constants/named_routes.dart';
import '../../../../../core/data/enum/otp_type.dart';
import '../../../../../core/utilities/input_formatters/nigerian_phone_number_formatter.dart';
import '../../../../../core/utilities/navigator.dart';
import '../../../../../core/utilities/validator.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../../widgets/screen_title.dart';
import '../../otp.dart';

class EmployerInfo extends StatefulWidget {
  const EmployerInfo({super.key});

  @override
  State<EmployerInfo> createState() => _EmployerInfoState();
}

class _EmployerInfoState extends State<EmployerInfo> {

  String? _businessType, _nationality, _state;


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
              headerText: 'Employer Information',
              secondSub: 'Please enter details below.',
            ),
            SizedBox(height: 16.h,),
            CustomTextField(
              hintText: 'Company name',
              label: 'Company  Name',
              keyboardType: TextInputType.text,
              //controller: _email,
              validator: FieldValidator.validate,
            ),
            SizedBox(height: 16.h,),
            CustomDropdown(
              hintText: "Select Business Type",
              label: 'Business Type',
              value: _businessType,
              onChanged: (value){

              },
              items: ['Small', 'Large'],
            ),
            SizedBox(height: 16.h,),
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
            SizedBox(height: 16.h,),
            CustomTextField(
              label: 'Phone Number 2 (Optional)',
              hintText: '+234 000 000 0000',
              keyboardType: TextInputType.number,
              //controller: _phone,
              //focusNode: _phoneFn,
              onChanged: (value){
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(18),
                NigerianPhoneNumberFormatter()
              ],
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
            CustomDropdown(
              hintText: "Select Nationality",
              label: 'Nationality',
              value: _nationality,
              onChanged: (value){

              },
              items: ['Nigeria', 'Australia'],
            ),
            SizedBox(height: 16.h,),
            CustomDropdown(
              hintText: "Select State",
              label: 'State',
              value: _state,
              onChanged: (value){

              },
              items: ['Nigeria', 'Australia'],
            ),
            SizedBox(height: 16.h,),
            CustomTextField(
              hintText: 'Office address',
              label: 'Office Address',
              keyboardType: TextInputType.text,
              //controller: _email,
              validator: FieldValidator.validate,
            ),
            SizedBox(height: 16.h,),
            CustomTextField(
              hintText: 'website',
              label: 'Website (Optional)',
              keyboardType: TextInputType.text,
              //controller: _email,
              validator: FieldValidator.validate,
            ),
            SizedBox(height: 16.h,),
            CustomButton(
                buttonText: 'Continue',
                onPressed: (){
                  pushNavigation(context: context, widget: Otp(
                      otpType: OtpType.verifyEmail, identifier: 'dejbaba@gmail.com'), routeName: NamedRoutes.otp);
                }
            ),
          ],
        ),
      ),
    );
  }
}
