import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';
import 'package:verifysafe/ui/widgets/verifysafe_container.dart';

class WorkersDashboardCard extends StatelessWidget {
  const WorkersDashboardCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return VerifySafeContainer(
      bgColor: colorScheme.brandColor,
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(left: 24.w, right: 24.w, top: 24.w),
      borderRadius: BorderRadius.circular(16.r),
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          CustomAssetViewer(asset: AppAsset.secureGuy, height: 32.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Verified Workers",
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      '0',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleSmall?.copyWith(
                        color: Colors.white,

                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
