import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/data/models/user.dart';
import 'package:verifysafe/core/utilities/utilities.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/data_tile.dart';

class ViewWorkerAgency extends StatelessWidget {
  final User data;
  const ViewWorkerAgency({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Agency Information',
        showBottom: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimension.paddingLeft,
          vertical: 16.h,
        ),
        children: [
          Text(
            "Agency Information",
            style: textTheme.bodyMedium?.copyWith(color: colorScheme.text4),
          ),
          SizedBox(height: 16.h),

          DataTile(title: "Agency Name", data: data.agency?.name ?? ""),
          SizedBox(height: 16.h),
          DataTile(
            title: "Business Category",
            data: data.agency?.businessType ?? "",
          ),
          SizedBox(height: 16.h),
          DataTile(
            title: "Email",
            data: data.agency?.email?.toLowerCase() ?? "",
          ),
          SizedBox(height: 16.h),
          DataTile(
            title: "Phone",
            data: Utilities.formatPhoneWithCode(
              phoneNumber: data.agency?.phone ?? "",
            ),
          ),
          SizedBox(height: 16.h),
          DataTile(title: "Address", data: data.agency?.address ?? ""),
        ],
      ),
    );
  }
}
