import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/custom_button.dart';
import 'package:verifysafe/ui/widgets/custom_text_field.dart';
import 'package:verifysafe/ui/widgets/rate_widget.dart';

class RateApp extends StatelessWidget {
  const RateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        showBottom: true,
        title: "Rate VerifySafe App",
      ),
      body: ListView(
        padding: EdgeInsets.only(
          left: AppDimension.paddingLeft,
          right: AppDimension.paddingRight,
          bottom: 40.h,
          top: 32.h,
        ),

        children: [
          Text(
            "How’s your Experience with VerifySafe so far?",
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 20.h),
          Rate(
            onSelect: (value) {
              print(value);
            },
          ),
          SizedBox(height: 16.h),
          CustomTextField(
            height: 250.h,
            maxLines: 10,
            hintText: "Got any comments?",
          ),
          SizedBox(height: 32.h),
          CustomButton(onPressed: () {}, buttonText: "Done"),
        ],
      ),
    );
  }
}
