import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verifysafe/core/constants/app_constants.dart';
import 'package:verifysafe/core/data/data_providers/auth_data_provider/auth_data_provider.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/models/responses/response_data/reset_password_detail.dart';
import 'package:verifysafe/core/data/states/base_state.dart';
import 'package:verifysafe/core/utilities/utilities.dart';
import 'package:verifysafe/locator.dart';

import '../../../utilities/secure_storage/secure_storage_utils.dart';

class PasswordVm extends BaseState {
  //auth data provider
  final AuthDataProvider _authDp = locator<AuthDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  final List<String> _pwdRequirements = [
    "must be minimum of 6 characters",
    "contains a symbol or a number",
  ];
  List<String> get pwdRequirements => _pwdRequirements;

  List<bool> _results = [false, false];
  List<bool> get results => _results;

  ResetPasswordDetail? _resetPasswordDetail;
  ResetPasswordDetail? get resetPasswordDetail => _resetPasswordDetail;

  /// Reset Forgotten Password
  resetForgetPassword({required String email}) async {
    setResetPasswordState(ViewState.busy);
    final details = {"identifier": email};

    await _authDp
        .resetForgetPassword(details: details)
        .then(
          (response) {
            _message = response.message ?? defaultSuccessMessage;
            _resetPasswordDetail = response.data;
            setResetPasswordState(ViewState.retrieved);
          },
          onError: (error) {
            _message = Utilities.formatMessage(
              error.toString(),
              isSuccess: false,
            );
            setResetPasswordState(ViewState.error);
          },
        );
  }

  /// create Forgotten Password
  createForgetPassword({
    required String password,
    required String confirmPassword,
  }) async {
    setResetPasswordState(ViewState.busy);
    final details = {
      "token": _resetPasswordDetail?.token,
      "password": password,
      "password_confirmation": confirmPassword,
    };

    await _authDp
        .recoverForgetPassword(details: details)
        .then(
          (response) {
            _message = response.message ?? defaultSuccessMessage;
            setResetPasswordState(ViewState.retrieved);
          },
          onError: (error) {
            _message = Utilities.formatMessage(
              error.toString(),
              isSuccess: false,
            );
            setResetPasswordState(ViewState.error);
          },
        );
  }

  //create new password(forgot password)
  // createNewPassword(
  //     {required String pwd, required String confirmPwd, required String? userId}) async {
  //
  //   if(pwd != confirmPwd){
  //     _message = "Passwords don't match";
  //     setState(ViewState.error);
  //     return;
  //   }
  //
  //   setState(ViewState.busy);
  //
  //   final details = {
  //     "password": pwd,
  //     "password_confirmation": confirmPwd
  //   };
  //   await _authDp.createPassword(details: details, userId: userId).then((response) async{
  //     _message = response.message ?? defaultSuccessMessage;
  //     //await SecureStorageUtils.savePassword(value: password);
  //     setState(ViewState.retrieved);
  //   }, onError: (e) {
  //     _message = Utilities.formatMessage(e.toString(), isSuccess: false);
  //     setState(ViewState.error);
  //   });
  // }

  //update/change password
  // updatePassword(
  //     {required String oldPwd, required String confirmPwd, required String pwd}) async {
  //
  //   if(pwd != confirmPwd){
  //     _message = "Passwords don't march";
  //     setSecondState(ViewState.error);
  //     return;
  //   }
  //
  //   setSecondState(ViewState.busy);
  //
  //   final details = {
  //     "old_password": oldPwd,
  //     "password": pwd,
  //     "password_confirmation": confirmPwd
  //   };
  //   await _authDp.updatePassword(details: details).then((response) async{
  //     _message = response.message ?? defaultSuccessMessage;
  //     await SecureStorageUtils.savePassword(value: pwd);
  //     setSecondState(ViewState.retrieved);
  //   }, onError: (e) {
  //     _message = Utilities.formatMessage(e.toString(), isSuccess: false);
  //     setSecondState(ViewState.error);
  //   });
  // }

  //checks password requirement
  void checkPassWordRequirement({required String password}) {
    final hasMinLength = password.trim().length > 5;
    //final hasUpperCase = password.contains(RegExp(r'[A-Z]'));
    //final hasLowerCase = password.contains(RegExp(r'[a-z]'));
    final hasNumber = password.contains(RegExp(r'[0-9]'));
    final hasSymbol = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    _results = [hasMinLength, (hasNumber || hasSymbol)];
    notifyListeners();
  }

  //checks if all password requirement(s) passed
  bool isPwdValid() {
    bool isValid = true;
    for (bool r in _results) {
      if (!r) {
        isValid = false;
        break;
      }
    }
    return isValid;
  }
}

final passwordViewModel = ChangeNotifierProvider.autoDispose<PasswordVm>((ref) {
  return PasswordVm();
});
