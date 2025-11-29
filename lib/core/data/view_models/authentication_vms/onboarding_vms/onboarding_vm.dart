import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/app_constants.dart';
import 'package:verifysafe/core/constants/named_routes.dart';
import 'package:verifysafe/core/constants/onboarding_steps.dart';
import 'package:verifysafe/core/data/data_providers/onboarding_data_provider/onboarding_data_provider.dart';
import 'package:verifysafe/core/data/enum/user_type.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/models/responses/response_data/authorization_response.dart';
import 'package:verifysafe/core/data/models/responses/response_data/basic_info_respnse_data.dart';
import 'package:verifysafe/core/data/states/base_state.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/core/utilities/secure_storage/secure_storage_utils.dart';
import 'package:verifysafe/core/utilities/utilities.dart';
import 'package:verifysafe/locator.dart';
import 'package:verifysafe/ui/pages/authentication/onboarding/agency/agency_info.dart';
import 'package:verifysafe/ui/pages/authentication/onboarding/employer/contact_person.dart';
import 'package:verifysafe/ui/pages/authentication/onboarding/employer/employer_info.dart';
import 'package:verifysafe/ui/pages/authentication/onboarding/employer/services_and_specializations.dart';
import 'package:verifysafe/ui/pages/authentication/onboarding/guarantor_details.dart';
import 'package:verifysafe/ui/pages/authentication/onboarding/identity_verification.dart';
import 'package:verifysafe/ui/pages/authentication/onboarding/worker/basic_info.dart';
import 'package:verifysafe/ui/pages/authentication/onboarding/worker/employment_details.dart';

class OnboardingVm extends BaseState {
  final OnboardingDataProvider _onboardingDp =
      locator<OnboardingDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  AuthorizationResponse? _authorizationResponse;
  AuthorizationResponse? get authorizationResponse => _authorizationResponse;

  List<String> assets = [AppAsset.worker, AppAsset.agency, AppAsset.employer];

  List<String> titles = ['Worker', 'Agency/Agent', 'Employer/Organisation'];

  List<String> subtitles = [
    'I am a working professional',
    'I recruit workers for businesses',
    'I want to employ worker for my business',
  ];

  UserType? _currentUserType;
  UserType? get currentUserType => _currentUserType;

  int? _userType;
  int? get userType => _userType;
  set userType(int? val) {
    _userType = val;
    switch (val) {
      case 0:
        _currentUserType = UserType.worker;
        break;
      case 1:
        _currentUserType = UserType.agency;
        break;
      default:
        _currentUserType = UserType.employer;
    }
    notifyListeners();
  }

  String getUserType() {
    switch (_currentUserType) {
      case UserType.worker:
        return "worker";
      case UserType.employer:
        return "employer";
      case UserType.agency:
        return "agency";
      default:
        return "worker";
    }
  }

  BasicInfoRespnseData? _userBasicInfoResponseData;
  BasicInfoRespnseData? get userBasicInfoResponseData =>
      _userBasicInfoResponseData;

  /// Creates [UserType] Basic information
  createUserBasicInfo({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String gender,
    required String maritalStatus,
  }) async {
    setState(ViewState.busy);
    final details = {
      "name": "$firstName $lastName",
      "email": email,
      "phone": phone,
      "gender": gender,
      "marital_status": maritalStatus,
      "roles": [getUserType()],
    };

    await _onboardingDp
        .createProfile(details: details)
        .then(
          (response) {
            _message = response.message ?? defaultSuccessMessage;
            _userBasicInfoResponseData = response.data;
            setState(ViewState.retrieved);
          },
          onError: (error) {
            _message = Utilities.formatMessage(
              error.toString(),
              isSuccess: false,
            );
            setState(ViewState.error);
          },
        );
  }

  /// Sets up [UserType] account Password
  setupPassword({
    required String password,
    required String confirmPassword,
    required String onboardingId,
  }) async {
    setState(ViewState.busy);
    final details = {
      "password": password,
      "password_confirmation": confirmPassword,
      "onboarding_id": onboardingId,
    };

    log(details.toString());

    await _onboardingDp
        .setupPassword(details: details)
        .then(
          (response) async {
            _message = response.message ?? defaultSuccessMessage;
            _authorizationResponse = response.data;
            await SecureStorageUtils.saveToken(
              token: _authorizationResponse?.accessToken ?? '',
            );
            setState(ViewState.retrieved);
          },
          onError: (error) {
            _message = Utilities.formatMessage(
              error.toString(),
              isSuccess: false,
            );
            setState(ViewState.error);
          },
        );
  }

  /// Creates [UserType.agency] agency info
  createAgencyInfo({
    required String agencyName,
    required String businessType,
    required String email,
    required String phone,
    required String address,
    int? countryId,
    int? stateId,
    int? cityId,
    String? phone2,
    String? website,
  }) async {
    setState(ViewState.busy);
    final details = {
      "agency_name": agencyName,
      "business_type": businessType,
      "email": email,
      "phone": phone,
      "phone2": phone2,
      "address": address,
      "website": website,
      "country_id": countryId?.toString(),
      "state_id": stateId?.toString(),
      "city_id": cityId?.toString(),
    };

    log(details.toString());

    await _onboardingDp
        .createAgencyInfo(details: details)
        .then(
          (response) async {
            _message = response.message ?? defaultSuccessMessage;
            _authorizationResponse = response.data;
            await SecureStorageUtils.saveToken(
              token: _authorizationResponse?.accessToken ?? '',
            );
            setState(ViewState.retrieved);
          },
          onError: (error) {
            _message = Utilities.formatMessage(
              error.toString(),
              isSuccess: false,
            );
            setState(ViewState.error);
          },
        );
  }

  /// Creates [UserType.employer] employer info
  createEmployerInfo({
    required String employerName,
    required String employerType,
    required String businessType,
    required String email,
    required String phone,
    required String address,
    int? countryId,
    int? stateId,
    int? cityId,
    String? phone2,
    String? website,
  }) async {
    setState(ViewState.busy);
    final details = {
      "agency_name": employerName,
      "business_type": businessType,
      "employer_type": employerType,
      "email": email,
      "phone": phone,
      "phone2": phone2,
      "address": address,
      "website": website,
      "country_id": countryId?.toString(),
      "state_id": stateId?.toString(),
      "city_id": cityId?.toString(),
    };

    log(details.toString());

    await _onboardingDp
        .createEmployerInfo(details: details)
        .then(
          (response) async {
            _message = response.message ?? defaultSuccessMessage;
            _authorizationResponse = response.data;
            await SecureStorageUtils.saveToken(
              token: _authorizationResponse?.accessToken ?? '',
            );
            setState(ViewState.retrieved);
          },
          onError: (error) {
            _message = Utilities.formatMessage(
              error.toString(),
              isSuccess: false,
            );
            setState(ViewState.error);
          },
        );
  }

  handleOnboardingNavigation({
    required BuildContext context,
    required UserType userType,
    required String currentStep,
  }) {
    switch (userType) {
      //WORKER
      case UserType.worker:
        if (currentStep == OnboardingSteps.personalInformation) {
          return replaceNavigation(
            context: context,
            widget: BasicInfo(),
            routeName: NamedRoutes.basicInfo,
          );
        }
        if (currentStep == OnboardingSteps.identitiVerification) {
          return replaceNavigation(
            context: context,
            widget: IdentityVerification(userType: userType),
            routeName: NamedRoutes.identityVerification,
          );
        }
        if (currentStep == OnboardingSteps.workHistory) {
          //todo::: confirm difference between work history and employment details
          return replaceNavigation(
            context: context,
            widget: EmploymentDetails(),
            routeName: NamedRoutes.employmentDetails,
          );
        }
        if (currentStep == OnboardingSteps.contactPerson) {
          return replaceNavigation(
            context: context,
            widget: GuarantorDetails(),
            routeName: NamedRoutes.guarantorDetails,
          );
        }
        break;
      //AGENCY
      case UserType.agency:
        if (currentStep == OnboardingSteps.personalInformation) {
          return replaceNavigation(
            context: context,
            widget: BasicInfo(),
            routeName: NamedRoutes.basicInfo,
          );
        }
        if (currentStep == OnboardingSteps.agencyInformation) {
          return replaceNavigation(
            context: context,
            widget: AgencyInfo(),
            routeName: NamedRoutes.agencyInfo,
          );
        }
        if (currentStep == OnboardingSteps.identitiVerification) {
          return replaceNavigation(
            context: context,
            widget: IdentityVerification(userType: userType),
            routeName: NamedRoutes.identityVerification,
          );
        }
        if (currentStep == OnboardingSteps.contactPerson) {
          return replaceNavigation(
            context: context,
            widget: GuarantorDetails(),
            routeName: NamedRoutes.guarantorDetails,
          );
        }
        break;
      //EMPLOYER
      case UserType.employer:
        if (currentStep == OnboardingSteps.personalInformation) {
          return replaceNavigation(
            context: context,
            widget: BasicInfo(),
            routeName: NamedRoutes.basicInfo,
          );
        }
        if (currentStep == OnboardingSteps.employerInformation) {
          return replaceNavigation(
            context: context,
            widget: EmployerInfo(),
            routeName: NamedRoutes.employerInfo,
          );
        }
        if (currentStep == OnboardingSteps.identitiVerification) {
          return replaceNavigation(
            context: context,
            widget: IdentityVerification(userType: userType),
            routeName: NamedRoutes.identityVerification,
          );
        }
        if (currentStep == OnboardingSteps.contactPerson) {
          //todo:::
          return replaceNavigation(
            context: context,
            widget: ContactPerson(),
            routeName: NamedRoutes.contactPerson,
          );
        }
        if (currentStep == OnboardingSteps.serviceSpecialization) {
          return replaceNavigation(
            context: context,
            widget: ServicesAndSpecializations(),
            routeName: NamedRoutes.servicesAndSpecializations,
          );
        }
        if (currentStep == OnboardingSteps.contactPerson) {
          //todo:::
          return replaceNavigation(
            context: context,
            widget: GuarantorDetails(),
            routeName: NamedRoutes.guarantorDetails,
          );
        }
        break;
    }
  }

  int workerSteps = 5;
  int agencySteps = 4;
  int employerSteps = 6;

  int totalSteps() {
    switch (_userType) {
      case 0:
        return workerSteps;
      case 1:
        return agencySteps;
      case 2:
      default:
        return employerSteps;
    }
  }

  int currentStep({required String name}) {
    switch (name.toLowerCase()) {
      case 'basic info':
      case 'agency info':
      case 'business info':
        return 1;
      case 'identity verification':
        return 2;
      case 'employment details':
      case 'contact person':
        return 3;
      case 'services':
        return 4;
      case 'guarantor info':
        if (_userType == 0) {
          return 4;
        } else {
          return 5;
        }
      case 'create password':
        if (_userType == 1) return 4;
        if (_userType == 2) return 6;
        return 5;
      default:
        return 0;
    }
  }
}

final onboardingViewModel = ChangeNotifierProvider.autoDispose<OnboardingVm>((
  ref,
) {
  return OnboardingVm();
});
