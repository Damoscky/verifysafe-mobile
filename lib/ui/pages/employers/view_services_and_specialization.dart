import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/core/data/models/user.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/data_tile.dart';

class ViewServicesAndSpecialization extends StatelessWidget {
  final User data;
  const ViewServicesAndSpecialization({super.key, required this.data});

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
          DataTile(
            title: "Buisness Type",
            data: data.employer?.businessType ?? "N/A",
          ),
          SizedBox(height: 16.h),
          DataTile(
            title: "Placement Region",
            data: data.services?.placementRegion ?? "N/A",
          ),
          SizedBox(height: 16.h),
          DataTile(
            title: "Average Placement Time",
            data: data.services?.averagePlacementTime ?? "N/A",
          ),
          SizedBox(height: 16.h),
          DataTile(
            title: "Training Services Provided",
            data: data.services?.trainingServiceProvided == true ? "Yes" : "No",
          ),
          SizedBox(height: 16.h),
                    DataTile(
            title: "Active Workers",
            data: data.services?.activeWorkersCount?.toString() ?? "0",
          ),
          SizedBox(height: 16.h),
          // Text(
          //   "Specific Roles",
          //   style: textTheme.bodyMedium?.copyWith(color: colorScheme.text5),
          // ),
          // SizedBox(height: 12.h),
          // Wrap(
          //   runSpacing: 6.w,
          //   spacing: 6.w,
          //   children: List.generate(
          //     2,
          //     (index) => Container(
          //       padding: EdgeInsets.all(8.w),
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(8.r),
          //         border: Border.all(color: ColorPath.gullGrey),
          //       ),
          //       child: Text("Househelp"),
          //     ),
          //   ),
          // ),
          // SizedBox(height: 16.h),
          // Text(
          //   "Placement Regions Covered",
          //   style: textTheme.bodyMedium?.copyWith(color: colorScheme.text5),
          // ),
          // SizedBox(height: 12.h),
          // Wrap(
          //   runSpacing: 6.w,
          //   spacing: 6.w,
          //   children: List.generate(
          //     2,
          //     (index) => Container(
          //       padding: EdgeInsets.all(8.w),
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(8.r),
          //         border: Border.all(color: ColorPath.gullGrey),
          //       ),
          //       child: Text("Lagos"),
          //     ),
          //   ),
          // ),
          // SizedBox(height: 16.h),
          // Text(
          //   "Placement Time",
          //   style: textTheme.bodyMedium?.copyWith(color: colorScheme.text5),
          // ),
          // SizedBox(height: 12.h),
          // Wrap(
          //   runSpacing: 6.w,
          //   spacing: 6.w,
          //   children: List.generate(
          //     1,
          //     (index) => Container(
          //       padding: EdgeInsets.all(8.w),
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(8.r),
          //         border: Border.all(color: ColorPath.gullGrey),
          //       ),
          //       child: Text("Weekday"),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
