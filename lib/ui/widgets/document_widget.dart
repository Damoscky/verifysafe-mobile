

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';
import 'package:verifysafe/ui/widgets/verifysafe_container.dart';

class DocumentWidget extends StatelessWidget {
  const DocumentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return VerifySafeContainer(
      border: Border.all(color: ColorPath.mysticGrey),
      borderRadius: BorderRadius.circular(16.r),
      bgColor: ColorPath.athensGrey5,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      child: Row(
        children: [
          CustomSvg(asset: AppAsset.pdf, height: 40.w, width: 40.w),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "My Resume.pdf",
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Folashade.pdf | 313 KB",
                  style: textTheme.bodyLarge?.copyWith(
                    color: colorScheme.text5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}