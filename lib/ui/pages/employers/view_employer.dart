import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/named_routes.dart';
import 'package:verifysafe/core/data/models/user.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/pages/employers/employer_manage_worker_guanantor.dart';
import 'package:verifysafe/ui/pages/employers/view_contact_person.dart';
import 'package:verifysafe/ui/pages/employers/view_services_and_specialization.dart';
import 'package:verifysafe/ui/pages/workers/view_worker_verification_info.dart';
import 'package:verifysafe/ui/pages/workers/user_information.dart';
import 'package:verifysafe/ui/widgets/bottom_sheets/base_bottom_sheet.dart';
import 'package:verifysafe/ui/widgets/bottom_sheets/rate_user.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/custom_divider.dart';
import 'package:verifysafe/ui/widgets/work_widgets/worker_info_card.dart';

class ViewEmployer extends StatelessWidget {
  final User data;

  const ViewEmployer({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    log(data.toJson().toString());
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: data.name,
        showBottom: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimension.paddingLeft,
          vertical: 24.h,
        ),
        children: [
          WorkerInfoCard(
            image: data.avatar,
            firstName: data.name?.split(" ").first,
            lastName: data.name?.split(" ").last,
            workerID: data.employer?.employerId,
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
            title: "Employer Information",
            subTitle: "View Employer infofrmation",
            onPressed: () {
              pushNavigation(
                context: context,
                widget: UserInformation(data: data),
                routeName: NamedRoutes.viewWorkerInfo,
              );
            },
          ),

          Column(
            children: [
              CustomDivider(),
              ActionTile(
                title: "Contact Person Information",
                subTitle: "View Contact Person information",
                onPressed: () {
                  pushNavigation(
                    context: context,
                    widget: ViewContactPerson(canEdit: false,data: data,),
                    routeName: NamedRoutes.viewContactPerson,
                  );
                },
              ),
            ],
          ),
          Column(
            children: [
              CustomDivider(),
              ActionTile(
                title: "Services and Specialisation",
                subTitle: "View Services and specialisation offered",
                onPressed: () {
                  pushNavigation(
                    context: context,
                    widget: ViewServicesAndSpecialization(data: data,),
                    routeName: NamedRoutes.viewEmploymentDetails,
                  );
                },
              ),
            ],
          ),
          CustomDivider(),
          ActionTile(
            title: "Verification Information",
            subTitle: "Change and update verification information",
            onPressed: () {
              pushNavigation(
                context: context,
                widget: ViewWorkerVerificationInfo(workerData: data),
                routeName: NamedRoutes.verificationInformation,
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
              baseBottomSheet(context: context, content: RateUser(
                isEmployer: data.userType?.toLowerCase() == 'employer',
              ));
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
