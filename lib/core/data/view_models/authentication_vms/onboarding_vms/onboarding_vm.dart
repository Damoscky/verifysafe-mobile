import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/data/states/base_state.dart';

class OnboardingVm extends BaseState{

  List<String> assets = [
    AppAsset.worker,
    AppAsset.agency,
    AppAsset.employer
  ];

  List<String> titles = [
    'Worker',
    'Agency/Agent',
    'Employer/Organisation'
  ];

  List<String> subtitles = [
    'I am a working professional',
    'I recruit workers for businesses',
    'I want to employ worker for my business'
  ];

  int? _userType;
  int? get userType => _userType;
  set userType(int? val){
    _userType = val;
    notifyListeners();
  }


  int workerSteps = 5;
  int agencySteps = 4;
  int employerSteps = 6;



  int totalSteps(){
    switch(_userType){
      case 0:
        return workerSteps;
      case 1:
        return agencySteps;
      case 2:
      default:
        return employerSteps;
    }
  }

  int currentStep({required String name}){
    switch(name.toLowerCase()){
      case 'basic info':
      case 'agency info':
      case 'business info':
        return 1;
      case 'identity verification':
        return 2;
      case 'employment details':
      case 'contact person':
        return 3;
      case 'services':
        return 4;
      case 'guarantor info':
        if(_userType == 0){
          return 4;
       }
        else {
          return 5;
        }
      case 'create password':
        if(_userType == 1)return 4;
        if(_userType == 2)return 6;
        return 5;
      default:
        return 0;
    }
  }




}

final onboardingViewModel = ChangeNotifierProvider.autoDispose<OnboardingVm>((ref) {
  return OnboardingVm();
});