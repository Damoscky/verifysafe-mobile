import 'dart:async';
import 'dart:convert';
import '../../../constants/api_routes.dart';
import '../../enum/request_type.dart';
import '../../models/responses/api_response.dart';
import '../../network_manager/network_manager.dart';



class EmploymentDataProvider{

  //terminate employment contract
  Future<ApiResponse> terminateEmploymentContract({required Map<String, dynamic> details}) async {
    var completer = Completer<ApiResponse>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.post, ApiRoutes.terminateContract,
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

  //todo: accept/reject contract request

}