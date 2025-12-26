import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verifysafe/core/constants/app_constants.dart';
import 'package:verifysafe/core/data/data_providers/auth_data_provider/auth_data_provider.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/models/responses/response_data/authorization_response.dart';
import 'package:verifysafe/core/data/states/base_state.dart';
import 'package:verifysafe/core/utilities/secure_storage/secure_storage_utils.dart';
import 'package:verifysafe/core/utilities/utilities.dart';
import 'package:verifysafe/locator.dart';

class AuthenticationViewModel extends BaseState {
  final AuthDataProvider _authDp = locator<AuthDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  AuthorizationResponse? _authorizationResponse;
  AuthorizationResponse? get authorizationResponse => _authorizationResponse;
  /// updates [AuthorizationResponse] when user onbards and access dashboard directly without login in.
  set authorizationResponse(AuthorizationResponse? res) {
    _authorizationResponse = res;
    notifyListeners();
  }

  /// updates [AuthorizationResponse] onboarding data
//  updateOnboarding(AuthorizationResponse? res){
//   _authorizationResponse?.onboarding = res?.onboarding;
//     notifyListeners();
//  }

updateUI(){
  notifyListeners();
}

  String? get currentStep => _authorizationResponse?.onboarding?.currentStep;
  String? get userId => _authorizationResponse?.user?.id;

  login({required String email, required String password}) async {
    setState(ViewState.busy);
    final details = {
      "identifier": email,
      "password": password,
      "signin_via": "api_tokens",
    };

    await _authDp
        .signIn(details: details)
        .then(
          (response) async {
            _message = response.message ?? defaultSuccessMessage;
            _authorizationResponse = response.data;
            //handle session mgt
            await SecureStorageUtils.saveToken(
              token: _authorizationResponse?.accessToken ?? '',
            );
            await SecureStorageUtils.saveUser(user: jsonEncode(_authorizationResponse?.user?.toJson()));
            await SecureStorageUtils.savePassword(value: password);
            await SecureStorageUtils.save2FA(value: _authorizationResponse?.twoFaEnabled ?? false);
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

final authenticationViewModel = ChangeNotifierProvider<AuthenticationViewModel>(
  (ref) {
    return AuthenticationViewModel();
  },
);
