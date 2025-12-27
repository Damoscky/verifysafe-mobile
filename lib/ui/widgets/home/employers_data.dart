import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/data/models/user.dart';
import 'package:verifysafe/ui/widgets/empty_state.dart';
import 'package:verifysafe/ui/widgets/listview_items/employer_data_item.dart';

class EmployersData extends StatelessWidget {
  final List<User> employers;
  final String emptyStateTitle;
  const EmployersData({super.key, required this.employers,this.emptyStateTitle = "No Employers added yet"});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (employers.isEmpty) {
          return Padding(
            padding: EdgeInsets.only(top: 24.h),
            child: EmptyState(
              asset: AppAsset.empty,
              useBgCard: false,
              assetHeight: 200.h,
              title: emptyStateTitle,
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
            final data = employers[index];

            return EmployerDataItem(
              data: data,
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 16.h);
          },
          itemCount: employers.length,
        );
      },
    );
  }
}
