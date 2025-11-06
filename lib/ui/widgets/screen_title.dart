import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';

class ScreenTitle extends StatelessWidget {
  final String? firstSub;
  final String? headerText;
  final String? secondSub;
  final Widget? firstSubWidget;
  const ScreenTitle({super.key, this.firstSubWidget, this.firstSub, this.secondSub, this.headerText});

  @override
  Widget build(BuildContext context) {
    final fs = firstSub ?? '';
    final hText = headerText ?? '';
    final sS = secondSub ?? '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(firstSubWidget != null)firstSubWidget!,
        if(fs.isNotEmpty && firstSubWidget == null)Text(
          fs,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.textPrimary
          ),
        ),
        if(hText.isNotEmpty)Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: Text(
            hText,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.textPrimary
            ),
          ),
        ),
        if(sS.isNotEmpty) Padding(
          padding: EdgeInsets.only(top: 6.h),
          child: Text(
            sS,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.textPrimary
            ),
          ),
        ),
      ],
    );
  }
}
