import 'dart:async';
import 'package:verifysafe/core/data/models/responses/response_data/review_data.dart';
import '../../constants/api_routes.dart';
import '../enum/request_type.dart';
import '../models/responses/api_response.dart';
import '../network_manager/network_manager.dart';


class ReviewDataProvider{

  Future<ApiResponse<ReviewData>> fetchRatings({String? filterOptions, required int? pageNumber}) async {
    var completer = Completer<ApiResponse<ReviewData>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
        RequestType.get,
        ApiRoutes.fetchRatings(filterOptions: filterOptions, pageNumber: pageNumber),
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

}