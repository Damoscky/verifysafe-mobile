import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/data/view_models/misconducts_view_model.dart';
import 'package:verifysafe/ui/widgets/verifysafe_container.dart';
import '../../../core/constants/app_asset.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/utilities/navigator.dart';
import '../../widgets/bottom_sheets/action_completed.dart';
import '../../widgets/bottom_sheets/base_bottom_sheet.dart';
import '../../widgets/clickable.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_painter/dotted_border.dart';
import '../../widgets/custom_svg.dart';

class ViewReport extends ConsumerStatefulWidget {
  const ViewReport({super.key});

  @override
  ConsumerState<ViewReport> createState() => _ViewReportState();
}

class _ViewReportState extends ConsumerState<ViewReport> {
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(misconductsViewModel);
    return Scaffold(
      appBar: customAppBar(
          context: context,
          title: 'Jideson & Co.',
          showBottom: true,
          appbarBottomPadding: 10.h,
          actions:[
            if((!vm.isPending || !vm.isDeclined) && vm.isActive)Padding(
              padding: EdgeInsets.only(right: AppDimension.paddingRight),
              child: Clickable(
                onPressed: (){
                  baseBottomSheet(
                    context: context,
                    content: ActionCompleted(
                      asset: AppAsset.actionConfirmation,
                      title: 'Deactivate',
                      subtitle: 'Are you sure you want to deactivate report?',
                      buttonText: 'Yes, Deactivate',
                      onPressed: (){
                        popNavigation(context: context);
                      },
                    ),
                  );
                },
                child:  Text(
                  'Deactivate',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.text4
                  ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        vm.name,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.textPrimary
                        ),
                      ),
                      // SizedBox(height: 4.h,),
                      // Text(
                      //   'Domestic Worker',
                      //   style: Theme.of(context)
                      //       .textTheme
                      //       .bodyLarge
                      //       ?.copyWith(
                      //       fontWeight: FontWeight.w400,
                      //       color: Theme.of(context).colorScheme.text4
                      //   ),
                      // ),
                    ],
                  ),
                ),
                SizedBox(width: 10.w,),
                CustomAssetViewer(asset: AppAsset.verificationBadge, height: 40.h, width: 40.w,)
              ],
            ),
            SizedBox(height: 16.h,),
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
                        vm.date,
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
                SizedBox(width: 40.w,),
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
                        vm.reportType,
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
            SizedBox(height: 16.h,),
            Text(
              vm.comment,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.text5
              ),
            ),
            SizedBox(height: 16.h,),
            CustomPaint(
              painter: DottedBorder(
                  color: ColorPath.mischkaGrey,
                  borderRadius: BorderRadius.all(Radius.circular(10.r))
              ),
              child: VerifySafeContainer(
                padding: EdgeInsets.symmetric(
                  vertical: 20.h,
                  horizontal: 16.w
                ),
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomAssetViewer(asset: AppAsset.uploadSuccessful, height: 32.h, width: 32.w,),
                      SizedBox(width: 12.w,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Upload Successful',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.textPrimary
                              ),
                            ),
                            SizedBox(height: 1.h,),
                            RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).colorScheme.text5,
                                ),
                                children: [
                                  const TextSpan(
                                    text: 'File Title.pdf',
                                  ),
                                  TextSpan(
                                    text: ' | 313 KB . 31 Aug, 2022',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: ColorPath.gullGrey
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
              ),
            )

          ],
        ),
      ),
    );
  }
}
