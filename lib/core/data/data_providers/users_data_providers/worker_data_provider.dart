import 'dart:async';

import 'package:verifysafe/core/constants/api_routes.dart';
import 'package:verifysafe/core/data/enum/request_type.dart';
import 'package:verifysafe/core/data/models/responses/api_response.dart';
import 'package:verifysafe/core/data/models/responses/response_data/pagination_data.dart';
import 'package:verifysafe/core/data/models/responses/response_data/search_history_data.dart';
import 'package:verifysafe/core/data/models/responses/response_data/worker_dashboard_response.dart';
import 'package:verifysafe/core/data/models/user.dart';
import 'package:verifysafe/core/data/network_manager/network_manager.dart';

class WorkerDataProvider {
  /// Fetch [UserType.worker] Dashboard data
  /// -Total no. of emplyment,Past jobs,Present jobs -> Stats
  /// -Recent work history -> paginated data
  Future<ApiResponse<WorkerDashboardResponse>> workHistoriesOverview({
    String? dateFilter,
    String? query,
    String? status, //current,previous
    int? limit,
    int? pageNumber,
    String? userID,
    bool? unregisteredEmployers,
  }) async {
    var completer = Completer<ApiResponse<WorkerDashboardResponse>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.get,
            ApiRoutes.workHistoriesOverview,
            useAuth: true,
            queryParameters: {
              "paginate": "1",
              "limit": limit,
              "page": pageNumber,
              "status": status,
              "date_filter": dateFilter,
              "q": query,
              "user_id": userID,
              "unregistered_employers": unregisteredEmployers,
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

  /// Fetch [UserType.worker] attached to Agency/Employer
  Future<ApiResponse<PaginationData>> fetchWorkers({
    String? query,
    String? keyword,
    int? limit,
    int? pageNumber,
    //filter options
    String? employmentType,
    String? gender,
    String? status,
    String? dateFilter,
    String? sortBy,
  }) async {
    var completer = Completer<ApiResponse<PaginationData>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.get,
            ApiRoutes.workers,
            useAuth: true,
            queryParameters: {
              "paginate": "1",
              "limit": limit,
              "page": pageNumber,
              "q": query ?? keyword,
              "employment_type": employmentType,
              "gender": gender,
              "status": status,
              "date_filter": dateFilter,
              "sort_by": sortBy,
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

  /// Search Platform [UserType.worker]
  Future<ApiResponse<List<User>>> searchWorker({String? query}) async {
    var completer = Completer<ApiResponse<List<User>>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.get,
            ApiRoutes.searchWorker,
            useAuth: true,
            queryParameters: {"q": query},
          );
      var result = ApiResponse<List<User>>.fromJson(
        response,
        (data) => List.from(data).map((e) => User.fromJson(e)).toList(),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  Future<ApiResponse<List<SearchHistoryData>>> fetchHistory() async {
    var completer = Completer<ApiResponse<List<SearchHistoryData>>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.get,
            ApiRoutes.historySearch,
            useAuth: true,
          );
      var result = ApiResponse<List<SearchHistoryData>>.fromJson(
        response,
        (data) => List.from(data).map((e) => SearchHistoryData.fromJson(e)).toList(),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }
}
