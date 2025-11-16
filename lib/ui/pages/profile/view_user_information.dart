import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/core/constants/named_routes.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/pages/authentication/onboarding/worker/basic_info.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/custom_divider.dart';
import 'package:verifysafe/ui/widgets/data_tile.dart';
import 'package:verifysafe/ui/widgets/profile/profile_info_card.dart';

class ViewUserInformation extends ConsumerStatefulWidget {
  const ViewUserInformation({super.key});

  @override
  ConsumerState<ViewUserInformation> createState() =>
      _ViewUserInformationState();
}

class _ViewUserInformationState extends ConsumerState<ViewUserInformation> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'User Information',
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 24.w),
            child: Clickable(
              onPressed: () {
                pushNavigation(
                  context: context,
                  widget: BasicInfo(),
                  routeName: NamedRoutes.basicInfo,
                );
              },
              child: Text(
                "Edit",
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: ColorPath.meadowGreen,
                ),
              ),
            ),
          ),
        ],
        showBottom: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimension.paddingLeft,
          vertical: 16.h,
        ),
        children: [
          ProfileInfoCard(canCapture: true),
          SizedBox(height: 24.h),
          Text(
            "Agency Information",
            style: textTheme.bodyMedium?.copyWith(color: colorScheme.text4),
          ),
          //todo::: handle data viewed based on user type
          SizedBox(height: 16.h),
          DataTile(title: "Business Type", data: "Recruitment Agency"),
          CustomDivider(verticalSpace: 14),
          DataTile(title: "Phone Number", data: "+234 809 000 000"),
          CustomDivider(verticalSpace: 14),
          DataTile(title: "Phone Number 2", data: "+234 809 000 000"),
          CustomDivider(verticalSpace: 14),
          DataTile(title: "Email Address", data: "Sadeoni@gmail.com"),
          CustomDivider(verticalSpace: 14),
          DataTile(title: "Nationality", data: "Nigeria"),
          CustomDivider(verticalSpace: 14),
          DataTile(title: "State", data: "Lagos"),
          CustomDivider(verticalSpace: 14),
          DataTile(title: "Local Government", data: "Ikeja"),
          CustomDivider(verticalSpace: 14),
          DataTile(title: "Address", data: "1, Olomide Kingfisher Str, Lekki"),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}
