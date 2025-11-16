import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/custom_divider.dart';
import 'package:verifysafe/ui/widgets/data_tile.dart';

class WorkerInformation extends StatelessWidget {
  const WorkerInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: customAppBar(context: context, title: "Worker Information"),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimension.paddingLeft,
          vertical: 24.h,
        ),
        children: [
          Text(
            "Personal Information",
            style: textTheme.bodyMedium?.copyWith(color: colorScheme.text4),
          ),
          //todo::: handle data viewed based on user type
          SizedBox(height: 16.h),
          DataTile(title: "First name", data: "Folashade"),
          CustomDivider(verticalSpace: 14),
          DataTile(title: "Last name", data: "Onifade"),
          CustomDivider(verticalSpace: 14),
          DataTile(title: "Email Address", data: "Sadeoni@gmail.com"),
          CustomDivider(verticalSpace: 14),
          DataTile(title: "Job Type", data: "Fashion Design"),
          CustomDivider(verticalSpace: 14),
          DataTile(title: "Gender", data: "Female"),
          CustomDivider(verticalSpace: 14),
          DataTile(title: "Date of Birth", data: "April 29, 1990"),
          CustomDivider(verticalSpace: 14),
          DataTile(title: "Nationality", data: "Nigerian"),
          CustomDivider(verticalSpace: 14),
          DataTile(title: "State of Origin", data: "Ekiti"),
          CustomDivider(verticalSpace: 14),
          DataTile(title: "Phone Number 1", data: "+234 809 000 000"),
          CustomDivider(verticalSpace: 14),
          DataTile(title: "Phone Number 2", data: "+234 809 000 000"),
          CustomDivider(verticalSpace: 14),
          DataTile(title: "Marital Status", data: "Married"),
          CustomDivider(verticalSpace: 14),
          DataTile(title: "Address", data: "1, Olomide Kingfisher Str, Lekki"),
          CustomDivider(verticalSpace: 14),
        ],
      ),
    );
  }
}
