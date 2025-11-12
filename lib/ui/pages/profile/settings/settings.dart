import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/named_routes.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/pages/profile/settings/notification_settings.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/profile/profile_action_tile.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: customAppBar(
        context: context,
        showBottom: true,
        title: "Terms & Conditions",
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: AppDimension.paddingLeft,
          right: AppDimension.paddingRight,
          bottom: 40.h,
          top: 16.h,
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            ProfileActionTile(
              title: "Change Password",
              subTitle: "Update your password",
              asset: AppAsset.padlock,
              showChevron: false,
              height: 20,
            ),
            SizedBox(height: 24.h),
            ProfileActionTile(
              title: "Biometric Settings",
              subTitle: "Manage how you use your biometrics",
              asset: AppAsset.faceId,
              showChevron: false,
              height: 20,
            ),
            SizedBox(height: 24.h),
            ProfileActionTile(
              title: "Two Factor Authentication",
              subTitle: "Enable or disable two-factor authentication",
              asset: AppAsset.twoFa,
              showChevron: false,
              height: 20,
            ),
            SizedBox(height: 24.h),
            Text(
              "Notifications",
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.textSecondary,
              ),
            ),
            SizedBox(height: 16.h),
            ProfileActionTile(
              title: "Notification settings",
              subTitle: "Customize your notifications",
              asset: AppAsset.notification2,
              showChevron: false,
              height: 20,
              onPressed: () {
                pushNavigation(
                  context: context,
                  widget: NotificationSettings(),
                  routeName: NamedRoutes.notificationSettings,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
