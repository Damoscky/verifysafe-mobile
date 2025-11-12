import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/menu_item.dart';

class TermsAndCondition extends StatelessWidget {
  const TermsAndCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        showBottom: true,
        title: "Terms & Conditions",
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: AppDimension.paddingLeft,
          right: AppDimension.paddingRight,
          bottom: 40.h,
          top: 16.h,
        ),

        child: Column(
          children: [
            SizedBox(height: 16.h),
            MenuItem(title: "About VerifySafe", asset: AppAsset.about),
            SizedBox(height: 24.h),
            MenuItem(title: "Privacy policy", asset: AppAsset.privacyPolicy),
            SizedBox(height: 24.h),
            MenuItem(title: "Content policy", asset: AppAsset.contentPolicy),
            SizedBox(height: 24.h),
            MenuItem(title: "Terms & conditions", asset: AppAsset.tandc),
            SizedBox(height: 24.h),
            MenuItem(title: "Help", asset: AppAsset.help),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
