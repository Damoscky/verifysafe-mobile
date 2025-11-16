import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/data_tile.dart';

class ViewServicesAndSpecialization extends StatelessWidget {
  const ViewServicesAndSpecialization({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: "Services & Specialisation",
        showBottom: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimension.paddingLeft,
          vertical: 16.h,
        ),
        children: [
          Text(
            "Services & Specialisation",
            style: textTheme.bodyMedium?.copyWith(color: colorScheme.text4),
          ),
          SizedBox(height: 16.h),
          DataTile(title: "Primary Focus", data: "Domestic Staff"),
          SizedBox(height: 16.h),
          Text(
            "Specific Roles",
            style: textTheme.bodyMedium?.copyWith(color: colorScheme.text5),
          ),
          SizedBox(height: 12.h),
          Wrap(
            runSpacing: 6.w,
            spacing: 6.w,
            children: List.generate(
              2,
              (index) => Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: ColorPath.gullGrey),
                ),
                child: Text("Househelp"),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            "Placement Regions Covered",
            style: textTheme.bodyMedium?.copyWith(color: colorScheme.text5),
          ),
          SizedBox(height: 12.h),
          Wrap(
            runSpacing: 6.w,
            spacing: 6.w,
            children: List.generate(
              2,
              (index) => Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: ColorPath.gullGrey),
                ),
                child: Text("Lagos"),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            "Placement Time",
            style: textTheme.bodyMedium?.copyWith(color: colorScheme.text5),
          ),
          SizedBox(height: 12.h),
          Wrap(
            runSpacing: 6.w,
            spacing: 6.w,
            children: List.generate(
              1,
              (index) => Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: ColorPath.gullGrey),
                ),
                child: Text("Weekday"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
