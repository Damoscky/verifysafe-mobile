import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_dimension.dart';
import '../../../../../core/utilities/validator.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../../widgets/screen_title.dart';
import '../../../../widgets/upload_attachment.dart';

class EmploymentDetails extends StatefulWidget {
  const EmploymentDetails({super.key});

  @override
  State<EmploymentDetails> createState() => _EmploymentDetailsState();
}

class _EmploymentDetailsState extends State<EmploymentDetails> {

  String? _jobCategory, _willingToRelocate;

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
              headerText: 'Employment Details',
              secondSub: 'Please enter details below.',
            ),
            SizedBox(height: 16.h,),
            CustomDropdown(
              hintText: "Select Job Category",
              label: 'Job Category',
              value: _jobCategory,
              onChanged: (value){

              },
              items: ['Small', 'Large'],
            ),
            SizedBox(height: 16.h,),
            CustomTextField(
              label: 'Specific Role',
              hintText: 'Enter Specific Role',
              keyboardType: TextInputType.text,
              //controller: _phone,
              //focusNode: _phoneFn,
              validator: FieldValidator.validate,
              onChanged: (value){
              },
            ),
            SizedBox(height: 16.h,),
            CustomTextField(
              label: 'Languages Spoken',
              hintText: 'Enter Languages Spoken',
              keyboardType: TextInputType.text,
              //controller: _phone,
              //focusNode: _phoneFn,
              validator: FieldValidator.validate,
              onChanged: (value){
              },
            ),
            SizedBox(height: 16.h,),
            CustomTextField(
              label: 'Years of Experience',
              hintText: 'Enter Years of Experience',
              keyboardType: TextInputType.text,
              //controller: _phone,
              //focusNode: _phoneFn,
              validator: FieldValidator.validate,
              onChanged: (value){
              },
            ),
            SizedBox(height: 16.h,),
            CustomDropdown(
              hintText: "Select",
              label: 'Willingness to Relocate?',
              value: _willingToRelocate,
              onChanged: (value){

              },
              items: ['Small', 'Large'],
            ),
            SizedBox(height: 16.h,),
            UploadAttachment(
              title: 'Upload Resume',
              onPressed: (){},
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
