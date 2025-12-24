import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/core/data/models/user.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/custom_button.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';
import 'package:verifysafe/ui/widgets/verifysafe_container.dart';

class ShowId extends StatelessWidget {
  final User userData;
  const ShowId({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: "Show my ID",
        showBottom: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimension.paddingLeft,
          vertical: 16.h,
        ),
        children: [
          VerifySafeContainer(
            border: Border.all(color: ColorPath.meadowGreen),
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
            borderRadius: BorderRadius.circular(24.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${userData.name?.split(" ").first} \n${userData.name?.split(" ").last}",
                          style: textTheme.titleLarge?.copyWith(
                            fontSize: 28.sp,
                          ),
                        ),
                        Text(
                          userData.employer?.jobRole ?? "",
                          style: textTheme.titleSmall?.copyWith(
                            fontSize: 18.sp,
                            color: colorScheme.text5,
                          ),
                        ),
                      ],
                    ),
                    RotatedBox(
                      quarterTurns: 3, // 1=90°, 2=180°, 3=270°
                      child: Text(
                        "NGN • ${userData.workerInfo?.gender?.toUpperCase() ?? ""}",
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: colorScheme.text5,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Container(
                  height: 300.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    image: DecorationImage(
                      image: NetworkImage(
                        userData.avatar!,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  "ID: ${userData.workerId ?? ""}",
                  style: textTheme.titleMedium,
                ),
                // SizedBox(height: 6.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomSvg(asset: AppAsset.verifysafe, height: 40.h),
                        Text(
                          "Digital Identity Card",
                          style: textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    SizedBox(width: 12.w),
                    CustomSvg(asset: AppAsset.bgLogo, height: 150.h),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                onPressed: () {},
                buttonWidth: null,
                buttonText: "Download",
              ),
            ],
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
