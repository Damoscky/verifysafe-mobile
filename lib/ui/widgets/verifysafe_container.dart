import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';


class VerifySafeContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? width;
  final Color? bgColor;
  final Border? border;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Gradient? gradient;
  const VerifySafeContainer({super.key, this.boxShadow, this.borderRadius, this.border, this.bgColor, this.margin, required this.child, this.padding, this.width,this.gradient});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
          color: bgColor ?? Theme.of(context).colorScheme.containerBg,
          border: border,
          gradient: gradient,
          boxShadow: boxShadow,
          borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(8.r))
      ),
      child: child,
    );
  }
}
