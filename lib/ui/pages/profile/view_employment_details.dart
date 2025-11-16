import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/core/constants/named_routes.dart';
import 'package:verifysafe/core/utilities/date_utilitites.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/pages/authentication/onboarding/worker/employment_details.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/custom_divider.dart';
import 'package:verifysafe/ui/widgets/custom_radio_button.dart';
import 'package:verifysafe/ui/widgets/data_tile.dart';
import 'package:verifysafe/ui/widgets/document_widget.dart';

class ViewEmploymentDetails extends StatelessWidget {
  final bool canEdit;
  const ViewEmploymentDetails({super.key, this.canEdit = true});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Employment Details',
        actions: [
          if (canEdit)
            Padding(
              padding: EdgeInsets.only(right: 24.w),
              child: Clickable(
                onPressed: () {
                  pushNavigation(
                    context: context,
                    widget: EmploymentDetails(),
                    routeName: NamedRoutes.employmentDetails,
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
          Text(
            "Employment Details",
            style: textTheme.bodyMedium?.copyWith(color: colorScheme.text4),
          ),
          SizedBox(height: 16.h),
          // todo::: employer employment details
          if (1 + 1 == 2)
            DataTile(title: "Business Registration ", data: "RC42803498"),
          SizedBox(height: 16.h),
          DataTile(title: "Business Type", data: "Household"),
          SizedBox(height: 16.h),
          DataTile(
            title: "Date Established",
            data: DateUtilities.monthDayYear(date: DateTime.now()),
          ),
          SizedBox(height: 16.h),
          DataTile(title: "Nationality", data: "Nigerian"),
          SizedBox(height: 16.h),
          DataTile(title: "Phone Number", data: "+234 809 000 000"),
          SizedBox(height: 16.h),
          DataTile(title: "Email Address", data: "Sadeoni@verifysafe.com"),
          SizedBox(height: 16.h),
          DataTile(title: "Website", data: "www.sadeoni.com"),
          SizedBox(height: 16.h),
          DataTile(title: "State", data: "Lagos"),
          SizedBox(height: 16.h),
          DataTile(title: "Local Government Area", data: "Ikeja"),
          SizedBox(height: 16.h),
          DataTile(
            title: "Address",
            data: "6391 Elgin St. Celina, Delaware 10299",
          ),
          CustomDivider(verticalSpace: 14),
          //worker emplyment info
          if (1 + 1 == 3) //todo: worker employment details
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DataTile(title: "Job Category", data: "NIN"),
                CustomDivider(verticalSpace: 14),
                DataTile(title: "Specific Role", data: "Driver"),
                CustomDivider(verticalSpace: 14),
                DataTile(title: "Years of Experience", data: "5 years"),
                CustomDivider(verticalSpace: 14),
                Text(
                  "Language Spoken",
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.text5,
                  ),
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
                      child: Text("English"),
                    ),
                  ),
                ),
                CustomDivider(verticalSpace: 14),
                Text(
                  "Willingness to Relocate",
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.text5,
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Row(
                      children: [
                        CustomRadioButton(
                          borderColor: colorScheme.brandColor,
                          value: true,
                          onchanged: (value) {},
                        ),
                        SizedBox(width: 12..w),
                        Text("Yes"),
                      ],
                    ),
                    SizedBox(width: 16.w),
                    SizedBox(width: 12..w),
                    Row(
                      children: [
                        CustomRadioButton(value: false),
                        SizedBox(width: 12..w),
                        Text("No"),
                      ],
                    ),
                  ],
                ),
                CustomDivider(verticalSpace: 14),
                DocumentWidget(),
              ],
            ),
        ],
      ),
    );
  }
}
