import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/view_models/worker_view_model.dart';
import 'package:verifysafe/core/utilities/extensions/color_extensions.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/core/utilities/utilities.dart';
import 'package:verifysafe/ui/widgets/alert_dialogs/base_dialog.dart';
import 'package:verifysafe/ui/widgets/alert_dialogs/select_date.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/custom_button.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';
import 'package:verifysafe/ui/widgets/show_flush_bar.dart';

class WorkerFilterOptions extends ConsumerStatefulWidget {
  final Map<String, dynamic>? initialValues;
  const WorkerFilterOptions({super.key, this.initialValues});

  @override
  ConsumerState<WorkerFilterOptions> createState() =>
      _WorkerFilterOptionsState();
}

class _WorkerFilterOptionsState extends ConsumerState<WorkerFilterOptions> {

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final vm = ref.watch(workerViewModel);
    return Padding(
      padding: EdgeInsets.only(
        left: AppDimension.bottomSheetPaddingLeft,
        right: AppDimension.bottomSheetPaddingRight,
        top: 45.h,
        bottom: 31.h,
      ),
      child: IgnorePointer(
        ignoring: vm.state == ViewState.busy,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter by',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colorScheme.textPrimary,
                  ),
                ),
                Clickable(
                  onPressed: () {
                    setState(() {
                      vm.selectedStatus = null;
                      vm.selectedGender = null;
                      vm.startDate = null;
                      vm.endDate = null;
                    });
                    popNavigation(context: context);
                  },
                  child: Text(
                    'Clear',
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: colorScheme.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              'Status Type:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.textPrimary,
              ),
            ),
            SizedBox(height: 16.h),
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 12.w,
              runSpacing: 16.h,
              children: List.generate(vm.statusType.length, (index) {
                final status = vm.statusType[index];
                final isSelected =
                    vm.selectedStatus?.toLowerCase() == status.toLowerCase();
                return Clickable(
                  onPressed: () {
                    setState(() {
                      vm.selectedStatus = status;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? ColorPath.aquaGreen
                          : ColorPath.athensGrey6.withCustomOpacity(0.5),
                      border: Border.all(
                        color: isSelected
                            ? ColorPath.gloryGreen
                            : ColorPath.mysticGrey,
                        width: 1.w,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8.r)),
                    ),
                    child: Text(
                      Utilities.capitalizeWord(status),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.textPrimary,
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 16.h),
            Text(
              'Gender:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.textPrimary,
              ),
            ),
            SizedBox(height: 16.h),
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 12.w,
              runSpacing: 16.h,
              children: List.generate(vm.gender.length, (index) {
                final gender = vm.gender[index];
                final isSelected =
                    vm.selectedGender?.toLowerCase() == gender.toLowerCase();
                return Clickable(
                  onPressed: () {
                    setState(() {
                      vm.selectedGender = gender;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? ColorPath.aquaGreen
                          : ColorPath.athensGrey6.withCustomOpacity(0.5),
                      border: Border.all(
                        color: isSelected
                            ? ColorPath.gloryGreen
                            : ColorPath.mysticGrey,
                        width: 1.w,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8.r)),
                    ),
                    child: Text(
                      Utilities.capitalizeWord(gender),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.textPrimary,
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 16.h),
            Text(
              'Date:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.textPrimary,
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.only(right: 56.w),
              child: Row(
                children: [
                  Clickable(
                    onPressed: () {
                      baseDialog(
                        context: context,
                        content: SelectDate(
                          initialDate: DateFormat(
                            "yyyy-MM-dd",
                          ).tryParse(vm.startDate ?? ''),
                          returningValue: (value) {
                            setState(() {
                              vm.startDate = value;
                            });
                          },
                        ),
                      );
                    },
                    child: Container(
                      width: 124.w,
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: ColorPath.athensGrey6.withCustomOpacity(0.5),
                        border: Border.all(
                          color: ColorPath.mysticGrey,
                          width: 1.w,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8.r)),
                      ),
                      child: FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              vm.startDate ?? 'YY/MM/DD',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.textPrimary,
                                  ),
                            ),
                            SizedBox(width: 8.w),
                            CustomAssetViewer(
                              asset: AppAsset.calendar,
                              colorFilter: ColorFilter.mode(
                                ColorPath.slateGrey,
                                BlendMode.srcIn,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 3.h,
                    width: 10.w,
                    color: colorScheme.blackText,
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                  ),
                  Clickable(
                    onPressed: () {
                      baseDialog(
                        context: context,
                        content: SelectDate(
                          initialDate: DateFormat(
                            "yyyy-MM-dd",
                          ).tryParse(vm.endDate ?? ''),
                          returningValue: (value) {
                            setState(() {
                              vm.endDate = value;
                            });
                          },
                        ),
                      );
                    },
                    child: Container(
                      width: 124.w,
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: ColorPath.athensGrey6.withCustomOpacity(0.5),
                        border: Border.all(
                          color: ColorPath.mysticGrey,
                          width: 1.w,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8.r)),
                      ),
                      child: FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              vm.endDate ?? 'YY/MM/DD',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.textPrimary,
                                  ),
                            ),
                            SizedBox(width: 8.w),
                            CustomAssetViewer(
                              asset: AppAsset.calendar,
                              colorFilter: ColorFilter.mode(
                                ColorPath.slateGrey,
                                BlendMode.srcIn,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.h),
            CustomButton(
              buttonText: 'Done',
              showLoader: vm.secondState == ViewState.busy,
              onPressed: () async {
                if (vm.selectedStatus == null &&
                    vm.selectedGender == null &&
                    (vm.startDate == null && vm.endDate == null)) {
                  showFlushBar(
                    context: context,
                    message: 'Select a filter option to proceed',
                    success: false,
                  );
                  return;
                }

                if (vm.startDate == null && vm.endDate != null) {
                  showFlushBar(
                    context: context,
                    success: false,
                    message: 'Select a start date to proceed',
                  );
                  return;
                }

                if (vm.startDate != null && vm.endDate == null) {
                  showFlushBar(
                    context: context,
                    success: false,
                    message: 'Select an end date to proceed',
                  );
                  return;
                }

                if (vm.startDate != null && vm.endDate != null) {
                  final startDate = DateFormat(
                    "yyyy-MM-dd",
                  ).tryParse(vm.startDate ?? '');
                  final endDate = DateFormat(
                    "yyyy-MM-dd",
                  ).tryParse(vm.endDate ?? '');

                  if (!startDate!.isBefore(endDate!)) {
                    showFlushBar(
                      context: context,
                      success: false,
                      message: 'Start date must be before end date',
                    );
                    return;
                  }

                  if (!endDate.isAfter(startDate)) {
                    showFlushBar(
                      context: context,
                      success: false,
                      message: 'End date must be after start date.',
                    );
                    return;
                  }
                }

                await vm.fetchWorkersDetails();
                if (vm.secondState == ViewState.retrieved) {
                  popNavigation(context: context);
                }

                showFlushBar(
                  context: context,
                  message: vm.message,
                  success: vm.secondState == ViewState.retrieved,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
