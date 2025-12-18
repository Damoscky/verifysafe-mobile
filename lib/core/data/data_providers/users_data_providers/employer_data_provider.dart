import 'dart:async';

import 'package:verifysafe/core/constants/api_routes.dart';
import 'package:verifysafe/core/data/enum/request_type.dart';
import 'package:verifysafe/core/data/models/responses/api_response.dart';
import 'package:verifysafe/core/data/models/responses/response_data/pagination_data.dart';
import 'package:verifysafe/core/data/models/responses/response_data/stats.dart';
import 'package:verifysafe/core/data/models/user.dart';
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

  /// Fetch [UserType.employer] attached to Agency
  Future<ApiResponse<PaginationData>> fetchEmployers({
    String? query,
     String? keyword,
    int? limit,
    int? pageNumber,
  }) async {
    var completer = Completer<ApiResponse<PaginationData>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.get,
            ApiRoutes.employers,
            useAuth: true,
            queryParameters: {
              "paginate": "1",
              "limit": limit,
              "page": pageNumber,
              "q": query ?? keyword,
            },
          );
      var result = ApiResponse<PaginationData>.fromJson(
        response,
        (data) => PaginationData<User>.fromJson(
          data as Map<String, dynamic>,
          (e) => User.fromJson(e),
        ),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }
}
