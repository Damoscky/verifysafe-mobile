import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/named_routes.dart';
import 'package:verifysafe/core/data/enum/user_type.dart';
import 'package:verifysafe/core/data/view_models/user_view_model.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/pages/authentication/login.dart';
import 'package:verifysafe/ui/pages/profile/settings/notification_settings.dart';
import 'package:verifysafe/ui/pages/profile/settings/settings.dart';
import 'package:verifysafe/ui/pages/profile/verification_information.dart';
import 'package:verifysafe/ui/pages/profile/view_employment_details.dart';
import 'package:verifysafe/ui/pages/profile/view_user_information.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/custom_divider.dart';
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
    final userVm = ref.watch(userViewModel);

    return Scaffold(
      appBar: customAppBar(
        context: context,
        showLeadingIcon: false,
        title: 'Profile',
        showBottom: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimension.paddingLeft,
          vertical: 16.h,
        ),
        children: [
          ProfileInfoCard(
            showIdButton: userVm.userData?.userEnumType == UserType.worker,
          ),
          SizedBox(height: 32.h),
          Text(
            "Personal Information",
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.textSecondary,
            ),
          ),
          SizedBox(height: 16.h),
          ProfileActionTile(
            title: userVm.userData?.userEnumType == UserType.worker
                ? "Personal Information"
                : "Agency Information",
            subTitle: userVm.userData?.userEnumType == UserType.worker
                ? "View and update personal data"
                : "View and update data",
            asset: AppAsset.profilePersonal,
            onPressed: () {
              pushNavigation(
                context: context,
                widget: ViewUserInformation(),
                routeName: NamedRoutes.viewUserInformation,
              );
            },
          ),

          CustomDivider(),
          ProfileActionTile(
            title: "Verification Information",
            subTitle: "Verify and update your data",
            asset: AppAsset.profileVerification,
            onPressed: () {
              pushNavigation(
                context: context,
                widget: VerificationInformation(),
                routeName: NamedRoutes.verificationInformation,
              );
            },
          ),
          CustomDivider(),
          ProfileActionTile(
            title: "Employment Details",
            subTitle: "View and update employmet data",
            asset: AppAsset.profileEmployment,
            onPressed: () {
              pushNavigation(
                context: context,
                widget: ViewEmploymentDetails(),
                routeName: NamedRoutes.viewEmploymentDetails,
              );
            },
          ),
          if (userVm.userData?.userEnumType == UserType.worker)
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
              pushNavigation(
                context: context,
                widget: Settings(),
                routeName: NamedRoutes.settings,
              );
            },
          ),
          CustomDivider(),
          ProfileActionTile(
            title: "Notification settings",
            subTitle: "Customize your notifications",
            asset: AppAsset.profileAgency,
            onPressed: () {
              pushNavigation(
                context: context,
                widget: NotificationSettings(),
                routeName: NamedRoutes.notificationSettings,
              );
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
