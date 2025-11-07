import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/utilities/extensions/color_extensions.dart';
import 'package:verifysafe/ui/widgets/verifysafe_container.dart';

import 'clickable.dart';

class SortAndFilterTab extends StatelessWidget {
  final VoidCallback? sortOnPressed;
  final VoidCallback? filterOnPressed;
  const SortAndFilterTab({super.key, required this.sortOnPressed, required this.filterOnPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Clickable(
            onPressed: filterOnPressed,
            child: VerifySafeContainer(
              padding: EdgeInsets.symmetric(
                  vertical: 12.h,
                  horizontal: 12.w
              ),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  bottomLeft: Radius.circular(16.r)
              ),
              border: Border(
                right: BorderSide(
                    color: Theme.of(context).colorScheme.textTertiary,
                    width: 0.5.w
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.blackText.withCustomOpacity(0.05),
                  spreadRadius: 0,
                  blurRadius: 48,
                  offset: Offset(24, 24),
                ),
              ],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filter By',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.textPrimary
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down, size: 20, color: Theme.of(context).colorScheme.textFieldSuffixIcon,)
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Clickable(
            onPressed: sortOnPressed,
            child: VerifySafeContainer(
              padding: EdgeInsets.symmetric(
                  vertical: 12.h,
                  horizontal: 12.w
              ),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16.r),
                  bottomRight: Radius.circular(16.r)
              ),
              border: Border(
                left: BorderSide(
                    color: Theme.of(context).colorScheme.textTertiary,
                    width: 0.5.w
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.blackText.withCustomOpacity(0.05),
                  spreadRadius: 0,
                  blurRadius: 48,
                  offset: Offset(24, 24)
                ),
              ],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sort By',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.textPrimary
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down, size: 20, color: Theme.of(context).colorScheme.textFieldSuffixIcon,)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
