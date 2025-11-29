import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/data/enum/user_type.dart';
import 'package:verifysafe/core/data/models/user.dart';
import 'package:verifysafe/core/data/view_models/user_view_model.dart';
import 'package:verifysafe/ui/widgets/menu_drawer.dart';
import '../../core/constants/color_path.dart';
import '../../core/data/view_models/bottom_nav_view_model.dart';
import '../widgets/bottom_nav_items.dart';

class BottomNav extends ConsumerStatefulWidget {
  final User? userData;
  const BottomNav({super.key, this.userData});

  @override
  ConsumerState<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends ConsumerState<BottomNav> {
  //[UserType] variable to be updated based on logged in user

  @override
  void initState() {
    //init push notification listeners
    // FirebaseMessagingUtils.pushNotificationListenerInit(context: context);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (widget.userData != null) {
        ref.read(userViewModel).userData = widget.userData;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavVm = ref.watch(bottomNavViewModel);
    final userVm = ref.watch(userViewModel);

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
        drawer: MenuDrawer(
          userType: userVm.userData?.userEnumType ?? UserType.worker,
        ),
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
                userVm.userData?.userEnumType ?? UserType.worker,
              ),
            ),
          ),
        ),
        body: SafeArea(
          top: false, //todo: add app upgrader package
          child: IndexedStack(
            index: bottomNavVm.currentIndex,
            children: bottomNavVm.handleBottomNavChildren(
              userVm.userData?.userEnumType ?? UserType.worker,
            ),
          ),
        ),
      ),
    );
  }
}
