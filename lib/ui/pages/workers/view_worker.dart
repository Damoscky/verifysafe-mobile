import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/core/constants/named_routes.dart';
import 'package:verifysafe/core/data/models/user.dart';
import 'package:verifysafe/core/data/view_models/employment_view_model.dart';
import 'package:verifysafe/core/data/view_models/user_view_model.dart';
import 'package:verifysafe/core/utilities/date_utilitites.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/pages/employers/employer_manage_worker_guanantor.dart';
import 'package:verifysafe/ui/pages/profile/view_employment_details.dart';
import 'package:verifysafe/ui/pages/support_and_misconducts/submit_report.dart';
import 'package:verifysafe/ui/pages/workers/view_agency_information.dart';
import 'package:verifysafe/ui/pages/workers/view_worker_verification_info.dart';
import 'package:verifysafe/ui/pages/workers/view_worker_work_history.dart';
import 'package:verifysafe/ui/pages/workers/user_information.dart';
import 'package:verifysafe/ui/widgets/bottom_sheets/base_bottom_sheet.dart';
import 'package:verifysafe/ui/widgets/bottom_sheets/employment_termination.dart';
import 'package:verifysafe/ui/widgets/bottom_sheets/rate_user.dart';
import 'package:verifysafe/ui/widgets/busy_overlay.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/custom_divider.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';
import 'package:verifysafe/ui/widgets/document_widget.dart';
import 'package:verifysafe/ui/widgets/verifysafe_container.dart';
import 'package:verifysafe/ui/widgets/verifysafe_tag.dart';
import 'package:verifysafe/ui/widgets/work_widgets/worker_info_card.dart';

import '../../../core/data/enum/view_state.dart';

class ViewWorker extends ConsumerWidget {
  final User workerData;

  const ViewWorker({super.key, required this.workerData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isEmployer = workerData.userType?.toLowerCase() == 'employer';
    final canTerminate = workerData.isTerminatable ?? false;
    final userVm = ref.read(userViewModel);
    final employmentVm = ref.watch(employmentViewModel);
    return BusyOverlay(
      show: employmentVm.state == ViewState.busy,
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          title: workerData.name,
          showBottom: true,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: AppDimension.paddingRight),
              child: Clickable(
                onPressed: () {
                  showMenu<String>(
                    context: context,
                    position: const RelativeRect.fromLTRB(100, 80, 16, 0),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    items: [
                      PopupMenuItem(
                        value: 'report',
                        child:  Text(
                          "Report ${isEmployer ? 'Employer':'Worker'}",
                          style: textTheme.bodyLarge?.copyWith(
                            color: colorScheme.textPrimary,
                          ),
                        ),
                      ),
                      if(canTerminate && !userVm.isAgency)PopupMenuItem(
                        value: 'terminate',
                        child:Text(
                          "Terminate employment",
                          style: textTheme.bodyLarge?.copyWith(
                            color: colorScheme.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ).then((value) {
                    if (value == 'report') {
                      pushNavigation(context: context, widget: SubmitReport(
                        isReportingWorker: true,
                        user: workerData,
                      ), routeName: NamedRoutes.submitReport);
                    } else if (value == 'terminate') {
                      baseBottomSheet(
                          context: context,
                          content: EmploymentTermination(
                              isEmployer: isEmployer,
                              user: workerData
                          )
                      );
                    }
                  });
                },
                child: CustomAssetViewer(asset: AppAsset.more),
              ),
            ),
          ]
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimension.paddingLeft,
            vertical: 24.h,
          ),
          children: [
            WorkerInfoCard(
              image: workerData.avatar,
              firstName: workerData.name?.split(" ").first,
              lastName: workerData.name?.split(" ").last,
              workerID: workerData.workerId,
            ),
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
                              workerData.workerInfo?.jobRole ?? "N/A",
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
                            VerifySafeTag(
                              status: workerData.workerStatus ?? "N/A",
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
                              workerData.email?.toLowerCase() ?? "",
                              style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.blackText,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12.w),
                      if (workerData.employer != null)
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
                                        date: workerData.employer?.startDate,
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
                                    workerData.employer?.endDate != null
                                        ? TextSpan(
                                            text: DateUtilities.monthDayYear(
                                              date:
                                                  workerData.employer?.endDate ??
                                                  DateTime.now(),
                                            ),
                                            style: textTheme.bodySmall?.copyWith(
                                              color: colorScheme.blackText,
                                            ),
                                          )
                                        : TextSpan(
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
            if (workerData.workerInfo?.resumeUrl != null &&
                (workerData.workerInfo?.resumeUrl?.isNotEmpty ?? false))
              DocumentWidget(
                fileName: workerData.workerInfo?.resumeUrl?.split('/').last ?? '',
                onPressed: () {
                  //todo: handle doc view/download
                },
              ),
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
              subTitle: "View worker basic information",
              onPressed: () {
                pushNavigation(
                  context: context,
                  widget: UserInformation(data: workerData),
                  routeName: NamedRoutes.viewWorkerInfo,
                );
              },
            ),
            if (workerData.employer != null)
              Column(
                children: [
                  CustomDivider(),
                  ActionTile(
                    title: "Employment Information",
                    subTitle: "View employment information",
                    onPressed: () {
                      pushNavigation(
                        context: context,
                        widget: ViewEmploymentDetails(
                          canEdit: false,
                          data: workerData,
                        ),
                        routeName: NamedRoutes.viewEmploymentDetails,
                      );
                    },
                  ),
                ],
              ),
            CustomDivider(),
            ActionTile(
              title: "Verification Information",
              subTitle: "View verification information",
              onPressed: () {
                pushNavigation(
                  context: context,
                  widget: ViewWorkerVerificationInfo(workerData: workerData),
                  routeName: NamedRoutes.verificationInformation,
                );
              },
            ),
            CustomDivider(),
            ActionTile(
              title: "Work History",
              subTitle: "View work history",
              onPressed: () {
                pushNavigation(
                  context: context,
                  widget: ViewWorkerWorkHistory(workerData: workerData,),
                  routeName: NamedRoutes.viewWorkerWorkHistory,
                );
              },
            ),
            if (workerData.agency != null)
              Column(
                children: [
                  CustomDivider(),
                  ActionTile(
                    title: "Agent/Agency",
                    subTitle: "View agency information",
                    onPressed: () {
                      pushNavigation(
                        context: context,
                        widget: ViewAgencyInformation(data:  workerData,),
                        routeName: NamedRoutes.viewWorkerAgencyInfo,
                      );
                    },
                  ),
                ],
              ),
            CustomDivider(),
            ActionTile(
              title: "Guarantor Details",
              subTitle: "View Guarantor's information",
              onPressed: () {
                pushNavigation(
                  context: context,
                  widget: EmployerManageWorkerGuanantor(data: workerData,),
                  routeName: NamedRoutes.employerManageWorkerGuanantor,
                );
              },
            ),
            CustomDivider(),
            ActionTile(
              title: "Ratings & Reviews",
              subTitle: "Leave ratings and review for Worker",
              onPressed: () {
                baseBottomSheet(context: context, content: RateUser(
                  isEmployer: isEmployer,
                ));
              },
            ),
            CustomDivider(),
          ],
        ),
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
