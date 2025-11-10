import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final String asset;
  final void Function()? onPressed;
  const MenuItem({
    super.key,
    this.title = "",
    this.asset = AppAsset.guarantor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Clickable(
      onPressed: onPressed,
      child: Row(
        children: [
          CustomSvg(asset: asset),
          SizedBox(width: 16.w),
          Text(
            title,
            style: textTheme.bodyLarge?.copyWith(color: colorScheme.text4),
          ),
        ],
      ),
    );
  }
}