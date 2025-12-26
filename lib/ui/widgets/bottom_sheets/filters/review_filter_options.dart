import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/data/view_models/review_view_model.dart';
import 'package:verifysafe/core/utilities/extensions/color_extensions.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/widgets/alert_dialogs/base_dialog.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';
import 'package:verifysafe/ui/widgets/show_flush_bar.dart';
import '../../../../core/constants/app_asset.dart';
import '../../../../core/constants/app_dimension.dart';
import '../../../../core/constants/color_path.dart';
import '../../../../core/data/enum/view_state.dart';
import '../../../../core/data/view_models/authentication_vms/authentication_view_model.dart';
import '../../alert_dialogs/select_date.dart';
import '../../clickable.dart';
import '../../custom_button.dart';

class ReviewFilterOptions extends ConsumerStatefulWidget {
  final Map<String, dynamic>? initialValues;
  final String? userId;
  const ReviewFilterOptions({super.key, this.initialValues, this.userId});

  @override
  ConsumerState<ReviewFilterOptions> createState() => _ReviewFilterOptionsState();
}

class _ReviewFilterOptionsState extends ConsumerState<ReviewFilterOptions> {

  String? _startDate, _endDate;

  @override
  void initState() {
    final vm = ref.read(reviewViewModel);
    if(vm.selectedFilterOptions.containsKey('date_filter')){
      _startDate = vm.selectedFilterOptions['start_date'];
      _endDate = vm.selectedFilterOptions['end_date'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final vm = ref.watch(reviewViewModel);
    return Padding(
      padding: EdgeInsets.only(left: AppDimension.bottomSheetPaddingLeft, right: AppDimension.bottomSheetPaddingRight, top: 45.h, bottom: 31.h),
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
                  style:textTheme
                      .titleMedium
                      ?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colorScheme.textPrimary
                  ),
                ),
                Clickable(
                  onPressed: (){
                    setState(() {
                      _startDate = null;
                      _endDate = null;
                    });
                    vm.clearFilters();
                    popNavigation(context: context);
                  },
                  child: Text(
                    'Clear',
                    style:textTheme
                        .bodyLarge
                        ?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: colorScheme.textSecondary
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h,),
            Text(
              'Date:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.textPrimary
              ),
            ),
            SizedBox(height: 16.h,),
            Padding(
              padding: EdgeInsets.only(right: 56.w),
              child: Row(
                children: [
                  Clickable(
                    onPressed: (){
                      baseDialog(
                          context: context,
                          content: SelectDate(
                              initialDate: DateFormat("dd-MM-yyyy").tryParse(_startDate ?? ''),
                              returningValue: (value){
                                setState(() {
                                  _startDate = value;
                                });
                              }
                          ));
                    },
                    child:Container(
                      width: 124.w,
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                      decoration: BoxDecoration(
                          color: ColorPath.athensGrey6.withCustomOpacity(0.5),
                          border: Border.all(color: ColorPath.mysticGrey, width: 1.w),
                          borderRadius: BorderRadius.all(Radius.circular(8.r))
                      ),
                      child:FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _startDate ?? 'DD/MM/YY',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).colorScheme.textPrimary
                              ),
                            ),
                            SizedBox(width: 8.w,),
                            CustomAssetViewer(asset: AppAsset.calendar, colorFilter: ColorFilter.mode(ColorPath.slateGrey, BlendMode.srcIn),)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(height: 3.h,
                    width: 10.w,
                    color: colorScheme.blackText,
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                  ),
                  Clickable(
                    onPressed: (){
                      baseDialog(
                          context: context,
                          content: SelectDate(
                              initialDate: DateFormat("dd-MM-yyyy").tryParse(_endDate ?? ''),
                              returningValue: (value){
                                setState(() {
                                  _endDate = value;
                                });
                              }
                          ));
                    },
                    child: Container(
                      width: 124.w,
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                      decoration: BoxDecoration(
                          color: ColorPath.athensGrey6.withCustomOpacity(0.5),
                          border: Border.all(color: ColorPath.mysticGrey, width: 1.w),
                          borderRadius: BorderRadius.all(Radius.circular(8.r))
                      ),
                      child:FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _endDate ?? 'DD/MM/YY',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).colorScheme.textPrimary
                              ),
                            ),
                            SizedBox(width: 8.w,),
                            CustomAssetViewer(asset: AppAsset.calendar, colorFilter: ColorFilter.mode(ColorPath.slateGrey, BlendMode.srcIn),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.h,),
            CustomButton(
                buttonText: 'Done',
                showLoader: vm.state == ViewState.busy,
                onPressed: ()async{

                  if((_startDate == null && _endDate == null)){
                    showFlushBar(
                        context: context,
                        message: 'Select a filter option to proceed',
                        success: false
                    );
                    return;
                  }

                  if(_startDate == null && _endDate != null){
                    showFlushBar(
                      context: context,
                      success: false,
                      message: 'Select a start date to proceed',
                    );
                    return;
                  }

                  if(_startDate != null && _endDate == null){
                    showFlushBar(
                      context: context,
                      success: false,
                      message: 'Select an end date to proceed',
                    );
                    return;
                  }

                  if(_startDate != null && _endDate != null){

                    final startDate = DateFormat("dd-MM-yyyy").tryParse(_startDate ?? '');
                    final endDate = DateFormat("dd-MM-yyyy").tryParse(_endDate ?? '');

                    if(!startDate!.isBefore(endDate!)) {
                      showFlushBar(
                        context: context,
                        success: false,
                        message: 'Start date must be before end date',
                      );
                      return;
                    }

                    if(!endDate.isAfter(startDate)){
                      showFlushBar(
                        context: context,
                        success: false,
                        message: 'End date must be after start date.',
                      );
                      return;
                    }
                  }

                  await vm.setFilterOptions(
                      startDate: _startDate,
                      endDate: _endDate
                  );

                  await vm.fetchRatings(withFilters: true, userId: widget.userId ?? ref.read(authenticationViewModel).userId);
                  if(vm.state == ViewState.retrieved){
                    popNavigation(context: context);
                  }

                  showFlushBar(
                      context: context,
                      message: vm.message,
                      success: vm.state == ViewState.retrieved
                  );

                }
            )


          ],
        ),
      ),
    );
  }
}
