import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:verifysafe/core/utilities/navigator.dart';

import '../../../../../core/constants/app_asset.dart';
import '../../../../../core/constants/app_dimension.dart';
import '../../../../../core/utilities/input_formatters/nigerian_phone_number_formatter.dart';
import '../../../../../core/utilities/validator.dart';
import '../../../../widgets/bottom_sheets/base_bottom_sheet.dart';
import '../../../../widgets/bottom_sheets/birth_date_selector_view.dart';
import '../../../../widgets/clickable.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../../../../widgets/custom_svg.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../../widgets/screen_title.dart';

class AddWorkHistory extends StatefulWidget {
  const AddWorkHistory({super.key});

  @override
  State<AddWorkHistory> createState() => _AddWorkHistoryState();
}

class _AddWorkHistoryState extends State<AddWorkHistory> {

  String? _jobCategory, _lga, _state;
  final _startDate = TextEditingController();
  final _endDate = TextEditingController();

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
              headerText: 'Work History',
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
            CustomDropdown(
              hintText: "Select Job Category",
              label: 'Job Category',
              value: _jobCategory,
              onChanged: (value){

              },
              items: ['Small', 'Large'],
            ),
            SizedBox(height: 20.h,),
            CustomTextField(
              hintText: 'Enter Specific Role',
              label: 'Specific Role',
              keyboardType: TextInputType.text,
              //controller: _email,
              validator: FieldValidator.validate,
            ),
            SizedBox(height: 20.h,),
            CustomTextField(
              label: 'Employer Phone',
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
            Clickable(
              onPressed: (){
                baseBottomSheet(
                    context: context,
                    content: BirthdaySelectorView(
                        initialDate: DateFormat("dd-MM-yyyy").tryParse(_startDate.text),
                        returningValue: (value){
                          setState(() {
                            //set birthdate text controller
                            _startDate.text = value;
                          });
                        })
                );
              },
              child: CustomTextField(
                label: 'Start Date',
                hintText: 'Select Start Date',
                enabled: false,
                controller: _startDate,
                keyboardType: TextInputType.text,
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 16.w, left: 16.w),
                  child: const CustomSvg(
                      asset:AppAsset.calendar),
                ),
                //validator: FieldValidator.validate,
              ),
            ),
            SizedBox(height: 20.h,),
            Clickable(
              onPressed: (){
                baseBottomSheet(
                    context: context,
                    content: BirthdaySelectorView(
                        initialDate: DateFormat("dd-MM-yyyy").tryParse(_endDate.text),
                        returningValue: (value){
                          setState(() {
                            //set birthdate text controller
                            _endDate.text = value;
                          });
                        })
                );
              },
              child: CustomTextField(
                label: 'End Date',
                hintText: 'Select End Date',
                enabled: false,
                controller: _endDate,
                keyboardType: TextInputType.text,
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 16.w, left: 16.w),
                  child: const CustomSvg(
                      asset:AppAsset.calendar),
                ),
                //validator: FieldValidator.validate,
              ),
            ),
            SizedBox(height: 16.h,),
            CustomButton(
                buttonText: 'Add',
                onPressed: (){
                  popNavigation(context: context);

                }
            ),
          ],
        ),
      ),
    );
  }
}
