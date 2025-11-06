import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';
import '../custom_button.dart';


class ActionCompleted extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onPressed;
  final String buttonText;
  final String? asset;
  const ActionCompleted({super.key, this.asset,  required this.title, required this.subtitle, required this.onPressed, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppDimension.paddingTop,
        horizontal: AppDimension.bottomSheetPaddingRight
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomAssetViewer(
           asset: asset ?? AppAsset.actionCompleted,
            height: 267.h,
            width: 267.w,
          ),
          SizedBox(height: 24.h,),
          Text(
            title,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color:colorScheme.textPrimary,
            ),
          ),
          SizedBox(height: 8.h,),
          Text(
            subtitle,
            style: textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w400,
              color:colorScheme.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 36.h,),
          CustomButton(
            buttonWidth: null,
              buttonHorizontalPadding: 37.w,
              buttonText:buttonText,
              onPressed: onPressed
          ),



        ],
      ),
    );
  }
}
