import 'package:flutter/material.dart';
import 'package:verifysafe/core/data/enum/user_type.dart';

import '../../core/constants/app_asset.dart';
import '../../core/constants/color_path.dart';
import 'custom_svg.dart';

final home = BottomNavigationBarItem(
  activeIcon: CustomSvg(
    asset: AppAsset.home,
    colorFilter: const ColorFilter.mode(
      ColorPath.shamrockGreen,
      BlendMode.srcIn,
    ),
  ),
  icon: CustomSvg(
    asset: AppAsset.home,
    colorFilter: ColorFilter.mode(ColorPath.slateGrey, BlendMode.srcIn),
  ),
  label: 'Home',
);

final workHistory = BottomNavigationBarItem(
  activeIcon: CustomSvg(
    asset: AppAsset.workHistory,
    colorFilter: ColorFilter.mode(ColorPath.shamrockGreen, BlendMode.srcIn),
  ),
  icon: CustomSvg(
    asset: AppAsset.workHistory,
    colorFilter: ColorFilter.mode(ColorPath.slateGrey, BlendMode.srcIn),
  ),
  label: 'Work History',
);

final profile = BottomNavigationBarItem(
  activeIcon: CustomSvg(
    asset: AppAsset.profile,
    colorFilter: ColorFilter.mode(ColorPath.shamrockGreen, BlendMode.srcIn),
  ),
  icon: CustomSvg(
    asset: AppAsset.profile,
    colorFilter: ColorFilter.mode(ColorPath.slateGrey, BlendMode.srcIn),
  ),
  label: 'Profile',
);

final workers = BottomNavigationBarItem(
  activeIcon: CustomAssetViewer(
    asset: AppAsset.navWorker,
    colorFilter: ColorFilter.mode(ColorPath.shamrockGreen, BlendMode.srcIn),
  ),
  icon: CustomAssetViewer(
    asset: AppAsset.navWorker2,
    colorFilter: ColorFilter.mode(ColorPath.slateGrey, BlendMode.srcOut),
  ),
  label: 'Workers',
);

final employer = BottomNavigationBarItem(
  activeIcon: CustomSvg(
    asset: AppAsset.navEmployer,
    colorFilter: ColorFilter.mode(ColorPath.shamrockGreen, BlendMode.srcIn),
  ),
  icon: CustomSvg(
    asset: AppAsset.navEmployer,
    colorFilter: ColorFilter.mode(ColorPath.slateGrey, BlendMode.srcIn),
  ),
  label: 'Employers',
);

///bottom nav items
List<BottomNavigationBarItem> bottomNavItems(UserType type) {
  switch (type) {
    case UserType.worker:
      return [home, workHistory, profile];
    case UserType.agency:
      return [home, workers, employer, profile];
    case UserType.employer:
      return [home, workers, profile];
  }
}
