import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/ui/widgets/display_image.dart';
import 'package:verifysafe/ui/widgets/verifysafe_container.dart';

class WorkerInfoCard extends StatelessWidget {
  const WorkerInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return VerifySafeContainer(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          DisplayImage(
            // image: null,
            image:
                "https://mir-s3-cdn-cf.behance.net/user/276/888fd91082619909.61d2827bbd7a2.jpg",
            firstName: "AB",
            lastName: "CD",
            borderWidth: 2.w,
            size: 64.h,
            borderColor: ColorPath.persianGreen,
          ),
          SizedBox(width: 18.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Folashade Onifade",
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.blackText,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "VerifySafe ID: ",
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.textSecondary,
                      ),
                      children: [
                        TextSpan(
                          text: "42802-VS25",
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.text4,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 4.w),
                  //   child: Icon(
                  //     Icons.circle,
                  //     color: ColorPath.shamrockGreen,

                  //     size: 6,
                  //   ),
                  // ),
                  // Text(
                  //   "Verified",
                  //   style: textTheme.bodyMedium?.copyWith(
                  //     color: ColorPath.shamrockGreen,
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
