import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/utilities/validator.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/data/models/user.dart';
import '../custom_button.dart';
import '../custom_text_field.dart';


class EmploymentTermination extends StatefulWidget {
  final bool isEmployer;
  final User user;
  const EmploymentTermination({super.key, this.isEmployer = true, required this.user});

  @override
  State<EmploymentTermination> createState() => _EmploymentTerminationState();
}

class _EmploymentTerminationState extends State<EmploymentTermination> {

  final _reason = TextEditingController();
  final _description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: false,
      child: Padding(
        padding: EdgeInsets.only(left: AppDimension.bottomSheetPaddingLeft, right: AppDimension.bottomSheetPaddingRight, top: 45.h, bottom: 31.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Terminate Employment',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.textPrimary
              ),
            ),
            SizedBox(height: 16.h,),
            if(widget.isEmployer)RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.textPrimary
                ),
                children: [
                  TextSpan(
                    text: 'You are about to end ',
                  ),
                  TextSpan(
                    text: '${widget.user.name ?? 'N/A'} ',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: 'employment',
                  ),
                ],
              ),
            )
            else RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.textPrimary
                ),
                children: [
                  TextSpan(
                    text: 'You are about to end your employment with ',
                  ),
                  TextSpan(
                    text: widget.user.name ?? 'N/A',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h,),
            CustomTextField(
              hintText: 'Reason for termination',
              label: 'Reason for termination',
              keyboardType: TextInputType.text,
              controller: _reason,
              validator: FieldValidator.validate,
            ),
            SizedBox(height: 16.h,),
            CustomTextField(
              hintText: 'Description',
              label: 'Description',
              useDefaultHeight: false,
              fillColor: Colors.white,
              maxLines: 3,
              keyboardType: TextInputType.text,
              controller: _description,
            ),
            SizedBox(height: 24.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: CustomButton(
                  showLoader: false,
                  buttonText: 'Terminate',
                  onPressed: ()async{

                  }
              ),
            )


          ],
        ),
      ),
    );
  }
}
