import 'dart:async';

import 'package:verifysafe/core/constants/api_routes.dart';
import 'package:verifysafe/core/data/enum/request_type.dart';
import 'package:verifysafe/core/data/models/responses/api_response.dart';
import 'package:verifysafe/core/data/models/responses/response_data/stats.dart';
import 'package:verifysafe/core/data/network_manager/network_manager.dart';

import '../../models/user.dart';

class EmployerDataProvider {
  /// Fetch [UserType.employer] Dashboard stat
  Future<ApiResponse<Stats>> fetchDashboardStats() async {
    var completer = Completer<ApiResponse<Stats>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.get,
            ApiRoutes.employerDashboardStats,
            useAuth: true,
          );
      var result = ApiResponse<Stats>.fromJson(
        response,
        (data) => Stats.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  /// Fetch employers
  Future<ApiResponse<List<User>>> fetchEmployers({
    required String? keyword
  }) async {
    var completer = Completer<ApiResponse<List<User>>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
        RequestType.get,
        ApiRoutes.fetchEmployers(keyword: keyword),
        useAuth: true,
      );
      var result = ApiResponse<List<User>>.fromJson(
        response,
            (data) => List.from(
          data,
        ).map((e) => User.fromJson(e as Map<String, dynamic>)).toList(),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }
}
