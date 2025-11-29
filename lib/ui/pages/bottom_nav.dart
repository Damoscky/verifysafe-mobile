import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/data/enum/user_type.dart';
import 'package:verifysafe/core/data/view_models/authentication_vms/authentication_view_model.dart';
import 'package:verifysafe/ui/widgets/menu_drawer.dart';
import '../../core/constants/color_path.dart';
import '../../core/data/view_models/bottom_nav_view_model.dart';
import '../widgets/bottom_nav_items.dart';

class BottomNav extends ConsumerStatefulWidget {
  const BottomNav({super.key});

  @override
  ConsumerState<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends ConsumerState<BottomNav> {
  //[UserType] variable to be updated based on logged in user

  @override
  void initState() {
    //init push notification listeners
    // FirebaseMessagingUtils.pushNotificationListenerInit(context: context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavVm = ref.watch(bottomNavViewModel);
    final authVm = ref.watch(
      authenticationViewModel,
    ); //todo::>>>temp till dashboard data is provided

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, result) async {
        if (didPop) {
          return;
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        key: bottomNavVm.scaffoldKey,
        drawer: const MenuDrawer(),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 16.h),
            child: BottomNavigationBar(
              onTap: (index) => bottomNavVm.updateIndex(index),
              type: BottomNavigationBarType.fixed,
              unselectedFontSize: 14.sp,
              selectedFontSize: 14.sp,
              selectedItemColor: ColorPath.shamrockGreen,
              unselectedItemColor: Theme.of(context).colorScheme.text5,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
              elevation: 10,
              backgroundColor: Theme.of(context).colorScheme.whiteText,
              currentIndex: bottomNavVm.currentIndex,

              items: bottomNavItems(
                authVm.authorizationResponse?.user?.userEnumType ??
                    UserType.worker,
              ),
            ),
          ),
        ),
        body: SafeArea(
          top: false, //todo: add app upgrader package
          child: IndexedStack(
            index: bottomNavVm.currentIndex,
            children: bottomNavVm.handleBottomNavChildren(
              authVm.authorizationResponse?.user?.userEnumType ??
                  UserType.worker,
            ),
          ),
        ),
      ),
    );
  }
}
