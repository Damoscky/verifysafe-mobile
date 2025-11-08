import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/ui/widgets/bottom_sheets/base_bottom_sheet.dart';
import 'package:verifysafe/ui/widgets/bottom_sheets/complete_profile_setup.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/home/animated_circular_progress.dart';
import 'package:verifysafe/ui/widgets/verifysafe_container.dart';

class CompleteProfileCard extends ConsumerStatefulWidget {
  const CompleteProfileCard({super.key});

  @override
  ConsumerState<CompleteProfileCard> createState() =>
      _CompleteProfileCardState();
}

class _CompleteProfileCardState extends ConsumerState<CompleteProfileCard> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Clickable(
      onPressed: () {
          baseBottomSheet(
                      context: context,
                      isDismissible: false,
                      enableDrag: false,
                      content: CompleteProfileSetup(),
                    );
      },
      child: VerifySafeContainer(
        padding: EdgeInsets.all(16.w),
        margin: EdgeInsets.symmetric(horizontal: 24.w),
        border: Border.all(color: ColorPath.cornflowerLilac),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Complete Profile Setup",
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Complete your profile to be a verified worker on VERIFYSAFE",
                    style: textTheme.bodyMedium?.copyWith(
                      // fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 40.w),
            AnimatedCircularProgress(percentage: 45),
          ],
        ),
      ),
    );
  }
}
