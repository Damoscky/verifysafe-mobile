import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/named_routes.dart';
import 'package:verifysafe/core/data/view_models/guarantor_view_models/guarantor_view_model.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/pages/guarantor/add_guarantor.dart';
import 'package:verifysafe/ui/widgets/app_loader.dart';
import 'package:verifysafe/ui/widgets/bottom_sheets/filters/guarantor_filter_options.dart';
import 'package:verifysafe/ui/widgets/bottom_sheets/sort_options.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';
import 'package:verifysafe/ui/widgets/error_state.dart';
import 'package:verifysafe/ui/widgets/listview_items/guarantor_card_item.dart';
import 'package:verifysafe/ui/widgets/sort_and_filter_tab.dart';

import '../../../core/constants/color_path.dart';
import '../../../core/data/enum/view_state.dart';
import '../../widgets/bottom_sheets/base_bottom_sheet.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/screen_title.dart';

class ManageGuarantor extends ConsumerStatefulWidget {
  const ManageGuarantor({super.key});

  @override
  ConsumerState<ManageGuarantor> createState() => _ManageGuarantorState();
}

class _ManageGuarantorState extends ConsumerState<ManageGuarantor> {

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ref.read(guarantorViewModel).fetchGuarantors();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(guarantorViewModel);
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Manage Guarantor',
        showBottom: true,
        appbarBottomPadding: 10.h,
        actions:[
          Padding(
            padding: EdgeInsets.only(right: AppDimension.paddingRight),
            child: Clickable(
              onPressed: (){
                pushNavigation(context: context, widget: const AddGuarantor(), routeName: NamedRoutes.addGuarantor);
              },
              child: Row(
                children: [
                  CustomAssetViewer(
                      asset: AppAsset.add, height: 16.h, width: 16.w,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.textFieldSuffixIcon,
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: 10.w,),
                  Text(
                    'Add',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.text4
                    ),
                  ),
                ],
              ),
            ),
          )
        ]
      ),
      body: Builder(
        builder: (context) {
          if(vm.state == ViewState.busy){
            return Center(
              child: AppLoader(),
            );
          }

          if(vm.state == ViewState.retrieved){
            return SingleChildScrollView(
              padding: EdgeInsets.only(left: AppDimension.paddingLeft, right: AppDimension.paddingRight, bottom: 40.h, top: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ScreenTitle(
                    headerText: 'Manage Guarantor',
                    secondSub: 'Showing all guarantors below',
                  ),
                  SizedBox(height: 16.h,),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        vertical: 16.h,
                        horizontal: 16.w
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).colorScheme.textTertiary, width: 1.w),
                        borderRadius: BorderRadius.all(Radius.circular(16.r))
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h,
                              horizontal: 12.w
                          ),
                          decoration: BoxDecoration(
                              color: ColorPath.athensGrey4,
                              borderRadius: BorderRadius.all(Radius.circular(8.r))
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total number',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).colorScheme.textPrimary
                                ),
                              ),
                              Text(
                                '${vm.total}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(context).colorScheme.textPrimary
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Accepted',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).colorScheme.textSecondary
                                  ),
                                ),
                                SizedBox(height: 6.h,),
                                Text(
                                  '${vm.accepted}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color:ColorPath.funGreen
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 48.h,
                              width: 1.w,
                              margin: EdgeInsets.only(right: 16.w, left: 40.w),
                              color: Theme.of(context).colorScheme.textTertiary,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Pending',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).colorScheme.textSecondary
                                  ),
                                ),
                                SizedBox(height: 6.h,),
                                Text(
                                  '${vm.pending}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color:ColorPath.jaffaOrange
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 48.h,
                              width: 1.w,
                              margin: EdgeInsets.only(right: 16.w, left: 40.w),
                              color: Theme.of(context).colorScheme.textTertiary,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Rejected',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).colorScheme.textSecondary
                                  ),
                                ),
                                SizedBox(height: 6.h,),
                                Text(
                                  '${vm.rejected}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color:ColorPath.milanoRed
                                  ),
                                ),
                              ],
                            )

                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h,),
                  SortAndFilterTab(
                      sortOnPressed: (){
                        baseBottomSheet(
                          context: context,
                          content: SortOptions(
                            initialValue: vm.selectedSortOption,
                            filterOptions: [
                              'Ascending',
                              'Descending'
                            ],
                            onSelected: (value){
                             vm.sortGuarantorList(value);
                            },
                          ),
                        );
                      },
                      filterOnPressed: (){
                        baseBottomSheet(
                          context: context,
                          content: GuarantorFilterOptions(

                          ),
                        );
                      }),
                  SizedBox(height: 16.h,),
                  if(vm.sortedGuarantors.isEmpty)
                    EmptyState(
                      asset: AppAsset.empty,
                      useBgCard: false,
                      assetHeight: 200.h,
                      title: "No Guarantor yet",
                      subtitle: "",
                      showCtaButton: false,
                    )
                    else ListView.separated(
                    itemCount: vm.sortedGuarantors.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int index) {
                      final guarantor = vm.sortedGuarantors[index];
                      return GuarantorCardItem(
                        guarantor: guarantor,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 16.h,);
                    },
                  )

                ],
              ),
            );
          }

          if(vm.state == ViewState.error){
            return Center(
              child: ErrorState(
                message: vm.message,
                  onPressed: ()=>vm.fetchGuarantors()),
            );
          }

          return const SizedBox.shrink();

        }
      ),
    );
  }
}
