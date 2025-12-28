import 'dart:async';

import 'package:verifysafe/core/constants/api_routes.dart';
import 'package:verifysafe/core/data/enum/request_type.dart';
import 'package:verifysafe/core/data/models/billing_plan.dart';
import 'package:verifysafe/core/data/models/responses/api_response.dart';
import 'package:verifysafe/core/data/network_manager/network_manager.dart';

class BillingDataProviders {
    /// - fetches available [BillingPlan] lists
  Future<ApiResponse<List<BillingPlan>>> getCountries() async {
    var completer = Completer<ApiResponse<List<BillingPlan>>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.get,
            ApiRoutes.billings,
            useAuth: false,
            // body: jsonEncode(details),
          );
      var result = ApiResponse<List<BillingPlan>>.fromJson(
        response,
        (data) => List.from(
          data,
        ).map((e) => BillingPlan.fromJson(e as Map<String, dynamic>)).toList(),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }
}