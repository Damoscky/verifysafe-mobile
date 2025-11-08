import 'package:flutter/material.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';

class DashboardMenu extends StatelessWidget {
  final void Function()? onPressed;
  const DashboardMenu({super.key,this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onPressed: onPressed,
      child: CustomSvg(asset: AppAsset.dashboardMenu),
    );
  }
}
