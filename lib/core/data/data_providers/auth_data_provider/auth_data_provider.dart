import 'dart:async';
import 'dart:convert';

import 'package:verifysafe/core/constants/api_routes.dart';
import 'package:verifysafe/core/data/enum/request_type.dart';
import 'package:verifysafe/core/data/models/responses/api_response.dart';
import 'package:verifysafe/core/data/models/responses/response_data/authorization_response.dart';
import 'package:verifysafe/core/data/models/responses/response_data/default_response.dart';
import 'package:verifysafe/core/data/models/responses/response_data/reset_password_detail.dart';
import 'package:verifysafe/core/data/network_manager/network_manager.dart';

class AuthDataProvider {
  /// - Forgot Password Reset
  Future<ApiResponse<ResetPasswordDetail>> resetForgetPassword({
    required Map<String, dynamic> details,
  }) async {
    var completer = Completer<ApiResponse<ResetPasswordDetail>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.post,
            ApiRoutes.resetForgetPassword,
            useAuth: false,
            body: jsonEncode(details),
          );
      var result = ApiResponse<ResetPasswordDetail>.fromJson(
        response,
        (data) => ResetPasswordDetail.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

    /// - Forgot Password Reset
  Future<ApiResponse<ResetPasswordDetail>> resendPasswordOTP({
    required Map<String, dynamic> details,
  }) async {
    var completer = Completer<ApiResponse<ResetPasswordDetail>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.post,
            ApiRoutes.resend,
            useAuth: false,
            body: jsonEncode(details),
          );
      var result = ApiResponse<ResetPasswordDetail>.fromJson(
        response,
        (data) => ResetPasswordDetail.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  /// - Verify 2FA OTP
  Future<ApiResponse<AuthorizationResponse>> verify2FA({
    required Map<String, dynamic> details,
  }) async {
    var completer = Completer<ApiResponse<AuthorizationResponse>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.post,
            ApiRoutes.verify,
            useAuth: false,
            body: jsonEncode(details),
          );
      var result = ApiResponse<AuthorizationResponse>.fromJson(
        response,
        (data) => AuthorizationResponse.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  /// - Recover Forgot Password
  /// -- handles otp verification for forgot password and password reset.
  /// -- Called twice: first with provided token from [resetForgetPassword] and otp
  /// -- and secondly with provided token from [resetForgetPassword] and  new password details
  Future<ApiResponse<DefaultResponse>> recoverForgetPassword({
    required Map<String, dynamic> details,
  }) async {
    var completer = Completer<ApiResponse<DefaultResponse>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.post,
            ApiRoutes.recoverForgetPassword,
            useAuth: false,
            body: jsonEncode(details),
          );
      var result = ApiResponse<DefaultResponse>.fromJson(
        response,
        (data) => DefaultResponse.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

 /// - Sign in and Authenticate User
    Future<ApiResponse<AuthorizationResponse>> signIn({
    required Map<String, dynamic> details,
  }) async {
    var completer = Completer<ApiResponse<AuthorizationResponse>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.post,
            ApiRoutes.signIn,
            useAuth: false,
            body: jsonEncode(details),
          );
      var result = ApiResponse<AuthorizationResponse>.fromJson(
        response,
        (data) => AuthorizationResponse.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }
}
