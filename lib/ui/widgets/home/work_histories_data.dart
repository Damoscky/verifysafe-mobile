import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/named_routes.dart';
import 'package:verifysafe/core/data/models/responses/response_data/worker_dashboard_response.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/pages/employers/view_work_history.dart';
import 'package:verifysafe/ui/widgets/empty_state.dart';
import 'package:verifysafe/ui/widgets/listview_items/work_history_item.dart';

class WorkHistoriesData extends StatelessWidget {
  final List<EmploymentData> workHistories;
  const WorkHistoriesData({super.key, required this.workHistories});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (workHistories.isEmpty) {
          return Padding(
            padding: EdgeInsets.only(top: 24.h),
            child: EmptyState(
              asset: AppAsset.empty,
              useBgCard: false,
              assetHeight: 200.h,
              title: "No work history yet",
              subtitle: "",
              showCtaButton: false,
            ),
          );
        }
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 16.h),
          itemBuilder: (context, index) {
            final data = workHistories[index];
            return WorkHistoryItem(
              employmentData: data,
              onPressed: () {
                pushNavigation(
                  context: context,
                  widget: ViewWorkHistory(employmentData: data,),
                  routeName: NamedRoutes.viewWorkHistory,
                );
              },
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 16.h);
          },
          itemCount: workHistories.length,
        );
      },
    );
  }
}
