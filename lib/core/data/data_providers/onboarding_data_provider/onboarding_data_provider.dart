import 'dart:async';
import 'dart:convert';

import 'package:verifysafe/core/constants/api_routes.dart';
import 'package:verifysafe/core/data/enum/request_type.dart';
import 'package:verifysafe/core/data/models/responses/api_response.dart';
import 'package:verifysafe/core/data/models/responses/response_data/basic_info_respnse_data.dart';
import 'package:verifysafe/core/data/models/responses/response_data/authorization_response.dart';
import 'package:verifysafe/core/data/models/responses/response_data/verify_onboarding_email_response.dart';
import 'package:verifysafe/core/data/network_manager/network_manager.dart';

class OnboardingDataProvider {
  /// - creates user basic information record
  Future<ApiResponse<BasicInfoRespnseData>> createProfile({
    required Map<String, dynamic> details,
  }) async {
    var completer = Completer<ApiResponse<BasicInfoRespnseData>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.post,
            ApiRoutes.createProfile,
            useAuth: false,
            body: jsonEncode(details),
          );
      var result = ApiResponse<BasicInfoRespnseData>.fromJson(
        response,
        (data) => BasicInfoRespnseData.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  /// - Verifies onboarding email
  Future<ApiResponse<VerifyOnboardingEmailResponse>> verifyOnboardingEmail({
    required Map<String, dynamic> details,
  }) async {
    var completer = Completer<ApiResponse<VerifyOnboardingEmailResponse>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.post,
            ApiRoutes.verifyOnboardingEmail,
            useAuth: false,
            body: jsonEncode(details),
          );
      var result = ApiResponse<VerifyOnboardingEmailResponse>.fromJson(
        response,
        (data) => VerifyOnboardingEmailResponse.fromJson(
          data as Map<String, dynamic>,
        ),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  /// - Verifies onboarding email
  Future<ApiResponse<AuthorizationResponse>> setupPassword({
    required Map<String, dynamic> details,
  }) async {
    var completer = Completer<ApiResponse<AuthorizationResponse>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.post,
            ApiRoutes.setupPassword,
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

  /// - Creates Agency Info
  Future<ApiResponse<AuthorizationResponse>> createAgencyInfo({
    required Map<String, dynamic> details,
  }) async {
    var completer = Completer<ApiResponse<AuthorizationResponse>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.post,
            ApiRoutes.createAgency,
            useAuth: true,
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

    /// - Creates Agency Info
  Future<ApiResponse<AuthorizationResponse>> createEmployerInfo({
    required Map<String, dynamic> details,
  }) async {
    var completer = Completer<ApiResponse<AuthorizationResponse>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.post,
            ApiRoutes.createEmployer,
            useAuth: true,
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
