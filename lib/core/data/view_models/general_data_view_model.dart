import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:verifysafe/core/constants/app_constants.dart';
import 'package:verifysafe/core/data/data_providers/general_data_provider/general_data_provider.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/models/responses/response_data/demographic_responses_data.dart';
import 'package:verifysafe/core/data/models/responses/response_data/dropdown_response.dart';
import 'package:verifysafe/core/data/models/responses/response_data/file_upload_response.dart';
import 'package:verifysafe/core/data/states/base_state.dart';
import 'package:verifysafe/core/utilities/utilities.dart';
import 'package:verifysafe/locator.dart';

class GeneralDataViewModel extends BaseState {
  final GeneralDataProvider _genralDp = locator<GeneralDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  DropdownResponse? _dropdownResponse;
  DropdownResponse? get dropdownResponse => _dropdownResponse;

  List<String> get businessType => _dropdownResponse?.businessType ?? [];
  List<String> get jobCategory => _dropdownResponse?.jobCategory ?? [];
  List<String> get jobRole => _dropdownResponse?.jobRole ?? [];
  List<String> get placementRegion => _dropdownResponse?.placementRegion ?? [];
  List<String> get averagePlacementTIme =>
      _dropdownResponse?.averagePlacementTime ?? [];
  List<String> get relationships => _dropdownResponse?.relationships ?? [];
  List<String> get misconductTypes => _dropdownResponse?.misconductTypes ?? [];

  /// fetches Dropdown Data
  fetchDropdownOptions() async {
    setGeneralState(ViewState.busy);

    await _genralDp.getDropdownData().then(
      (response) {
        _message = response.message ?? defaultSuccessMessage;
        _dropdownResponse = response.data;
        setGeneralState(ViewState.retrieved);
      },
      onError: (error) {
        _message = Utilities.formatMessage(error.toString(), isSuccess: false);
        setGeneralState(ViewState.error);
      },
    );
  }

  List<Country> _countries = [];
  List<Country> get countries => _countries;

  Country? _selectedCountry;
  Country? get selectedCountry => _selectedCountry;
  set selectedCountry(Country? val) {
    _selectedCountry = val;
    notifyListeners();
  }

  /// fetches Countries
  fetchCountries() async {
    setGeneralState(ViewState.busy);

    await _genralDp.getCountries().then(
      (response) {
        _message = response.message ?? defaultSuccessMessage;
        _countries = response.data ?? [];
        setGeneralState(ViewState.retrieved);
      },
      onError: (error) {
        _message = Utilities.formatMessage(error.toString(), isSuccess: false);
        setGeneralState(ViewState.error);
      },
    );
  }

  List<State> _states = [];
  List<State> get states => _states;

  State? _selectedState;
  State? get selectedState => _selectedState;
  set selectedState(State? val) {
    _selectedState = val;
    notifyListeners();
  }

  /// fetches States
  fetchStates({int? isNigerian}) async {
    setGeneralState(ViewState.busy);

    await _genralDp
        .getStates(countryId: _selectedCountry?.id, isNigerian: isNigerian)
        .then(
          (response) {
            _message = response.message ?? defaultSuccessMessage;
            _states = response.data ?? [];
            setGeneralState(ViewState.retrieved);
          },
          onError: (error) {
            _message = Utilities.formatMessage(
              error.toString(),
              isSuccess: false,
            );
            setGeneralState(ViewState.error);
          },
        );
  }

  List<City> _cities = [];
  List<City> get cities => _cities;

  City? _selectedCity;
  City? get selectedCity => _selectedCity;
  set selectedCity(City? val) {
    _selectedCity = val;
    notifyListeners();
  }

  /// fetches States
  fetchCities({int? isNigerian}) async {
    setGeneralState(ViewState.busy);

    await _genralDp
        .getCitys(stateId: _selectedState?.id, isNigerian: isNigerian)
        .then(
          (response) {
            _message = response.message ?? defaultSuccessMessage;
            _cities = response.data ?? [];
            setGeneralState(ViewState.retrieved);
          },
          onError: (error) {
            _message = Utilities.formatMessage(
              error.toString(),
              isSuccess: false,
            );
            setGeneralState(ViewState.error);
          },
        );
  }

  List<FileUploadResponse> _fileUploadsResponse = [];
  List<FileUploadResponse> get fileUploadsResponse => _fileUploadsResponse;


  uploadImage({required String base64String}) async {
    setGeneralState(ViewState.busy);
    
    // Decode base64 string to bytes
    final bytes = base64Decode(base64String);

    final formData = FormData.fromMap({
      'media[]': MultipartFile.fromBytes(
        bytes,
        filename: 'userimage.jpg', // Adjust filename as needed
        contentType: MediaType('image', 'jpeg'),
      ),
    });

    await _genralDp
        .uploadFile(formData)
        .then(
          (response) {
            _message = defaultSuccessMessage;
            _fileUploadsResponse = response;
            setGeneralState(ViewState.retrieved);
          },
          onError: (error) {
            log(error.toString());
            _message = Utilities.formatMessage(
              error.toString(),
              isSuccess: false,
            );
            setGeneralState(ViewState.error);
          },
        );
  }
}

final generalDataViewModel = ChangeNotifierProvider<GeneralDataViewModel>((
  ref,
) {
  return GeneralDataViewModel();
});
