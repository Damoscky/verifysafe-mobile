import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/core/constants/named_routes.dart';
import 'package:verifysafe/core/data/enum/user_type.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/pages/authentication/login.dart';
import 'package:verifysafe/ui/pages/profile/settings/notification_settings.dart';
import 'package:verifysafe/ui/pages/profile/settings/settings.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';
import 'package:verifysafe/ui/widgets/profile/profile_action_tile.dart';
import 'package:verifysafe/ui/widgets/profile/profile_info_card.dart';
import 'package:verifysafe/ui/widgets/verifysafe_container.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: customAppBar(
        context: context,
        showLeadingIcon: false,
        title: 'Profile',
        showBottom: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: AppDimension.paddingLeft, vertical: 16.h),
        children: [
          ProfileInfoCard(userType: UserType.agency),
          SizedBox(height: 32.h),
          Text(
            "Personal Information",
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.textSecondary,
            ),
          ),
          SizedBox(height: 16.h),
          if (1 + 1 ==
              3) //todo show [Personal info] for worker [Agency info] for employer and Agency
            ProfileActionTile(
              title: "Personal Information",
              subTitle: "View and update personal data",
              asset: AppAsset.profilePersonal,
              onPressed: () {},
            )
          else
            ProfileActionTile(
              title: "Agency Information",
              subTitle: "View and update data",
              asset: AppAsset.profilePersonal,
              onPressed: () {},
            ),
          CustomDivider(),
          ProfileActionTile(
            title: "Verification Information",
            subTitle: "Verify and update your data",
            asset: AppAsset.profileVerification,
            onPressed: () {},
          ),
          CustomDivider(),
          ProfileActionTile(
            title: "Employment Details",
            subTitle: "View and update employmet data",
            asset: AppAsset.profileEmployment,
            onPressed: () {},
          ),
          if (1 + 1 == 3) //todo show for worker
            Column(
              children: [
                CustomDivider(),
                ProfileActionTile(
                  title: "Agent/Agency",
                  subTitle: "View Agency infoemation",
                  asset: AppAsset.profileAgency,
                  onPressed: () {},
                ),
              ],
            ),
          CustomDivider(),

          SizedBox(height: 8.h),
          Text(
            "Settings",
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.textSecondary,
            ),
          ),
          SizedBox(height: 16.h),
          ProfileActionTile(
            title: "Security",
            subTitle: "Change and update password",
            asset: AppAsset.profileSecurity,
            onPressed: () {
              pushNavigation(context: context, widget: Settings(),routeName: NamedRoutes.settings);
            },
          ),
          CustomDivider(),
          ProfileActionTile(
            title: "Notification settings",
            subTitle: "Customize your notifications",
            asset: AppAsset.profileAgency,
            onPressed: () {
              pushNavigation(context: context, widget: NotificationSettings(),routeName: NamedRoutes.notificationSettings);

            },
          ),
          SizedBox(height: 42.h),
          Clickable(
            onPressed: () {
              pushAndClearAllNavigation(
                context: context,
                widget: Login(),
                routeName: NamedRoutes.login,
              );
            },
            child: VerifySafeContainer(
              bgColor: colorScheme.containerBg,
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
              child: Row(
                children: [
                  CustomSvg(asset: AppAsset.logout),
                  SizedBox(width: 16.w),
                  Text(
                    "Log Out",
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.text4,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 42.h),
        ],
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 1.h,
          color: ColorPath.stormGrey.withValues(alpha: .2),
          margin: EdgeInsets.only(top: 16.h, bottom: 16.h),
        ),
      ],
    );
  }
}
