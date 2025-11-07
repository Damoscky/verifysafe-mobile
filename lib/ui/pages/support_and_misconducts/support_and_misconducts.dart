import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/named_routes.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/pages/support_and_misconducts/submit_report.dart';
import 'package:verifysafe/ui/pages/support_and_misconducts/view_report.dart';
import 'package:verifysafe/ui/widgets/bottom_sheets/sort_options.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';
import 'package:verifysafe/ui/widgets/sort_and_filter_tab.dart';
import 'package:verifysafe/ui/widgets/verifysafe_container.dart';
import '../../../core/constants/color_path.dart';
import '../../widgets/bottom_sheets/base_bottom_sheet.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/screen_title.dart';

class SupportAndMisconducts extends StatefulWidget {
  const SupportAndMisconducts({super.key});

  @override
  State<SupportAndMisconducts> createState() => _SupportAndMisconductsState();
}

class _SupportAndMisconductsState extends State<SupportAndMisconducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          context: context,
          title: 'Support & Misconducts',
          showBottom: true,
          appbarBottomPadding: 10.h,
          actions:[
            Padding(
              padding: EdgeInsets.only(right: AppDimension.paddingRight),
              child: Clickable(
                onPressed: (){
                  pushNavigation(context: context, widget: const SubmitReport(), routeName: NamedRoutes.submitReport);
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
                      'Report',
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
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: AppDimension.paddingLeft, right: AppDimension.paddingRight, bottom: 40.h, top: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScreenTitle(
              headerText: 'Report Logs',
              secondSub: 'A list all previous report logged',
            ),
            SizedBox(height: 16.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Clickable(
                    onPressed: (){},
                    child: VerifySafeContainer(
                      bgColor: ColorPath.dawnYellow,
                        padding: EdgeInsets.symmetric(
                            vertical: 16.h,
                            horizontal: 16.w
                        ),
                        border: Border.all(color: ColorPath.creamYellow, width: 1.w),
                        borderRadius: BorderRadius.all(Radius.circular(16.r)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Call us now',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).colorScheme.textPrimary
                                  ),
                                ),
                                SizedBox(height: 4.h,),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 4.h,
                                    horizontal: 8.w
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Theme.of(context).colorScheme.textTertiary, width: 1.w),
                                    borderRadius: BorderRadius.all(Radius.circular(32.r))
                                  ),
                                  child: Center(
                                    child: CustomAssetViewer(asset: AppAsset.forwardArrow, height: 16.h, width: 16.w,
                                      colorFilter: ColorFilter.mode(ColorPath.mirageBlack, BlendMode.srcIn),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            CustomAssetViewer(asset: AppAsset.telephone, height: 32.h, width: 32.w,)
                          ],
                        )
                    ),
                  ),
                ),
                SizedBox(width: 16.w,),
                Expanded(
                  child: Clickable(
                    onPressed: (){},
                    child: VerifySafeContainer(
                        bgColor: ColorPath.aquaGreen,
                        padding: EdgeInsets.symmetric(
                            vertical: 16.h,
                            horizontal: 16.w
                        ),
                        border: Border.all(color: ColorPath.gloryGreen, width: 1.w),
                        borderRadius: BorderRadius.all(Radius.circular(16.r)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Chat us now',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).colorScheme.textPrimary
                                  ),
                                ),
                                SizedBox(height: 4.h,),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 4.h,
                                      horizontal: 8.w
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Theme.of(context).colorScheme.textTertiary, width: 1.w),
                                      borderRadius: BorderRadius.all(Radius.circular(32.r))
                                  ),
                                  child: Center(
                                    child: CustomAssetViewer(asset: AppAsset.forwardArrow, height: 16.h, width: 16.w,
                                      colorFilter: ColorFilter.mode(ColorPath.mirageBlack, BlendMode.srcIn),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            CustomAssetViewer(asset: AppAsset.whatsapp, height: 32.h, width: 32.w,)
                          ],
                        )
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h,),
            SortAndFilterTab(
                sortOnPressed: (){
                  baseBottomSheet(
                    context: context,
                    content: SortOptions(
                      filterOptions: [
                        'Date',
                        'Ascending',
                        'Descending'
                      ],
                      onSelected: (value){
                        //todo: perform action
                      },
                    ),
                  );
                },
                filterOnPressed: (){
                  //todo: open filter options bottom-sheet
                }),
            SizedBox(height: 16.h,),
            ListView.separated(
              itemCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                return Clickable(
                  onPressed: (){
                    pushNavigation(context: context, widget: const ViewReport(), routeName: NamedRoutes.viewReport);
                  },
                  child: VerifySafeContainer(
                      padding: EdgeInsets.symmetric(
                          vertical: 16.h,
                          horizontal: 16.w
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(16.r)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Jideson & Co.',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: Theme.of(context).colorScheme.textPrimary
                                      ),
                                    ),
                                    SizedBox(height: 4.h,),
                                    Text(
                                      'Domestic Worker',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context).colorScheme.text4
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10.w,),
                              CustomAssetViewer(asset: AppAsset.verificationBadge)
                            ],
                          ),
                          SizedBox(height: 12.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Timestamp',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context).colorScheme.text4
                                      ),
                                    ),
                                    SizedBox(height: 4.h,),
                                    Text(
                                      'Dec 19, 2013',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: Theme.of(context).colorScheme.text5
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10.w,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Report Type',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context).colorScheme.text4
                                      ),
                                    ),
                                    SizedBox(height: 4.h,),
                                    Text(
                                      'Underpayment',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context).colorScheme.text5
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h,),
                          Text(
                            'New to the field but very interested in design and eager to learn.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.text5
                            ),
                          ),

                        ],
                      )
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 16.h,);
              },
            )

          ],
        ),
      ),
    );
  }
}
