import 'package:flutter/material.dart';
import '../enum/view_state.dart';


class BaseState extends ChangeNotifier{

  ViewState _state = ViewState.idle ;
  ViewState get state => _state ;

  ViewState _secondState = ViewState.idle ;
  ViewState get secondState => _secondState ;

  ViewState _thirdState = ViewState.idle ;
  ViewState get thirdState => _thirdState ;

  ViewState _paginatedState = ViewState.idle ;
  ViewState get paginatedState => _paginatedState ;

  ViewState _secondPaginatedState = ViewState.idle ;
  ViewState get secondPaginatedState => _secondPaginatedState ;

  ViewState _restPasswordState = ViewState.idle ;
  ViewState get restPasswordState => _restPasswordState ;

  ViewState _generalState = ViewState.idle ;
  ViewState get generalState => _generalState ;

  ViewState _generalUploadState = ViewState.idle ;
  ViewState get generalUploadState => _generalUploadState ;

  ViewState _generalDocUploadState = ViewState.idle ;
  ViewState get generalDocUploadState => _generalDocUploadState ;

  void setState(ViewState viewState, {bool notifyListener = true}){
    _state = viewState ;
    if(notifyListener){
      notifyListeners() ;
    }

  }

  void setSecondState(ViewState viewState){
    _secondState = viewState ;
    notifyListeners() ;
  }

  void setThirdState(ViewState viewState){
    _thirdState = viewState ;
    notifyListeners() ;
  }

  void setPaginatedState(ViewState viewState){
    _paginatedState = viewState ;
    notifyListeners() ;
  }

  void setSecondPaginatedState(ViewState viewState){
    _secondPaginatedState = viewState ;
    notifyListeners() ;
  }

  void setResetPasswordState(ViewState viewState){
    _restPasswordState = viewState ;
    notifyListeners() ;
  }

  void setGeneralState(ViewState viewState){
    _generalState = viewState ;
    notifyListeners() ;
  }

  void setGeneralUploadState(ViewState viewState){
    _generalUploadState = viewState ;
    notifyListeners() ;
  }

  void setGeneralDocUploadState(ViewState viewState){
    _generalDocUploadState = viewState ;
    notifyListeners() ;
  }
}