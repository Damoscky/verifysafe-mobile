import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/ui/widgets/verifysafe_container.dart';

import '../../core/constants/app_asset.dart';
import '../../core/constants/color_path.dart';
import 'custom_button.dart';
import 'custom_painter/dotted_border.dart';
import 'custom_svg.dart';

class UploadAttachment extends StatelessWidget {
  final String? title;
  final String? buttonText;
  final VoidCallback? onPressed;
  const UploadAttachment({super.key, this.title, this.buttonText, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return  CustomPaint(
      painter: DottedBorder(
          color: ColorPath.mischkaGrey,
          borderRadius: BorderRadius.all(Radius.circular(10.r))
      ),
      child: VerifySafeContainer(
          padding: EdgeInsets.symmetric(
              vertical: 20.h,
              horizontal: 16.w
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomAssetViewer(asset: AppAsset.addAttachment, height: 32.h, width: 32.w,),
              SizedBox(width: 12.w,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? 'Upload evidence',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.textPrimary
                      ),
                    ),
                    SizedBox(height: 1.h,),
                    Text(
                      'PNG, JPG, PDF | 10MB max.',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: ColorPath.gullGrey
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w,),
              CustomButton(
                  buttonWidth: null,
                  buttonHeight: 36.h,
                  buttonHorizontalPadding: 14.w,
                  borderRadius: 16.r,
                  buttonText: buttonText ?? 'Upload File',
                  onPressed: onPressed
              )

            ],
          )
      ),
    );
  }
}
