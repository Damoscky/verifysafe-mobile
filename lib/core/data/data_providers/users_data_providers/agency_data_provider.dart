import 'dart:async';

import 'package:verifysafe/core/constants/api_routes.dart';
import 'package:verifysafe/core/data/enum/request_type.dart';
import 'package:verifysafe/core/data/models/responses/api_response.dart';
import 'package:verifysafe/core/data/models/responses/response_data/stats.dart';
import 'package:verifysafe/core/data/network_manager/network_manager.dart';

class AgencyDataProvider {
  /// Fetch [UserType.employer] Dashboard stat
  Future<ApiResponse<AgencyStats>> fetchDashboardStats() async {
    var completer = Completer<ApiResponse<AgencyStats>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.get,
            ApiRoutes.agencyDashboardStats,
            useAuth: true,
          );
      var result = ApiResponse<AgencyStats>.fromJson(
        response,
        (data) => AgencyStats.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }
}