import 'dart:async';

import 'package:verifysafe/core/constants/api_routes.dart';
import 'package:verifysafe/core/data/enum/request_type.dart';
import 'package:verifysafe/core/data/models/responses/api_response.dart';
import 'package:verifysafe/core/data/models/responses/response_data/worker_dashboard_response.dart';
import 'package:verifysafe/core/data/models/worker/worker.dart';
import 'package:verifysafe/core/data/network_manager/network_manager.dart';

class WorkerDataProvider {
  /// Fetch [UserType.worker] Dashboard data
  /// -Total no. of emplyment,Past jobs,Present jobs -> Stats
  /// -Recent work history -> paginated data
  Future<ApiResponse<WorkerDashboardResponse>> fetchDashboardData({
    String? dateFilter,
    String? query,
    String? status, //current,previous
    int? limit,
  }) async {
    var completer = Completer<ApiResponse<WorkerDashboardResponse>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.get,
            ApiRoutes.workerDashboard,
            useAuth: true,
            queryParameters: {
              "paginate": "1",
              "limit": limit,
              "status": status,
              "date_filter": dateFilter,
              "q": query,
            },
          );
      var result = ApiResponse<WorkerDashboardResponse>.fromJson(
        response,
        (data) =>
            WorkerDashboardResponse.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  /// Fetch workers
  Future<ApiResponse<List<Worker>>> fetchWorkers({
    required String? keyword
  }) async {
    var completer = Completer<ApiResponse<List<Worker>>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
        RequestType.get,
        ApiRoutes.fetchWorkers(keyword: keyword),
        useAuth: true,
      );
      var result = ApiResponse<List<Worker>>.fromJson(
        response,
            (data) => List.from(
          data,
        ).map((e) => Worker.fromJson(e as Map<String, dynamic>)).toList(),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }
}
