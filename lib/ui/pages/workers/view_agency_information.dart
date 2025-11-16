import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/custom_divider.dart';
import 'package:verifysafe/ui/widgets/data_tile.dart';

class ViewAgencyInformation extends StatelessWidget {
  const ViewAgencyInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: customAppBar(context: context, title: "Agency Information"),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimension.paddingLeft,
          vertical: 24.h,
        ),
        children: [
          Text(
            "Agency Information",
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.textSecondary,
            ),
          ),
          SizedBox(height: 16.h),
          DataTile(title: "Agent/Recruitment Name", data: "Chukwudi Odili"),
          CustomDivider(verticalSpace: 14),
          DataTile(title: "Agency Name", data: "Okeyson Ventures"),
          CustomDivider(verticalSpace: 14),
          DataTile(title: "Email", data: "Codilli@email.com"),
          CustomDivider(verticalSpace: 14),
          DataTile(title: "Contact Number", data: "+2348123456789"),
          CustomDivider(verticalSpace: 14),
          DataTile(
            title: "Verification Status",
            data: "Verified",
            dataColor: ColorPath.meadowGreen,
          ),
        ],
      ),
    );
  }
}
