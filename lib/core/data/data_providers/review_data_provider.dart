import 'dart:async';
import 'dart:convert';
import 'package:verifysafe/core/data/models/responses/response_data/review_data.dart';
import '../../constants/api_routes.dart';
import '../enum/request_type.dart';
import '../models/responses/api_response.dart';
import '../network_manager/network_manager.dart';


class ReviewDataProvider{

  //fetch ratings for user(worker, employer, agency)
  Future<ApiResponse<ReviewData>> fetchRatings({String? filterOptions, required int? pageNumber, required String? userId}) async {
    var completer = Completer<ApiResponse<ReviewData>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
        RequestType.get,
        ApiRoutes.fetchRatings(filterOptions: filterOptions, pageNumber: pageNumber, userId: userId),
      );
      var result = ApiResponse<ReviewData>.fromJson(
        response,
            (data) => ReviewData.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  Future<ApiResponse> rateUser({required Map<String, dynamic> details}) async {
    var completer = Completer<ApiResponse>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.post, ApiRoutes.rateUser,
        body: jsonEncode(details),
        useAuth: true,
      );
      var result = ApiResponse.fromJson(
          response,
          null);
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //share feedback(rate app and support)
  Future<ApiResponse> shareFeedback({required Map<String, dynamic> details}) async {
    var completer = Completer<ApiResponse>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.post, ApiRoutes.shareFeedback,
        body: jsonEncode(details),
        useAuth: true,
      );
      var result = ApiResponse.fromJson(
          response,
          null);
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

}