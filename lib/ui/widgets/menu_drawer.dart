import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';
import 'package:verifysafe/ui/widgets/display_image.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Drawer(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      backgroundColor: Colors.white,
      width: MediaQuery.of(context).size.width / 1.4.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 40.h,
                      left: 16.w,
                      right: 16.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DisplayImage(
                          // image: null,
                          image:
                              "https://mir-s3-cdn-cf.behance.net/user/276/888fd91082619909.61d2827bbd7a2.jpg",
                          firstName: "AB",
                          size: 72,
                          lastName: "CD",
                          borderWidth: 2.w,
                          borderColor: ColorPath.persianGreen,
                        ),
                        SizedBox(height: 16.h),
                        Text("Folashade Onifade", style: textTheme.titleMedium),
                        SizedBox(height: 4.h),
                        Text("@sadeoni"),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 1.h,
                    color: ColorPath.stormGrey.withValues(alpha: .3),
                    margin: EdgeInsets.only(top: 8.h, bottom: 40.h),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(left: 16.w, right: 16.w),
                      child: SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MenuItem(
                              title: "Ratings & Reviews",
                              asset: AppAsset.ratings,
                            ),
                            SizedBox(height: 24.h),
                            MenuItem(
                              title: "Support & Misconducts",
                              asset: AppAsset.support,
                            ),
                            SizedBox(height: 24.h),
                            MenuItem(
                              title: "Manage Guarantors",
                              asset: AppAsset.guarantor,
                            ),
                            SizedBox(height: 24.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 1.h,
                    color: ColorPath.stormGrey.withValues(alpha: .3),
                    margin: EdgeInsets.only(top: 8.h, bottom: 40.h),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MenuItem(
                          title: "Rate the VerifySafe app",
                          asset: AppAsset.rateApp,
                        ),
                        SizedBox(height: 24.h),
                        MenuItem(
                          title: "Share your  feedback",
                          asset: AppAsset.feedback,
                        ),
                        SizedBox(height: 24.h),
                        MenuItem(
                          title: "Terms & Conditions",
                          asset: AppAsset.tandc,
                        ),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String title;
  final String asset;
  const MenuItem({super.key, this.title = "", this.asset = AppAsset.guarantor});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        CustomSvg(asset: asset),
        SizedBox(width: 16.w),
        Text(
          title,
          style: textTheme.bodyLarge?.copyWith(color: colorScheme.text4),
        ),
      ],
    );
  }
}
