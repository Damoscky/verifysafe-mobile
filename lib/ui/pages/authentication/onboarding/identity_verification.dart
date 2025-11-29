import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/data/enum/user_type.dart';
import 'package:verifysafe/core/utilities/validator.dart';

import '../../../../core/constants/app_asset.dart';
import '../../../../core/constants/app_dimension.dart';
import '../../../widgets/bottom_sheets/base_bottom_sheet.dart';
import '../../../widgets/bottom_sheets/birth_date_selector_view.dart';
import '../../../widgets/clickable.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_radio_button.dart';
import '../../../widgets/custom_svg.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/screen_title.dart';
import '../../../widgets/upload_attachment.dart';

class IdentityVerification extends StatefulWidget {
  final UserType userType;
  const IdentityVerification({super.key,required this.userType});

  @override
  State<IdentityVerification> createState() => _IdentityVerificationState();
}

class _IdentityVerificationState extends State<IdentityVerification> {
  final _date = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          context: context,
          showBottom: true,
          appbarBottomPadding: 10.h,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: AppDimension.paddingLeft, right: AppDimension.paddingRight, bottom: 40.h, top: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScreenTitle(
              headerText: 'Identity Verification',
              secondSub: 'Please enter details below.',
            ),
            SizedBox(height: 16.h,),
            UploadAttachment(
              showPrefixIcon: false,
              title: 'Upload Photo',
              subtitle: 'PNG, JPG , JPEG',
              buttonText: 'Upload Photo',
              onPressed: (){},
            ),
            businessType(),
            SizedBox(height: 24.h,),
            if(1 + 1 == 3)CustomTextField(
              hintText: 'Enter NIN',
              label: 'National Identification Number (NIN)',
              keyboardType: TextInputType.number,
              //controller: _email,
              validator: FieldValidator.validate,
              suffixIcon: Padding(
                padding: EdgeInsets.only(right: 16.w, left: 16.w),
                child: CustomAssetViewer(
                  asset: AppAsset.check2,
                  height: 16.h,
                  width: 16.w,
                )
              ),
            )
            else CustomTextField(
              hintText: 'Enter RC Number',
              label: 'RC Number',
              keyboardType: TextInputType.number,
              //controller: _email,
              validator: FieldValidator.validate,
              suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 16.w, left: 16.w),
                  child: CustomAssetViewer(
                    asset: AppAsset.check2,
                    height: 16.h,
                    width: 16.w,
                  )
              ),
            ),
            SizedBox(height: 24.h,),
            Clickable(
              onPressed: (){
                baseBottomSheet(
                    context: context,
                    content: BirthdaySelectorView(
                        initialDate: DateFormat("dd-MM-yyyy").tryParse(_date.text),
                        returningValue: (value){
                          setState(() {
                            //set birthdate text controller
                            _date.text = value;
                          });
                        })
                );
              },
              child: CustomTextField(
                label: 1 + 1 == 3 ? 'Date of Birth':'Incorporation Date',
                hintText: 1 + 1 == 3 ? 'Select D.O.B':'Select Incorporation Date',
                enabled: false,
                controller: _date,
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
            UploadAttachment(
              title: 1 + 1 == 3 ? 'Upload (NIN)':'Upload  CAC Certificate',
              onPressed: (){},
            ),
            SizedBox(height: 16.h,),
            CustomButton(
                buttonText: 'Continue',
                onPressed: (){

                }
            )


          ],
        ),
      ),
    );
  }

  //for employer
  businessType(){
    return Padding(
      padding: EdgeInsets.only(top: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomRadioButton(

              ),
              SizedBox(width: 12.w,),
              Expanded(
                child:  Text(
                  'I have a registered business',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.textPrimary
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 16.h,),
          Row(
            children: [
              CustomRadioButton(), //todo: hide rc number and incorporation date sections
              SizedBox(width: 12.w,),
              Expanded(
                child:  Text(
                  'I don’t have a registered business',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.textPrimary
                  ),
                ),
              )
            ],
          ),

        ],
      ),
    );
  }
}
