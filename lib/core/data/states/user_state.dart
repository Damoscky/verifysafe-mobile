import 'package:flutter/material.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';

class UserState extends ChangeNotifier {
  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  ViewState _passwordState = ViewState.idle;
  ViewState get passwordState => _passwordState;

  void setState(ViewState viewState, {bool notifyListener = true}) {
    _state = viewState;
    if (notifyListener) {
      notifyListeners();
    }
  }

  void setPasswordState(ViewState viewState) {
    _passwordState = viewState;
    notifyListeners();
  }
}
