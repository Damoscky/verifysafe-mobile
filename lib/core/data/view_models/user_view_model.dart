import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verifysafe/core/constants/app_constants.dart';
import 'package:verifysafe/core/data/data_providers/users_data_providers/user_data_provider.dart';
import 'package:verifysafe/core/data/enum/user_type.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/models/user.dart';
import 'package:verifysafe/core/data/states/user_state.dart';
import 'package:verifysafe/core/utilities/secure_storage/secure_storage_utils.dart';
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

  bool get isWorker => userData?.userEnumType == UserType.worker;
  bool get isEmployer => userData?.userEnumType == UserType.employer;
  bool get isAgency => userData?.userEnumType == UserType.agency;

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
    await _userDataProvider
        .updateUser(details: details)
        .then(
          (response) {
            _message = response.message ?? defaultSuccessMessage;
            _userData = response.data;
            SecureStorageUtils.savePN(value: response.data?.pushNotificationEnabled ?? false);
            SecureStorageUtils.saveUser(user: jsonEncode(response.data));
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

  update2FA({required bool value}) async {
    setPasswordState(ViewState.busy);

    final details = {"2fa_enabled": value, "action": "password"};
    await _userDataProvider
        .updateUser(details: details)
        .then(
          (response) async {
            _message = response.message ?? defaultSuccessMessage;
            await SecureStorageUtils.save2FA(value: value);
            setPasswordState(ViewState.retrieved);
          },
          onError: (error) {
            _message = Utilities.formatMessage(
              error.toString(),
              isSuccess: false,
            );
            setPasswordState(ViewState.error);
          },
        );
  }

  updatePassword({
    required String password,
    required String newPassword,
    required String confirmPassword,
  }) async {
    setPasswordState(ViewState.busy);
    Map<String, dynamic> details = {
      "current_password": password,
      "password": newPassword,
      "password_confirmation": confirmPassword,
      "action": "password",
    };
    await _userDataProvider
        .updateUser(details: details)
        .then(
          (response) {
            _message = response.message ?? defaultSuccessMessage;
            setPasswordState(ViewState.retrieved);
          },
          onError: (error) {
            _message = Utilities.formatMessage(
              error.toString(),
              isSuccess: false,
            );
            setPasswordState(ViewState.error);
          },
        );
  }

  updateEmploymentDetails({
    required String category,
    required String jobRole,
    required String experience,
    required String language,
    required String relocateable,
    required String resumeUrl,
  }) async {
    setState(ViewState.busy);
    Map<String, dynamic> details = {
      "category": category,
      "job_role": jobRole,
      "experience": experience,
      "relocatable": relocateable,
      "resume_url": resumeUrl,
      "action": "employment-details",
    };
    await _userDataProvider
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
