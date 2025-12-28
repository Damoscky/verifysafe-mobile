import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/core/constants/named_routes.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/pages/billing/bill_type.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/custom_painter/custom_progress_bar.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';
import 'package:verifysafe/ui/widgets/naira_display.dart';
import 'package:verifysafe/ui/widgets/verifysafe_container.dart';
import 'package:verifysafe/ui/widgets/verifysafe_tag.dart';

class BillingDashboard extends StatefulWidget {
  const BillingDashboard({super.key});

  @override
  State<BillingDashboard> createState() => _BillingDashboardState();
}

class _BillingDashboardState extends State<BillingDashboard> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: "Billings & Payments",
        showBottom: true,
      ),
      body: ListView(
        padding: EdgeInsets.only(
          top: AppDimension.paddingTop,
          left: AppDimension.paddingLeft,
          right: AppDimension.paddingRight,
          bottom: AppDimension.paddingBottom,
        ),
        children: [
          Text("Manage your billing and payment details."),
          SizedBox(height: 16.h),
          //Plan Card
          VerifySafeContainer(
            padding: EdgeInsets.all(24.w),
            borderRadius: BorderRadius.circular(16.r),
            bgColor: ColorPath.athensGrey6,
            border: Border.all(color: ColorPath.mysticGrey),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Premium Plan",
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    CustomSvg(asset: AppAsset.circularDoc),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  "Due Amount",
                  style: textTheme.bodyMedium?.copyWith(
                    color: ColorPath.slateGrey,
                  ),
                ),
                SizedBox(height: 4.h),
                NairaDisplay(amount: 12082, fontSize: 16.sp),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Monthly", style: textTheme.bodyMedium),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Icon(
                        Icons.circle,
                        color: ColorPath.mirageBlack,
                        size: 6,
                      ),
                    ),
                    Text(
                      "Next Invoice Date: November 1, 2025",
                      style: textTheme.bodyMedium,
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Text("14 of 20 searches used"),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  height: 8.h,
                  child: CustomPaint(
                    painter: CustomProgressBar(
                      percentage: 0.9,
                      backgroundColor: ColorPath.gullGrey.withValues(alpha: .2),
                      strokeWidth: 8.w,
                      activeColor: ColorPath.shamrockGreen,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Clickable(
                  onPressed: () {
                    pushNavigation(
                      context: context,
                      widget: BillType(),
                      routeName: NamedRoutes.billType,
                    );
                  },
                  child: VerifySafeContainer(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 10.h,
                    ),
                    bgColor: ColorPath.aquaGreen,
                    border: Border.all(color: ColorPath.aquaGreen2),
                    child: Row(
                      children: [
                        Text(
                          "Renew Plan",
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.north_east),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 18.h),
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return VerifySafeContainer(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Adeola Adeolu",
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        VerifySafeTag(status: "paid"),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text("Premium Plan"),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Billing Date",
                                style: textTheme.bodySmall?.copyWith(
                                  color: colorScheme.text4,
                                ),
                              ),
                              Text(
                                "Dec 19, 2013",
                                style: textTheme.bodySmall?.copyWith(
                                  color: colorScheme.blackText,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Payment Date",
                                style: textTheme.bodySmall?.copyWith(
                                  color: colorScheme.text4,
                                ),
                              ),
                              Text(
                                "Dec 19, 2013",
                                style: textTheme.bodySmall?.copyWith(
                                  color: colorScheme.blackText,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Amount Due",
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.text4,
                          ),
                        ),
                        NairaDisplay(amount: 5350, fontSize: 16.sp),
                      ],
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (_, __) => SizedBox(height: 16.h),
            itemCount: 2,
          ),
        ],
      ),
    );
  }
}
