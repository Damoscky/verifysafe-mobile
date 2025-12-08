import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/core/data/view_models/worker_view_model.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/custom_text_field.dart';
import 'package:verifysafe/ui/widgets/home/work_histories_data.dart';
import 'package:verifysafe/ui/widgets/sort_and_filter_tab.dart';
import 'package:verifysafe/ui/widgets/work_widgets/work_history_dashboard_card.dart';
//todo::: Search , Filter, Sort
class WorkHistory extends ConsumerStatefulWidget {
  const WorkHistory({super.key});

  @override
  ConsumerState<WorkHistory> createState() => _WorkHistoryState();
}

class _WorkHistoryState extends ConsumerState<WorkHistory> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final vm = ref.watch(workerViewModel);

    return Scaffold(
      appBar: customAppBar(
        context: context,
        showLeadingIcon: false,
        title: 'Work History',
        showBottom: true,
      ),
      body: ListView(
        // padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 16.h),
        children: [
          WorkHistoryDashboardCard(),
          Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w),
            child: CustomTextField(
              hintText: "Search...",
              onChanged: (value) {
                // todo::: handle route to search screen here
              },
              enabled: false,
              borderColor: ColorPath.niagaraGreen,
              suffixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(CupertinoIcons.search),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.h),
            child: Text(
              "View work history below",
              style: textTheme.bodyMedium?.copyWith(color: colorScheme.text4),
            ),
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.h),

            child: SortAndFilterTab(
              sortOnPressed: () {},
              filterOnPressed: () {},
            ),
          ),
          WorkHistoriesData(workHistories: vm.recentWorkHistory),
        ],
      ),
    );
  }
}
