import 'dart:convert';

import 'package:verifysafe/core/constants/app_constants.dart';
import 'package:verifysafe/core/data/data_providers/auth_data_provider/auth_data_provider.dart';
import 'package:verifysafe/core/data/data_providers/onboarding_data_provider/onboarding_data_provider.dart';
import 'package:verifysafe/core/data/enum/otp_type.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/models/responses/response_data/authorization_response.dart';
import 'package:verifysafe/core/data/models/responses/response_data/reset_password_detail.dart';
import 'package:verifysafe/core/data/states/base_state.dart';
import 'package:verifysafe/core/utilities/secure_storage/secure_storage_utils.dart';
import 'package:verifysafe/core/utilities/utilities.dart';
import 'package:verifysafe/locator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OtpViewModel extends BaseState {
  //otp data provider
  //final OtpDataProvider _otpDataProvider = locator<OtpDataProvider>();
  //auth data provider
  final AuthDataProvider _authDp = locator<AuthDataProvider>();
  //onboarding data provider
  final OnboardingDataProvider _onboardingDp =
      locator<OnboardingDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  ResetPasswordDetail? _resendOtpData;
  ResetPasswordDetail? get resendOtpData => _resendOtpData;

  /// Verify Forgotten Password OTP
  verifyForgetPasswordOTP({required String otp, required String token}) async {
    setResetPasswordState(ViewState.busy);
    final details = {"token": token, "otp": otp};

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

  String? _onboardingId;
  String? get onboardingId => _onboardingId;

  /// Verify Basic info email
  verifyOnboardingEmail({required String otp, required String token}) async {
    setState(ViewState.busy);
    final details = {"token": token, "otp": otp};

    await _onboardingDp
        .verifyOnboardingEmail(details: details)
        .then(
          (response) {
            _message = response.message ?? defaultSuccessMessage;
            _onboardingId = response.data?.onboardingId;
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

  AuthorizationResponse? _authorizationResponse;
  AuthorizationResponse? get authorizationResponse => _authorizationResponse;

    /// Verify 2FA otp
  verify2FA({required String otp, required String token}) async {
    setState(ViewState.busy);
    final details = {"token": token, "otp": otp, "action": "2fa-signin"};

    await _authDp
        .verify2FA(details: details)
        .then(
          (response) async {
            _message = response.message ?? defaultSuccessMessage;
            _authorizationResponse = response.data;
            //handle session mgt
            await SecureStorageUtils.saveToken(
              token: _authorizationResponse?.accessToken ?? '',
            );
            await SecureStorageUtils.saveUser(user: jsonEncode(_authorizationResponse?.user));
            await SecureStorageUtils.save2FA(value: _authorizationResponse?.twoFaEnabled ?? false);
            await SecureStorageUtils.savePN(value: _authorizationResponse?.user?.pushNotificationEnabled ?? false);

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

  resendOTP({required String email, required OtpType otpType}) async {
    setSecondState(ViewState.busy);
    String action = '';
    switch (otpType) {
      case OtpType.forgotPassword:
        action = 'forgot-password';
        break;
      case OtpType.verifyEmail:
        action = 'signup';
        break;
      default:
        action = '2fa-signin';
    }

    final details = {"identifier": email, "action": action};

    await _authDp
        .resendPasswordOTP(details: details)
        .then(
          (response) {
            _message = response.message ?? defaultSuccessMessage;
            _resendOtpData = response.data;
            setSecondState(ViewState.retrieved);
          },
          onError: (error) {
            _message = Utilities.formatMessage(
              error.toString(),
              isSuccess: false,
            );
            setSecondState(ViewState.error);
          },
        );
  }

  handleVerifyOtp({
    required OtpType otpType,
    required String otp,
    String? token,
  }) async {
    switch (otpType) {
      case OtpType.forgotPassword:
        await verifyForgetPasswordOTP(otp: otp, token: _resendOtpData == null ? token! : _resendOtpData?.verificationToken ?? '');
        break;
      case OtpType.verifyEmail:
        await verifyOnboardingEmail(otp: otp, token: _resendOtpData == null ? token! : _resendOtpData?.verificationToken ?? '');
        break;
      case OtpType.twoFA:
        await verify2FA(otp: otp, token: _resendOtpData == null ? token! : _resendOtpData?.verificationToken ?? '');
        break;
      default:
    }
  }

  //resends otp based on OtpType
  // resendOtp({
  //   required OtpType otpType,
  //   required int? userId,
  //   String? passKey,
  //   int? paymentId,
  // }) async {
  //   setState(ViewState.busy);
  //   Map<String, dynamic>? details;
  //   if(otpType == OtpType.upgradeAccountLimit){
  //     details = {
  //       'passkey': passKey,
  //       'resend': true
  //     };
  //   }
  //   await _otpDataProvider
  //       .resendOtp(otpType: otpType, userId: userId, paymentId: paymentId, details: details)
  //       .then((response) {
  //     _message = response.message ?? defaultSuccessMessage;
  //     setState(ViewState.retrieved);
  //   }, onError: (e) {
  //     _message = Utilities.formatMessage(e.toString(), isSuccess: false);
  //     setState(ViewState.error);
  //   });
  // }

  //validate otp based on OtpType
  // validateOtp(
  //     {required OtpType otpType,
  //     required int? userId,
  //     int? paymentId,
  //     required String otp,
  //     double? amount}) async {
  //   setState(ViewState.busy);
  //   Map<String, dynamic>? details;
  //   if(otpType == OtpType.upgradeAccountLimit){
  //     details = {'otp': otp, 'amount':amount};
  //   }else if(otpType == OtpType.deviceBinding){
  //     final deviceId = await Utilities.getDeviceId();
  //     details = {'code': otp, 'deviceID':deviceId};
  //   } else{
  //     details = {'code': otp};
  //   }
  //   await _otpDataProvider
  //       .validateOtp(
  //           otpType: otpType,
  //           userId: userId,
  //           paymentId: paymentId,
  //           otp: details)
  //       .then((response) {
  //     _message = response.message ?? defaultSuccessMessage;
  //     setState(ViewState.retrieved);
  //   }, onError: (e) {
  //     _message = Utilities.formatMessage(e.toString(), isSuccess: false);
  //     setState(ViewState.error);
  //   });
  // }

  //returns title for otp screen
  String otpTitle({required OtpType otpType}) {
    if (otpType == OtpType.forgotPassword) {
      return "Code Sent";
    }
    if (otpType == OtpType.verifyEmail) {
      return "Email Verification";
    }

    return "Enter OTP to Authenticate this Action";
  }

  //returns sub-title for otp screen
  List<String> otpSubtitle({required OtpType otpType}) {
    if (otpType == OtpType.forgotPassword) {
      final message = "We’ve sent a unique code to|so you can confirm ownership. Please enter the code below.";
      return message.split('|');
    }

    if(otpType == OtpType.verifyEmail){
      final message = "A unique code to have been sent to|for email verification. Please enter the code below.";
      return message.split('|');
    }


    final message =  "A unique code to have been sent to|.Please enter the code below.";
    return message.split('|');
  }
}

final otpViewModel = ChangeNotifierProvider.autoDispose<OtpViewModel>((ref) {
  return OtpViewModel();
});
