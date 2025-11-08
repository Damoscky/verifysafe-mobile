import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/custom_button.dart';
import 'package:verifysafe/ui/widgets/custom_painter/custom_progress_bar.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';
//TODO: HANDLE TEXT CONTEXT FOR USERTYPE
class CompleteProfileSetup extends StatelessWidget {
  const CompleteProfileSetup({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 6.h),
        Clickable(
          onPressed: () {
            popNavigation(context: context);
          },
          child: CustomSvg(
            asset: AppAsset.bottomsheetCloser,
            height: 35.h,
            width: 45.w,
          ),
        ),
        SizedBox(height: 6.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("Complete Profile Setup", style: textTheme.titleLarge),
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                "Complete your profile to be a verified worker on VERIFYSAFE",
                style: textTheme.bodyLarge?.copyWith(color: colorScheme.text4),
              ),
              SizedBox(height: 24.h),
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: 45.0),
                duration: Duration(milliseconds: 1200),
                curve: Curves.easeInOut,
                builder: (context, value, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 8.h,
                        child: CustomPaint(
                          painter: CustomProgressBar(
                            percentage: value,
                            backgroundColor: ColorPath.gullGrey.withValues(
                              alpha: .2,
                            ),
                            strokeWidth: 8.w,
                            activeColor: ColorPath.shamrockGreen,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "${value.toInt()}% of profile completed",
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.text4,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 24.h),
              Text(
                "Becoming a Verified Worker on VERIFYSAFE helps you build trust and stand out to employers.\n\nComplete your profile by uploading your details, documents, and guarantor information so that employers, agencies, and families can confidently hire you.\n",
                style: textTheme.bodyLarge?.copyWith(color: colorScheme.text4),
              ),
              IconText(
                text: "Verified workers are prioritized in job searches.",
              ),
              SizedBox(height: 12.h),
              IconText(text: "Employers trust verified profiles more."),
              SizedBox(height: 12.h),
              IconText(
                text:
                    "Your work history, ratings, and reviews will be recorded for future opportunities.",
              ),
              SizedBox(height: 12.h),
              Text(
                "It only takes a few steps to complete your profile, and once verified, you’ll enjoy more job offers, credibility, and long-term security.",
                style: textTheme.bodyLarge?.copyWith(color: colorScheme.text4),
              ),
              SizedBox(height: 32.h),
              CustomButton(
                onPressed: () {
                  //todo: handle complete profile route here based on userType
                },
                buttonText: "Complete Profile",
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class IconText extends StatelessWidget {
  final String text;
  const IconText({super.key, this.text = ''});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSvg(asset: AppAsset.verifyIcon),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            style: textTheme.bodyLarge?.copyWith(color: colorScheme.text4),
          ),
        ),
      ],
    );
  }
}
