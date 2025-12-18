import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/data/enum/user_type.dart';
import 'package:verifysafe/core/data/models/user.dart';
import 'package:verifysafe/core/utilities/utilities.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/custom_divider.dart';
import 'package:verifysafe/ui/widgets/data_tile.dart';

class UserInformation extends StatelessWidget {
  final User data;

  const UserInformation({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title:
            "${data.userEnumType == UserType.worker ? "Worker" : "Employer"} Information",
      ),
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
          SizedBox(height: 16.h),
          DataTile(
            title: "First name",
            data: data.name?.split(" ").first ?? "",
          ),
          CustomDivider(verticalSpace: 14),
          DataTile(title: "Last name", data: data.name?.split(" ").last ?? ""),
          CustomDivider(verticalSpace: 14),
          DataTile(
            title: "Email Address",
            data: data.email?.toLowerCase() ?? "",
          ),
          if (data.employmentType != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomDivider(verticalSpace: 14),
                DataTile(title: "Job Type", data: data.employmentType ?? ""),
              ],
            ),
          CustomDivider(verticalSpace: 14),
          DataTile(
            title: "Gender",
            data: Utilities.capitalizeWord(data.gender ?? ""),
          ),
          //todo::: Not Provided
          // CustomDivider(verticalSpace: 14),
          // DataTile(title: "Date of Birth", data: "April 29, 1990"),
          // CustomDivider(verticalSpace: 14),
          // DataTile(title: "Nationality", data: "Nigerian"),
          // CustomDivider(verticalSpace: 14),
          // DataTile(title: "State of Origin", data: "Ekiti"),
          CustomDivider(verticalSpace: 14),
          DataTile(
            title: "Phone Number ",
            data: Utilities.formatPhoneWithCode(phoneNumber: data.phone ?? ''),
          ),
          CustomDivider(verticalSpace: 14),
          DataTile(
            title: "Marital Status",
            data: Utilities.capitalizeWord(data.maritalStatus ?? ""),
          ),
          CustomDivider(verticalSpace: 14),
          DataTile(
            title: "Address",
            data: data.userEnumType == UserType.worker
                ? data.residentialAddress ?? ""
                : data.employer?.address ?? "N/A",
          ),
          CustomDivider(verticalSpace: 14),
        ],
      ),
    );
  }
}
