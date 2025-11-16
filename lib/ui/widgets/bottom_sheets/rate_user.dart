import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';

import '../../../core/constants/color_path.dart';
import '../custom_button.dart';
import '../custom_drop_down.dart';
import '../custom_text_field.dart';
import '../rate_widget.dart';

class RateUser extends StatelessWidget {
  const RateUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: AppDimension.bottomSheetPaddingLeft, right: AppDimension.bottomSheetPaddingRight, top: 45.h, bottom: 31.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            1 + 1 == 2 ? 'Rate Employer':'Rate Worker',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.textPrimary
            ),
          ),
          SizedBox(height: 20.h,),
          Text(
            'How was your experience working here?',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.textPrimary
            ),
          ),
          SizedBox(height: 20.h,),
          Rate(
            onSelect: (value) {
              print(value);
            },
          ),
          SizedBox(height: 16.h,),
          CustomDropdown(
            hintText: "Select a Reason",
            label: 'Select Reason',
            fillColor: Colors.white,
            onChanged: (value){

            },
            items: ['Nigeria', 'Australia'],
          ),
          SizedBox(height: 16.h,),
          CustomTextField(
            hintText: 'Got any comments?',
            label: 'Comments',
            useDefaultHeight: false,
            fillColor: Colors.white,
            maxLines: 3,
            keyboardType: TextInputType.text,
            //controller: _email,
          ),
          SizedBox(height: 16.h,),
          Align(
            alignment: Alignment.center,
            child: Text(
              'We would love to know',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: ColorPath.nevadaGrey
              ),
            ),
          ),
          SizedBox(height: 33.74.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: CustomButton(
                buttonText: 'Submit',
                onPressed: (){

                }
            ),
          )


        ],
      ),
    );
  }
}
