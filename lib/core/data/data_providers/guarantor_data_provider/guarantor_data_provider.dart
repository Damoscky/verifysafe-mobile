import 'dart:async';
import 'dart:convert';
import 'package:verifysafe/core/data/models/guarantor.dart';
import 'package:verifysafe/core/data/models/responses/response_data/guarantor_data.dart';
import '../../../constants/api_routes.dart';
import '../../enum/request_type.dart';
import '../../models/responses/api_response.dart';
import '../../network_manager/network_manager.dart';

class GuarantorDataProvider{

  Future<ApiResponse<GuarantorData>> fetchGuarantors({String? filterOptions}) async {
    var completer = Completer<ApiResponse<GuarantorData>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
        RequestType.get,
        ApiRoutes.fetchGuarantors(filterOptions: filterOptions),
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

  //create guarantor
  Future<ApiResponse<Guarantor>> addGuarantor({required Map<String, dynamic> details}) async {
    var completer = Completer<ApiResponse<Guarantor>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
        RequestType.post,
        ApiRoutes.createGuarantor,
        body: jsonEncode(details)
      );
      var result = ApiResponse<Guarantor>.fromJson(
        response,
            (data) => Guarantor.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //deactivate guarantor
  Future<ApiResponse<Guarantor>> deactivateGuarantor({required String? id}) async {
    var completer = Completer<ApiResponse<Guarantor>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
          RequestType.put,
          ApiRoutes.toggleStatus(id: id),
      );
      var result = ApiResponse<Guarantor>.fromJson(
        response,
            (data) => Guarantor.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }
}