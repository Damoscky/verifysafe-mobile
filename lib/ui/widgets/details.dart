import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';

class Details extends StatelessWidget {
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;
  final String label;
  final String value;
  const Details({super.key, this.labelStyle, this.valueStyle, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: labelStyle ?? Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.textPrimary
          ),
        ),
        SizedBox(height: 2.h,),
        Text(
          value,
          style: valueStyle ?? Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.text5
          ),
        ),
      ],
    );
  }
}
