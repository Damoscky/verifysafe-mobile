import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/utilities/extensions/color_extensions.dart';
import '../../core/constants/app_asset.dart';
import '../../core/constants/color_path.dart';
import 'custom_painter/dotted_border.dart';
import 'custom_svg.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final double? buttonWidth;
  final double? buttonHeight;
  final double buttonTextSize;
  final VoidCallback? onPressed;
  final double buttonHorizontalPadding;
  final Color? bgColor;
  final Color? borderColor;
  final Color? buttonTextColor;
  final FontWeight buttonTextFontWeight;
  final Color? disableBgColor;
  final bool showLoader;
  final Widget? childWidget;
  final Color? loaderColor;
  final bool useBorderColor;
  final String? buttonIcon;
  final bool showButtonIcon;
  final bool useDottedBorder;
  final double? borderRadius;

  const CustomButton({
    super.key,
    this.buttonWidth = double.infinity,
    this.buttonTextFontWeight = FontWeight.w700,
    this.buttonTextSize = 15,
    this.borderColor,
    this.bgColor,
    this.buttonTextColor,
    required this.onPressed,
    this.buttonText = 'Continue',
    this.buttonHeight,
    this.disableBgColor,
    this.showLoader = false,
    this.loaderColor,
    this.childWidget,
    this.useBorderColor = false,
    this.buttonHorizontalPadding = 24,
    this.buttonIcon,
    this.showButtonIcon = false,
    this.useDottedBorder = false,
    this.borderRadius
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final height = buttonHeight?.h ?? 56.h;

    final buttonChild = showLoader
        ? Container(
      padding: EdgeInsets.all(6.w),
      height: 30.h,
      width: 30.h,
      child: CircularProgressIndicator(
        color: loaderColor ?? Colors.white,
        strokeWidth: 2,
      ),
    )
        : childWidget ??
        FittedBox(
          child: Row(
            children: [
              Text(
                buttonText,
                style: textTheme.bodyLarge?.copyWith(
                  color: buttonTextColor ??
                      (useBorderColor
                          ? borderColor ?? Colors.grey
                          : colorScheme.whiteText),
                  fontWeight: buttonTextFontWeight,
                  fontSize: buttonTextSize.sp,
                ),
              ),
              if(showButtonIcon)SizedBox(width: 8.w,),
              if(showButtonIcon)CustomSvg(asset: buttonIcon ?? '', height: 18.h, width: 18.w,),
            ],
          ),
        );


    if(useDottedBorder){
      return SizedBox(
        height: height,
        width: buttonWidth,
        child: CustomPaint(
          painter: DottedBorder(
              color: ColorPath.redOrange,
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 12.r))
          ),
          child: useBorderColor
              ? TextButton(
            onPressed: showLoader ? null : onPressed,
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: buttonHorizontalPadding),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
                side: BorderSide(color: borderColor ?? Colors.grey, width: 1.w),
              ),
              backgroundColor: Colors.transparent,
              disabledBackgroundColor: Colors.transparent,
              foregroundColor: Colors.transparent, // removes splash
              overlayColor: Colors.transparent,
            ),
            child: buttonChild,
          )
              : ElevatedButton(
            onPressed: showLoader ? null : onPressed,
            style: ElevatedButton.styleFrom(
              side: null,
              padding: EdgeInsets.symmetric(horizontal: buttonHorizontalPadding),
              elevation: 0,
              backgroundColor: bgColor ?? colorScheme.brandColor,
              disabledBackgroundColor:
              disableBgColor ?? colorScheme.brandColor.withCustomOpacity(0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
              ),
            ),
            child: buttonChild,
          ),
        ),
      );
    }



    return SizedBox(
      height: height,
      width: buttonWidth,
      child: useBorderColor
          ? TextButton(
        onPressed: showLoader ? null : onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: buttonHorizontalPadding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
            side: BorderSide(color: borderColor ?? Colors.grey, width: 1.w),
          ),
          backgroundColor: Colors.transparent,
          disabledBackgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent, // removes splash
          overlayColor: Colors.transparent,
        ),
        child: buttonChild,
      )
          : ElevatedButton(
        onPressed: showLoader ? null : onPressed,
        style: ElevatedButton.styleFrom(
          side: null,
          padding: EdgeInsets.symmetric(horizontal: buttonHorizontalPadding),
          elevation: 0,
          backgroundColor: bgColor ?? colorScheme.brandColor,
          disabledBackgroundColor:
          disableBgColor ?? colorScheme.brandColor.withCustomOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
          ),
        ),
        child: buttonChild,
      ),
    );
  }
}
