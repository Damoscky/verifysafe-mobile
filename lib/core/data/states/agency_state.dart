import 'package:flutter/material.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';

class AgencyState extends ChangeNotifier {
  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  void setState(ViewState viewState, {bool notifyListener = true}) {
    _state = viewState;
    if (notifyListener) {
      notifyListeners();
    }
  }
}