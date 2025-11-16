import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/core/constants/named_routes.dart';
import 'package:verifysafe/core/utilities/date_utilitites.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/pages/employers/employer_manage_worker_guanantor.dart';
import 'package:verifysafe/ui/pages/profile/verification_information.dart';
import 'package:verifysafe/ui/pages/profile/view_employment_details.dart';
import 'package:verifysafe/ui/pages/workers/view_agency_information.dart';
import 'package:verifysafe/ui/pages/workers/view_worker_work_history.dart';
import 'package:verifysafe/ui/pages/workers/worker_information.dart';
import 'package:verifysafe/ui/widgets/bottom_sheets/base_bottom_sheet.dart';
import 'package:verifysafe/ui/widgets/bottom_sheets/rate_user.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/custom_divider.dart';
import 'package:verifysafe/ui/widgets/document_widget.dart';
import 'package:verifysafe/ui/widgets/verifysafe_container.dart';
import 'package:verifysafe/ui/widgets/verifysafe_tag.dart';
import 'package:verifysafe/ui/widgets/work_widgets/worker_info_card.dart';

class ViewWorker extends StatelessWidget {
  const ViewWorker({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: "Folashade Onifade",
        showBottom: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimension.paddingLeft,
          vertical: 24.h,
        ),
        children: [
          WorkerInfoCard(),
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
                            "Status:",
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.text4,
                            ),
                          ),
                          VerifySafeTag(status: "Verified"),
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
          //Document Widget
          DocumentWidget(),
          SizedBox(height: 16.h),
          Text(
            "Details",
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.textSecondary,
            ),
          ),
          SizedBox(height: 16.h),
          ActionTile(
            title: "Worker Information",
            subTitle: "Change and update your data",
            onPressed: () {
              pushNavigation(
                context: context,
                widget: WorkerInformation(),
                routeName: NamedRoutes.viewWorkerInfo,
              );
            },
          ),
          CustomDivider(),
          ActionTile(
            title: "Employment Information",
            subTitle: "Change and update employment information",
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
            title: "Verification Information",
            subTitle: "Change and update verification information",
            onPressed: () {
              pushNavigation(
                context: context,
                widget: VerificationInformation(),
                routeName: NamedRoutes.verificationInformation,
              );
            },
          ),
          CustomDivider(),
          ActionTile(
            title: "Work History",
            subTitle: "Change and update work history",
            onPressed: () {
              pushNavigation(
                context: context,
                widget: ViewWorkerWorkHistory(),
                routeName: NamedRoutes.viewWorkerWorkHistory,
              );
            },
          ),
          CustomDivider(),
          ActionTile(
            title: "Agent/Agency",
            subTitle: "Change and update agency information",
            onPressed: () {
              pushNavigation(
                context: context,
                widget: ViewAgencyInformation(),
                routeName: NamedRoutes.viewWorkerAgencyInfo,
              );
            },
          ),
          CustomDivider(),
          ActionTile(
            title: "Guarantor Details",
            subTitle: "Change and update Guarantor's information",
            onPressed: () {
              pushNavigation(
                context: context,
                widget: EmployerManageWorkerGuanantor(),
                routeName: NamedRoutes.employerManageWorkerGuanantor,
              );
            },
          ),
          CustomDivider(),
          ActionTile(
            title: "Ratings & Reviews",
            subTitle: "Leave ratings and review for Worker",
            onPressed: () {
              baseBottomSheet(context: context, content: RateUser());
            },
          ),
          CustomDivider(),
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
