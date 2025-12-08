import 'dart:async';
import 'dart:convert';

import 'package:verifysafe/core/constants/api_routes.dart';
import 'package:verifysafe/core/data/enum/request_type.dart';
import 'package:verifysafe/core/data/models/responses/api_response.dart';
import 'package:verifysafe/core/data/models/user.dart';
import 'package:verifysafe/core/data/network_manager/network_manager.dart';

class UserDataProvider {
  /// - Fetches current [User] data
  Future<ApiResponse<User>> getUser() async {
    var completer = Completer<ApiResponse<User>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.get,
            ApiRoutes.getUser,
            useAuth: true,
          );
      var result = ApiResponse<User>.fromJson(
        response,
        (data) => User.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

    /// - Fetches current [User] data
  Future<ApiResponse<User>> updateUser({required Map<String,dynamic> details}) async {
    var completer = Completer<ApiResponse<User>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.put,
            ApiRoutes.profile,
            useAuth: true,
            body: jsonEncode(details)
          );
      var result = ApiResponse<User>.fromJson(
        response,
        (data) => User.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }
}
