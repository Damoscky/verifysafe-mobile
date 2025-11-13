import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_dimension.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../../../../widgets/screen_title.dart';

class ServicesAndSpecializations extends StatefulWidget {
  const ServicesAndSpecializations({super.key});

  @override
  State<ServicesAndSpecializations> createState() => _ServicesAndSpecializationsState();
}

class _ServicesAndSpecializationsState extends State<ServicesAndSpecializations> {

  String? _activeWorkers, _trainingServices, _placementRegion, _placementTime;
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
              headerText: 'Services & Specialisations',
              secondSub: 'Please enter details below.',
            ),
            SizedBox(height: 16.h,),
            CustomDropdown(
              hintText: "Select Number of Active Workers",
              label: 'Number of Active Workers',
              value: _activeWorkers,
              onChanged: (value){

              },
              items: ['Small', 'Large'],
            ),
            SizedBox(height: 20.h,),
            CustomDropdown(
              hintText: "Select",
              label: 'Training Services Provided?',
              value: _trainingServices,
              onChanged: (value){

              },
              items: ['Small', 'Large'],
            ),
            SizedBox(height: 20.h,),
            CustomDropdown(
              hintText: "Select Placement Regions",
              label: 'Placement Regions Covered',
              value: _placementRegion,
              onChanged: (value){

              },
              items: ['Nigeria', 'Australia'],
            ),
            SizedBox(height: 20.h,),
            CustomDropdown(
              hintText: "Select Average Placement Time",
              label: 'Average Placement Time',
              value: _placementTime,
              onChanged: (value){

              },
              items: ['Nigeria', 'Australia'],
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
