import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/named_routes.dart';
import 'package:verifysafe/core/data/models/user.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/pages/workers/view_worker.dart';
import 'package:verifysafe/ui/widgets/empty_state.dart';
import 'package:verifysafe/ui/widgets/listview_items/worker_data_item.dart';

class WorkersData extends StatelessWidget {
    final List<User> workers;
    final String emptyStateTitle;
  const WorkersData({super.key, required this.workers,this.emptyStateTitle =  "No Workers added yet"});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (workers.isEmpty) {
          return Padding(
            padding: EdgeInsets.only(top: 24.h),
            child: EmptyState(
              asset: AppAsset.empty,
              useBgCard: false,
              assetHeight: 200.h,
              title:emptyStateTitle,
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
            final data = workers[index];

            return WorkerDataItem(
              //pass worker data here
              workerData: data,
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 16.h);
          },
          itemCount: workers.length,
        );
      },
    );
  }
}
