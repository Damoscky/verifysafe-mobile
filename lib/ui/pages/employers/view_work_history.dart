import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/core/constants/named_routes.dart';
import 'package:verifysafe/core/utilities/date_utilitites.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/pages/employers/view_contact_person.dart';
import 'package:verifysafe/ui/pages/employers/view_services_and_specialization.dart';
import 'package:verifysafe/ui/pages/profile/view_employment_details.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/custom_divider.dart';
import 'package:verifysafe/ui/widgets/verifysafe_container.dart';

class ViewWorkHistory extends StatelessWidget {
  const ViewWorkHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: "Jideson & Co.",
        showBottom: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimension.paddingLeft,
          vertical: 24.h,
        ),
        children: [
          SizedBox(height: 16.h),
          VerifySafeContainer(
            bgColor: ColorPath.aquaGreen,
            borderRadius: BorderRadius.circular(16.r),
            padding: EdgeInsets.all(16.w),
            border: Border.all(color: ColorPath.gloryGreen),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Job Type:",
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.text4,
                            ),
                          ),
                          Text(
                            "Cook",
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.blackText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Employment Type:",
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.text4,
                            ),
                          ),
                          Text(
                            "Full time",
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.blackText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email:",
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.text4,
                            ),
                          ),
                          Text(
                            "jideson@yahoo.com",
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.blackText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12.w),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: "From: ",
                              style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.text4,
                              ),
                              children: [
                                TextSpan(
                                  text: DateUtilities.monthDayYear(
                                    date: DateTime.now(),
                                  ),
                                  style: textTheme.bodySmall?.copyWith(
                                    color: colorScheme.blackText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              text: "To: ",
                              style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.text4,
                              ),
                              children: [
                                TextSpan(
                                  text: "Present",
                                  style: textTheme.bodySmall?.copyWith(
                                    color: ColorPath.niagaraGreen,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          VerifySafeContainer(
            bgColor: ColorPath.dynamicColor("FFEEEC"),
            borderRadius: BorderRadius.circular(16.r),
            padding: EdgeInsets.all(16.w),
            border: Border.all(color: ColorPath.dynamicColor("#FFB5AB")),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Reason for Leaving", style: textTheme.titleMedium),
                SizedBox(height: 12.h),
                Text("Other reasons or comments for leaving"),
              ],
            ),
          ),

          SizedBox(height: 16.h),
          Text(
            "Employer’s Information",
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.textSecondary,
            ),
          ),
          SizedBox(height: 16.h),
          ActionTile(
            title: "Employer Information",
            subTitle: "Change and update your employer information",
            onPressed: () {
              pushNavigation(
                context: context,
                widget: ViewEmploymentDetails(canEdit: false),
                routeName: NamedRoutes.viewEmploymentDetails,
              );
            },
          ),
          CustomDivider(),
          ActionTile(
            title: "Contact Person",
            subTitle: "Change and update contact person information",
            onPressed: () {
              pushNavigation(
                context: context,
                widget: ViewContactPerson(),
                routeName: NamedRoutes.viewContactPerson,
              );
            },
          ),
          CustomDivider(),
          ActionTile(
            title: "Services & Specialisations",
            subTitle: "Change and update services information",
            onPressed: () {
              pushNavigation(
                context: context,
                widget: ViewServicesAndSpecialization(),
                routeName: NamedRoutes.viewServicesAndSpecialization,
              );
            },
          ),
        ],
      ),
    );
  }
}

//Widgets
class ActionTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final void Function()? onPressed;
  const ActionTile({
    super.key,
    required this.title,
    required this.subTitle,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Clickable(
      onPressed: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.bodyLarge?.copyWith(
                    color: colorScheme.blackText,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  subTitle,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.text4,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right_outlined),
        ],
      ),
    );
  }
}
