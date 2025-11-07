import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';

import '../../../core/constants/color_path.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/screen_title.dart';

class ManageGuarantor extends StatefulWidget {
  const ManageGuarantor({super.key});

  @override
  State<ManageGuarantor> createState() => _ManageGuarantorState();
}

class _ManageGuarantorState extends State<ManageGuarantor> {
  @override
  Widget build(BuildContext context) {
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
              onPressed: (){},
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
      body: SingleChildScrollView(
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
                          '10',
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
                            '3',
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
                            '3',
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
                            '3',
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
                  SizedBox(height: 16.h,)
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
