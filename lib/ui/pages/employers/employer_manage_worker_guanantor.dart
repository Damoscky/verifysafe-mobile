import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/models/user.dart';
import 'package:verifysafe/core/data/view_models/guarantor_view_model.dart';
import 'package:verifysafe/ui/widgets/busy_overlay.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/empty_state.dart';
import 'package:verifysafe/ui/widgets/listview_items/guarantor_card_item.dart';

class EmployerManageWorkerGuanantor extends ConsumerStatefulWidget {
  final User data;
  const EmployerManageWorkerGuanantor({super.key, required this.data});

  @override
  ConsumerState<EmployerManageWorkerGuanantor> createState() =>
      _EmployerManageWorkerGuanantorState();
}

class _EmployerManageWorkerGuanantorState
    extends ConsumerState<EmployerManageWorkerGuanantor> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      fetchUserGuarantors();
    });
    super.initState();
  }

  fetchUserGuarantors() async {
    final vm = ref.read(guarantorViewModel);
    vm.fetchUserGuarantors(userId: widget.data.id ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(guarantorViewModel);
    return BusyOverlay(
      show: vm.thirdState == ViewState.busy,
      child: Scaffold(
        appBar: customAppBar(context: context, title: "Manage Guarantor"),
        body: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimension.paddingLeft,
            vertical: 16.h,
          ),
          children: [
            Builder(
              builder: (context) {
                if (vm.thirdState == ViewState.busy) {
                  return SizedBox();
                }
                if (vm.userGuarantors.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.only(top: 100.h),
                    child: EmptyState(
                      asset: AppAsset.empty,
                      useBgCard: false,
                      assetHeight: 200.h,
                      title: "No Guarantor provided yet",
                      subtitle: "",
                      showCtaButton: false,
                    ),
                  );
                }
                return ListView.separated(
                  itemCount: vm.userGuarantors.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context, int index) {
                    final data = vm.userGuarantors[index];
                    return GuarantorCardItem(guarantor: data);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 16.h);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
