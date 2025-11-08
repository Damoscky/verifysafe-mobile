import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/core/utilities/date_utilitites.dart';
import 'package:verifysafe/ui/widgets/verifysafe_container.dart';

class WorkHistoryItem extends StatelessWidget {
  const WorkHistoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return VerifySafeContainer(
      padding: EdgeInsets.all(16.w),
      borderRadius: BorderRadius.circular(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Jideson & Co.",
            style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          Text(
            "Domestic Worker",
            style: textTheme.bodySmall?.copyWith(color: colorScheme.text4),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "From: ",
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.text4,
                        ),
                        children: [
                          TextSpan(
                            text: DateUtilities.monthDayYear(
                              date: DateTime.now(),
                            ),
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.blackText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        text: "To: ",
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.text4,
                        ),
                        children: [
                          TextSpan(
                            text: "Present",
                            style: textTheme.bodySmall?.copyWith(
                              color: ColorPath.niagaraGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Plumber",
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.blackText,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "Blue Collar",
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
        ],
      ),
    );
  }
}
