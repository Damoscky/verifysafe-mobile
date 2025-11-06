import 'package:verifysafe/core/constants/app_constants.dart';
import 'package:verifysafe/core/data/enum/otp_type.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/states/base_state.dart';
import 'package:verifysafe/core/utilities/utilities.dart';
import 'package:verifysafe/locator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OtpViewModel extends BaseState {
  //otp data provider
  //final OtpDataProvider _otpDataProvider = locator<OtpDataProvider>();

  //message
  String _message = '';
  String get message => _message;

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
      final message = "We’ve sent a unique code to||so you can confirm ownership. Please enter the code below.";
      return message.split('||');
    }


    final message =  "A unique code to have been sent to||.Please enter the code below.";
    return message.split('||');
  }
}

final otpViewModel = ChangeNotifierProvider.autoDispose<OtpViewModel>((ref) {
  return OtpViewModel();
});
