import 'package:flutter/material.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';

class WorkerState extends ChangeNotifier {
  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  ViewState _secondState = ViewState.idle ;
  ViewState get secondState => _secondState ;

  void setState(ViewState viewState, {bool notifyListener = true}) {
    _state = viewState;
    if (notifyListener) {
      notifyListeners();
    }
  }

  void setSecondState(ViewState viewState, {bool refreshUi = true}){
    _secondState = viewState ;
    if(refreshUi)notifyListeners() ;
  }
}
