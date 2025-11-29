import 'dart:async';

import 'package:verifysafe/core/constants/api_routes.dart';
import 'package:verifysafe/core/data/enum/request_type.dart';
import 'package:verifysafe/core/data/models/responses/api_response.dart';
import 'package:verifysafe/core/data/models/responses/response_data/demographic_responses_data.dart';
import 'package:verifysafe/core/data/models/responses/response_data/dropdown_response.dart';
import 'package:verifysafe/core/data/network_manager/network_manager.dart';

class GeneralDataProvider {
  /// - fetches available [Country] lists
  Future<ApiResponse<List<Country>>> getCountries() async {
    var completer = Completer<ApiResponse<List<Country>>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.get,
            ApiRoutes.getCountries,
            useAuth: false,
            // body: jsonEncode(details),
          );
      var result = ApiResponse<List<Country>>.fromJson(
        response,
        (data) => List.from(
          data,
        ).map((e) => Country.fromJson(e as Map<String, dynamic>)).toList(),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  /// - fetches available [State] lists
  Future<ApiResponse<List<State>>> getStates({
    int? countryId,
    int? isNigerian,
  }) async {
    var completer = Completer<ApiResponse<List<State>>>();
    final queryParameters = {
      "country_id": countryId,
      "is_nigerian": isNigerian,
    };
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.get,
            ApiRoutes.getStates,
            useAuth: false,
            queryParameters: queryParameters,
          );
      var result = ApiResponse<List<State>>.fromJson(
        response,
        (data) => List.from(
          data,
        ).map((e) => State.fromJson(e as Map<String, dynamic>)).toList(),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }


  /// - fetches available [City] lists
  Future<ApiResponse<List<City>>> getCitys({
    int? stateId,
    int? isNigerian,
  }) async {
    var completer = Completer<ApiResponse<List<City>>>();
    final queryParameters = {
      "state_id": stateId,
      "is_nigerian": isNigerian,
    };
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.get,
            ApiRoutes.getCities,
            useAuth: false,
            queryParameters: queryParameters,
          );
      var result = ApiResponse<List<City>>.fromJson(
        response,
        (data) => List.from(
          data,
        ).map((e) => City.fromJson(e as Map<String, dynamic>)).toList(),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

    /// - fetches available [DropdownResponse] lists
  Future<ApiResponse<DropdownResponse>> getDropdownData() async {
    var completer = Completer<ApiResponse<DropdownResponse>>();

    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.get,
            ApiRoutes.getDropDowns,
            useAuth: false,
          );
      var result = ApiResponse<DropdownResponse>.fromJson(
        response,
        (data) => DropdownResponse.fromJson(data as Map<String,dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }
}
