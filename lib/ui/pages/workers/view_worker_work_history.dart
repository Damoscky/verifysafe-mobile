import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/home/work_histories_data.dart';

class ViewWorkerWorkHistory extends StatefulWidget {
  const ViewWorkerWorkHistory({super.key});

  @override
  State<ViewWorkerWorkHistory> createState() => _ViewWorkerWorkHistoryState();
}

class _ViewWorkerWorkHistoryState extends State<ViewWorkerWorkHistory> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: "Work History",
        showBottom: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.h),
            child: Text(
              "View work history below",
              style: textTheme.bodyMedium?.copyWith(color: colorScheme.text4),
            ),
          ),
          SizedBox(height: 16.h),
          WorkHistoriesData(workHistories: [],),
        ],
      ),
    );
  }
}
