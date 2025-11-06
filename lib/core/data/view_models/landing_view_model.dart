import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../constants/app_asset.dart';


class LandingViewModel extends ChangeNotifier{

  //scroll controller
  final SwiperController _swiperController = SwiperController();
  SwiperController get swiperController => _swiperController;

  //index for swiper
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;


  final List<String> _images = [
    AppAsset.onboardingImage1,
    AppAsset.onboardingImage2,
    AppAsset.onboardingImage3
  ];
  List<String> get images => _images;

  final List<String> _titles = [
    "Let’s Get to Know You",
    "Build Trust with Verification",
    "Share Your Experience",
  ];
  List<String> get titles => _titles;

  final List<String> _subtitles = [
    "Create your worker profile to start your verification \njourney.",
    "Verify your identity and add a guarantor to increase \nyour chances of getting hired.",
    "Help employers understand your experience\n and skills.",
  ];
  List<String> get subtitles => _subtitles;




  void moveToNext(){
    _swiperController.move(_currentIndex + 1);
    notifyListeners();
  }

  void moveToEnd(){
    _swiperController.move(2);
    notifyListeners();
  }

  void moveToPrevious(){
    _swiperController.move(_currentIndex - 1);
    notifyListeners();
  }

  void updateIndex(index){
    _currentIndex = index;
    print('updating:::$_currentIndex');
    notifyListeners();
  }


  @override
  void dispose() {
    _swiperController.dispose();
    super.dispose();
  }



}

final landingViewModel = ChangeNotifierProvider.autoDispose<LandingViewModel>((ref){
  return LandingViewModel();
});