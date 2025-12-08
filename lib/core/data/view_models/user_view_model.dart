import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verifysafe/core/constants/app_constants.dart';
import 'package:verifysafe/core/data/data_providers/users_data_providers/user_data_provider.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/models/user.dart';
import 'package:verifysafe/core/data/states/user_state.dart';
import 'package:verifysafe/core/utilities/utilities.dart';
import 'package:verifysafe/locator.dart';

class UserViewModel extends UserState {
  final UserDataProvider _userDataProvider = locator<UserDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  User? _userData;
  User? get userData => _userData;

  String? get avatar => _userData?.avatar;
  String get firstName => _userData?.name?.split(' ').first ?? '';
  String get lastName => _userData?.name?.split(' ').last ?? '';

  set userData(User? user) {
    _userData = user;
    notifyListeners();
  }

  getUserData() async {
    setState(ViewState.busy);
    _userDataProvider.getUser().then(
      (response) {
        _message = response.message ?? defaultSuccessMessage;
        _userData = response.data;
        setState(ViewState.retrieved);
      },
      onError: (error) {
        _message = Utilities.formatMessage(error.toString(), isSuccess: false);
        setState(ViewState.error);
      },
    );
  }

  updateUserData({required Map<String, dynamic> details}) async {
    setState(ViewState.busy);
    details['action'] = "profile";
    _userDataProvider
        .updateUser(details: details)
        .then(
          (response) {
            _message = response.message ?? defaultSuccessMessage;
            _userData = response.data;
            setState(ViewState.retrieved);
          },
          onError: (error) {
            _message = Utilities.formatMessage(
              error.toString(),
              isSuccess: false,
            );
            setState(ViewState.error);
          },
        );
  }
}

final userViewModel = ChangeNotifierProvider<UserViewModel>((ref) {
  return UserViewModel();
});
