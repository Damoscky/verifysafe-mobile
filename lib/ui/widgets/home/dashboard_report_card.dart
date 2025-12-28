import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/core/constants/named_routes.dart';
import 'package:verifysafe/core/data/enum/user_type.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/pages/support_and_misconducts/submit_report.dart';
import 'package:verifysafe/ui/widgets/custom_button.dart';
import 'package:verifysafe/ui/widgets/verifysafe_container.dart';

class DashboardReportCard extends StatelessWidget {
  final UserType userType;
  const DashboardReportCard({super.key, this.userType = UserType.worker});

  @override
  Widget build(BuildContext context) {
    return VerifySafeContainer(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      border: Border.all(color: ColorPath.gloryGreen),
      borderRadius: BorderRadius.circular(16.r),
      bgColor: ColorPath.aquaGreen,
      child: Row(
        children: [
          Expanded(
            child: Text(
              reportText(),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
            ),
          ),
          CustomButton(
            buttonWidth: null,
            onPressed: () {
              pushNavigation(context: context, widget: const SubmitReport(), routeName: NamedRoutes.submitReport);
            },
            buttonText: "Report",
          ),
        ],
      ),
    );
  }

  String reportText() {
    if (userType == UserType.worker) return "Report Employer";
    return "Report Workers";
  }
}
