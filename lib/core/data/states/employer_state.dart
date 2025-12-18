import 'package:flutter/material.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';

class EmployerState extends ChangeNotifier {
  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  ViewState _secondState = ViewState.idle;
  ViewState get ssecondStatetate => _secondState;

  ViewState _paginatedState = ViewState.idle;
  ViewState get paginatedState => _paginatedState;

  void setState(ViewState viewState, {bool notifyListener = true}) {
    _state = viewState;
    if (notifyListener) {
      notifyListeners();
    }
  }

  void setSecondState(ViewState viewState, {bool notifyListener = true}) {
    _secondState = viewState;
    if (notifyListener) {
      notifyListeners();
    }
  }

  void setPaginatedState(ViewState viewState) {
    _paginatedState = viewState;
    notifyListeners();
  }
}
