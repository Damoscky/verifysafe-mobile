import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import '../../core/constants/app_asset.dart';
import '../../core/constants/color_path.dart';
import 'clickable.dart';
import 'custom_svg.dart';


class LeadingIcon extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool addPadding;
  final bool show;

  const LeadingIcon(
      {super.key, this.onPressed, this.addPadding = true, this.show = true});

  @override
  Widget build(BuildContext context) {
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    final bool canPop = parentRoute?.canPop ?? false;
    if (canPop) {
      if(show){
        return GestureDetector(
          onTap: onPressed ?? () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.only(left: AppDimension.paddingLeft),
            child: SizedBox(
              height: 50.h,
              width: 30.w,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: CustomAssetViewer(
                      asset: AppAsset.backArrow,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.textPrimary,
                        BlendMode.srcIn,
                      )

                  )
              ),
            ),
          ),
        );
      }
      return const SizedBox();

    }
    return const SizedBox();
  }
}
