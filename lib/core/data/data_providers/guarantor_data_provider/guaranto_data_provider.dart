import 'dart:async';
import 'package:verifysafe/core/data/models/responses/response_data/guarantor_data.dart';
import '../../../constants/api_routes.dart';
import '../../enum/request_type.dart';
import '../../models/responses/api_response.dart';
import '../../network_manager/network_manager.dart';

class GuarantorDataProvider{

  Future<ApiResponse<GuarantorData>> fetchGuarantors() async {
    var completer = Completer<ApiResponse<GuarantorData>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
        RequestType.get,
        ApiRoutes.fetchGuarantors,
      );
      var result = ApiResponse<GuarantorData>.fromJson(
        response,
            (data) => GuarantorData.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }
}