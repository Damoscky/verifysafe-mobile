import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/widgets/upload_attachment.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/utilities/validator.dart';
import '../../widgets/bottom_sheets/action_completed.dart';
import '../../widgets/bottom_sheets/base_bottom_sheet.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_drop_down.dart';
import '../../widgets/custom_text_field.dart';


class SubmitReport extends StatefulWidget {
  const SubmitReport({super.key});

  @override
  State<SubmitReport> createState() => _SubmitReportState();
}

class _SubmitReportState extends State<SubmitReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Submit a Report',
        showBottom: true,
        appbarBottomPadding: 10.h,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: AppDimension.paddingLeft, right: AppDimension.paddingRight, bottom: 40.h, top: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomDropdown(
              hintText: "Select Employer",
              label: 'Select Employer',
              onChanged: (value){

              },
              items: ['Small', 'Large'],
            ),
            SizedBox(height: 16.h,),
            CustomDropdown(
              hintText: "Select Report Type",
              label: 'Select Report Type',
              onChanged: (value){

              },
              items: ['Small', 'Large'],
            ),
            SizedBox(height: 16.h,),
            CustomTextField(
              hintText: 'Description',
              label: 'Comment',
              keyboardType: TextInputType.text,
              maxLines: 4,
              useDefaultHeight: false,
              //controller: _email,
              validator: FieldValidator.validate,
            ),
            SizedBox(height: 20.h,),
            UploadAttachment(
              onPressed: (){},
            ),
            SizedBox(height: 40.h,),
            CustomButton(
                buttonText: 'Done',
                onPressed: (){
                  baseBottomSheet(
                    context: context,
                    content: ActionCompleted(
                      asset: AppAsset.actionConfirmation,
                      title: 'Submit',
                      subtitle: 'Are you sure you want to submit this report?',
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
