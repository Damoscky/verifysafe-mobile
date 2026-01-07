import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/core/data/enum/user_type.dart';
import 'package:verifysafe/core/data/view_models/authentication_vms/authentication_view_model.dart';
import 'package:verifysafe/core/data/view_models/authentication_vms/onboarding_vms/onboarding_vm.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/custom_button.dart';
import 'package:verifysafe/ui/widgets/custom_painter/custom_progress_bar.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';

class CompleteProfileSetup extends ConsumerWidget {
  const CompleteProfileSetup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final onboardingVm = ref.watch(onboardingViewModel);
    final authVm = ref.watch(authenticationViewModel);
    final percentage =
        (double.tryParse(
              authVm.authorizationResponse?.onboarding?.completionPercentage
                      ?.toString() ??
                  '0',
            ) ??
            0) /
        100;
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
                "Complete your profile to be a verified ${authVm.authorizationResponse?.user?.userEnumType == UserType.worker
                    ? "Worker"
                    : authVm.authorizationResponse?.user?.userEnumType == UserType.agency
                    ? "Agency"
                    : "Employer"} on VERIFYSAFE",
                style: textTheme.bodyLarge?.copyWith(color: colorScheme.text4),
              ),
              SizedBox(height: 24.h),
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: percentage),
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
                            percentage: percentage,
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
                        "${authVm.authorizationResponse?.onboarding?.completionPercentage ?? '0'}% of profile completed",
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
                "Becoming a Verified ${authVm.authorizationResponse?.user?.userEnumType == UserType.worker
                    ? "Worker"
                    : authVm.authorizationResponse?.user?.userEnumType == UserType.agency
                    ? "Agency"
                    : "Employer"} on VERIFYSAFE helps you build trust and stand out to ${authVm.authorizationResponse?.user?.userEnumType == UserType.worker
                    ? "Employers and Agencies"
                    : authVm.authorizationResponse?.user?.userEnumType == UserType.agency
                    ? "Workers and Employers"
                    : "Workers and Agency"}.\n\nComplete your profile by uploading your details, documents, and guarantor information so that clients can confidently connect with you.\n",
                style: textTheme.bodyLarge?.copyWith(color: colorScheme.text4),
              ),
              if (authVm.authorizationResponse?.user?.userEnumType ==
                  UserType.worker)
                IconText(
                  text: "Verified workers are prioritized in job searches.",
                ),
              SizedBox(height: 12.h),
              IconText(text: "Users trust verified profiles more."),
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
              if (authVm.authorizationResponse?.onboarding?.isComplete == false)
                CustomButton(
                  onPressed: () {
                    log( authVm
                              .authorizationResponse
                              ?.onboarding?.toJson().toString() ?? "_____NULL_____");
                              log(authVm.authorizationResponse?.user?.userEnumType.toString() ?? "_____NULL_____");
                              log(authVm.authorizationResponse?.onboarding?.currentStep ?? "_____NULL_____");

                    onboardingVm.handleOnboardingNavigation(
                      context: context,
                      userType:
                          authVm.authorizationResponse?.user?.userEnumType ??
                          UserType.worker,
                      currentStep:
                          authVm
                              .authorizationResponse
                              ?.onboarding
                              ?.currentStep ??
                          '',
                    );
                  },
                  buttonText: "Complete Profile",
                ),
              SizedBox(height: 32.h),
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
