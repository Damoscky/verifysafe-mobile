import 'dart:async';
import 'dart:convert';

import 'package:verifysafe/core/constants/api_routes.dart';
import 'package:verifysafe/core/data/enum/request_type.dart';
import 'package:verifysafe/core/data/models/billing_plan.dart';
import 'package:verifysafe/core/data/models/responses/api_response.dart';
import 'package:verifysafe/core/data/models/responses/response_data/billing_dashboard_response.dart';
import 'package:verifysafe/core/data/models/responses/response_data/default_response.dart';
import 'package:verifysafe/core/data/models/responses/response_data/init_payment_response.dart';
import 'package:verifysafe/core/data/models/responses/response_data/subscription_response.dart';
import 'package:verifysafe/core/data/network_manager/network_manager.dart';

class BillingDataProviders {
  /// - fetches available [BillingPlan] lists
  Future<ApiResponse<List<BillingPlan>>> fetchBillings() async {
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

  /// - initializes  [BillingPlan] payment
  Future<ApiResponse<InitPaymentResponse>> initBillPayment({
    required Map<String, dynamic> details,
  }) async {
    var completer = Completer<ApiResponse<InitPaymentResponse>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.post,
            ApiRoutes.initBilling,
            useAuth: true,
            body: jsonEncode(details),
          );
      var result = ApiResponse<InitPaymentResponse>.fromJson(
        response,
        (data) => InitPaymentResponse.fromJson(data),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  /// - verify  [BillingPlan] payment
  Future<ApiResponse<SubscriptionResponse>> verifyBillPayment({
    required Map<String, dynamic> details,
  }) async {
    var completer = Completer<ApiResponse<SubscriptionResponse>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.post,
            ApiRoutes.verifyBillPaymment,
            useAuth: true,
            body: jsonEncode(details),
          );
      var result = ApiResponse<SubscriptionResponse>.fromJson(
        response,
        (data) => SubscriptionResponse.fromJson(data),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  /// - cancel  [BillingPlan] subscription
  Future<ApiResponse<DefaultResponse>> cancel() async {
    var completer = Completer<ApiResponse<DefaultResponse>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.post,
            ApiRoutes.cancel,
            useAuth: true,
            // body: jsonEncode(details),
          );
      var result = ApiResponse<DefaultResponse>.fromJson(
        response,
        (data) => DefaultResponse.fromJson(data),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  /// Fetch [UserType.worker] attached to Agency/Employer
  Future<ApiResponse<BillingDashboardResponse>> fetchBillingHistory({
    required String userID,
    String? query,
    int? limit,
    int? pageNumber,
    //filter options
    String? dateFilter,
    String? sortBy,
  }) async {
    var completer = Completer<ApiResponse<BillingDashboardResponse>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.get,
            ApiRoutes.getHistory(userID: userID),
            useAuth: true,
            queryParameters: {
              "paginate": "1",
              "limit": limit,
              "page": pageNumber,
              "q": query,
              "date_filter": dateFilter,
              "sort_by": sortBy,
            },
          );
      var result = ApiResponse<BillingDashboardResponse>.fromJson(
        response,
        (data) => BillingDashboardResponse.fromJson(data),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }
}
