import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';

class DashboardNotification extends StatelessWidget {
  final bool isNewNotification;
  const DashboardNotification({super.key, this.isNewNotification = false});

  @override
  Widget build(BuildContext context) {

    return Clickable(
      onPressed: () {
        // todo::: Handle notification routing here
      },
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          CustomSvg(asset: AppAsset.notification),
          if (isNewNotification)
            Icon(Icons.circle, size: 8.sp, color: ColorPath.milanoRed),
        ],
      ),
    );
  }
}
