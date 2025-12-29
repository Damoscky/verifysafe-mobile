import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/core/data/view_models/billing_view_model.dart';
import 'package:verifysafe/core/utilities/date_utilitites.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/core/utilities/receipt_utils.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/custom_button.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';
import 'package:verifysafe/ui/widgets/naira_display.dart';

class PaymentSuccessful extends ConsumerWidget {
  const PaymentSuccessful({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final vm = ref.watch(billingViewModel);

    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 6.h),
        Clickable(
          onPressed: () {
            popNavigation(context: context);
            popNavigation(context: context);
            popNavigation(context: context);
          },
          child: CustomSvg(
            asset: AppAsset.bottomsheetCloser,
            height: 35.h,
            width: 45.w,
          ),
        ),
        SizedBox(height: 24.h),
        Column(
          children: [
            RepaintBoundary(
              key: vm.globalKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSvg(asset: AppAsset.check, height: 56.h, width: 56.w),
                    SizedBox(height: 24.h),
                    Text(
                      "Payment Success!",
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Your Payment has been successfully done",
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.text4,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Amount",
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.text4,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    NairaDisplay(
                      amount:
                          double.tryParse(
                            vm.subscriptionData?.amount?.toString() ?? "0",
                          ) ??
                          0,
                    ),
                    SizedBox(height: 12.h),
                    Container(height: 1, color: ColorPath.athensGrey4),
                    SizedBox(height: 16.h),
                    DetailsItem(
                      title: "Date & Time",
                      data:
                          "${DateUtilities.dMY(vm.subscriptionData?.subscribedAt ?? DateTime.now())},  ${DateUtilities.time(date: vm.subscriptionData?.subscribedAt ?? DateTime.now())}",
                    ),
                    SizedBox(height: 16.h),
                    DetailsItem(
                      title: "Transaction ID",
                      data: vm.subscriptionData?.reference ?? "000000000000",
                    ),
                    // SizedBox(height: 16.h),
                    // DetailsItem(title: "Mode of Payment", data: "Card"),
                    SizedBox(height: 16.h),
                    DetailsItem(
                      title: "Plan Type",
                      data: vm.subscriptionData?.plan ?? "N/A",
                    ),
                    SizedBox(height: 16.h),
                    DetailsItem(
                      title: "Expires",
                      data: DateUtilities.monthDayYear(
                        date: vm.subscriptionData?.endDate ?? DateTime.now(),
                      ),
                    ),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: CustomButton(
                onPressed: () {
                  ReceiptUtils.saveImageToGallery(
                    key: vm.globalKey,
                    context: context,
                  );
                },
                buttonText: "Download Receipt",
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DetailsItem extends StatelessWidget {
  final String title;
  final String data;

  const DetailsItem({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: textTheme.bodySmall?.copyWith(color: colorScheme.text4),
        ),
        Expanded(
          child: Text(
            data,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.blackText,
              fontWeight: FontWeight.w500,
            ),

            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
