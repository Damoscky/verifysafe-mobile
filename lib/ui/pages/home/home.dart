import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/core/data/enum/user_type.dart';
import 'package:verifysafe/core/data/view_models/authentication_vms/authentication_view_model.dart';
import 'package:verifysafe/core/data/view_models/bottom_nav_view_model.dart';
import 'package:verifysafe/core/data/view_models/user_view_model.dart';
import 'package:verifysafe/ui/widgets/display_image.dart';
import 'package:verifysafe/ui/widgets/home/complete_profile_card.dart';
import 'package:verifysafe/ui/widgets/home/dashboard_body_data.dart';
import 'package:verifysafe/ui/widgets/home/dashboard_menu.dart';
import 'package:verifysafe/ui/widgets/home/dashboard_notification.dart';
import 'package:verifysafe/ui/widgets/home/dashboard_overview_card.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final bottomNavVm = ref.watch(bottomNavViewModel);
    final authVm = ref.watch(authenticationViewModel);
    final userVm = ref.watch(userViewModel);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.brandColor,
        elevation: 0,
        toolbarHeight: 75.h,
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light, // White icons on Android
          statusBarBrightness: Brightness.dark, // White icons on iOS
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DashboardMenu(
              onPressed: () {
                bottomNavVm.scaffoldKey.currentState?.openDrawer();
              },
            ),
            Row(
              children: [
                DashboardNotification(isNewNotification: 1 + 1 == 2),
                SizedBox(width: 12.w),
                DisplayImage(
                  // image: null,
                  image:
                      "https://mir-s3-cdn-cf.behance.net/user/276/888fd91082619909.61d2827bbd7a2.jpg",
                  firstName: "AB",
                  lastName: "CD",
                  borderWidth: 2.w,
                  borderColor: ColorPath.persianGreen,
                ),
              ],
            ),
          ],
        ),
        titleSpacing: 24.w,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.h),
          child: SizedBox(height: 8.h),
        ),
      ),
      body: //Scrollable Body
      RefreshIndicator(
        onRefresh: () async {
          userVm.getUserData();
        },
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            //WELCOMEBACK ANALYTICS CONTAINER
            Container(
              padding: EdgeInsets.only(
                left: AppDimension.paddingLeft,
                right: AppDimension.paddingRight,
                bottom: 24.h,
              ),
              color: colorScheme.brandColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.h),
                  Text.rich(
                    TextSpan(
                      text: "Welcome back, ",
                      children: [
                        TextSpan(
                          text: userVm.userData?.name ?? '',
                          style: textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    style: textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  //Dashboard Card
                  DashboardOverviewCard(
                    userType: userVm.userData?.userEnumType ?? UserType.worker,
                  ),
                ],
              ),
            ),
            if (authVm
                    .authorizationResponse
                    ?.onboarding
                    ?.completionPercentage !=
                100)
              Column(
                children: [
                  SizedBox(height: 24.h),
                  CompleteProfileCard(),
                ],
              ),
            DashboardBodyData(
              userType: userVm.userData?.userEnumType ?? UserType.worker,
            ),
          ],
        ),
      ),
    );
  }
}
