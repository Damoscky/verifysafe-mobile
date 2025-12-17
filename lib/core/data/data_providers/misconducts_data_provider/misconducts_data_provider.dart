import 'dart:async';
import 'package:verifysafe/core/data/models/responses/response_data/misconduct_data.dart';
import '../../../constants/api_routes.dart';
import '../../enum/request_type.dart';
import '../../models/responses/api_response.dart';
import '../../network_manager/network_manager.dart';

class MisconductsDataProvider{

  //fetch misconduct reports
  Future<ApiResponse<MisconductData>> fetchMisconductReports({String? filterOptions}) async {
    var completer = Completer<ApiResponse<MisconductData>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
        RequestType.get,
        ApiRoutes.fetchMisconducts(filterOptions: filterOptions),
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


}