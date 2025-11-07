import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verifysafe/core/data/enum/user_type.dart';
import 'package:verifysafe/ui/pages/home/home.dart';

class BottomNavViewModel extends ChangeNotifier {
  //current index of the bottom nav-bar
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  void setCurrentIndex(int value, {bool refreshUi = true}) {
    _currentIndex = value;
    if (refreshUi) {
      notifyListeners();
    }
  }

  //children of the bottom Nav
  List<Widget> handleBottomNavChildren(UserType type) {
    switch (type) {
      //replace [Container]s with Screen widgets
      case UserType.worker:
        return [Home(), Container(), Container()];
      case UserType.agency:
        return [Home(), Container(), Container(), Container()];
      case UserType.employer:
        return [Home(), Container(), Container()];
    }
  }

  //updates the current index of the bottom nav
  void updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

final bottomNavViewModel =
    ChangeNotifierProvider.autoDispose<BottomNavViewModel>((ref) {
      return BottomNavViewModel();
    });
