import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/models/user.dart';
import 'package:verifysafe/core/data/view_models/worker_view_model.dart';
import 'package:verifysafe/ui/widgets/busy_overlay.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/home/work_histories_data.dart';

class ViewWorkerWorkHistory extends ConsumerStatefulWidget {
  final User workerData;
  const ViewWorkerWorkHistory({super.key, required this.workerData});

  @override
  ConsumerState<ViewWorkerWorkHistory> createState() =>
      _ViewWorkerWorkHistoryState();
}

class _ViewWorkerWorkHistoryState extends ConsumerState<ViewWorkerWorkHistory> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      fetchWorkerWorkHistory();
    });
    super.initState();
  }

  fetchWorkerWorkHistory() async {
    final vm = ref.read(workerViewModel);
    vm.fetchWorkerWorkHistory(workerID: widget.workerData.id ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final vm = ref.watch(workerViewModel);
    return BusyOverlay(
      show: vm.thirdState == ViewState.busy,
      child: Scaffold(
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
            if (vm.thirdState == ViewState.busy)
              SizedBox()
            else
              WorkHistoriesData(workHistories: vm.workerWorkHistories),
          ],
        ),
      ),
    );
  }
}
