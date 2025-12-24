import 'dart:async';
import 'dart:convert';
import 'package:verifysafe/core/data/models/misconduct.dart';
import 'package:verifysafe/core/data/models/responses/response_data/misconduct_data.dart';
import '../../../constants/api_routes.dart';
import '../../enum/request_type.dart';
import '../../models/responses/api_response.dart';
import '../../network_manager/network_manager.dart';

class MisconductsDataProvider{

  //fetch misconduct reports
  Future<ApiResponse<MisconductData>> fetchMisconductReports({String? filterOptions, required int? pageNumber}) async {
    var completer = Completer<ApiResponse<MisconductData>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
        RequestType.get,
        ApiRoutes.fetchMisconducts(filterOptions: filterOptions, pageNumber: pageNumber),
      );
      var result = ApiResponse<MisconductData>.fromJson(
        response,
            (data) => MisconductData.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //create report
  Future<ApiResponse<Misconduct>> submitReport({required Map<String, dynamic> details}) async {
    var completer = Completer<ApiResponse<Misconduct>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
          RequestType.post,
          ApiRoutes.createMisconductReport,
          body: jsonEncode(details)
      );
      var result = ApiResponse<Misconduct>.fromJson(
        response,
            (data) => Misconduct.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //delete report
  Future<ApiResponse> deleteReport({required String? id}) async {
    var completer = Completer<ApiResponse>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.delete, ApiRoutes.deleteReport(id: id),
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