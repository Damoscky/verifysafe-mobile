import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/ui/widgets/empty_state.dart';
import 'package:verifysafe/ui/widgets/listview_items/work_history_item.dart';

class WorkHistoriesData extends StatelessWidget {
  const WorkHistoriesData({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (1 + 1 == 3) {
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
            return WorkHistoryItem();
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 16.h);
          },
          itemCount: 2,
        );
      },
    );
  }
}
