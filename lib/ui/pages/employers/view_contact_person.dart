import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/data_tile.dart';

class ViewContactPerson extends StatelessWidget {
  const ViewContactPerson({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: "Contact Person",
        showBottom: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimension.paddingLeft,
          vertical: 16.h,
        ),
        children: [
          Text(
            "Contact Person",
            style: textTheme.bodyMedium?.copyWith(color: colorScheme.text4),
          ),
          SizedBox(height: 16.h),
          DataTile(title: "Position", data: "Manager"),
          SizedBox(height: 16.h),
          DataTile(title: "Phone Number 1", data: "+234 809 283 2224"),
          SizedBox(height: 16.h),
          DataTile(title: "Phone Number 2", data: "+234 809 283 2224"),
          SizedBox(height: 16.h),
          DataTile(title: "Email Address", data: "Jadeolakosoko@gmail.com"),
        ],
      ),
    );
  }
}
