import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verifysafe/core/constants/app_constants.dart';
import 'package:verifysafe/core/data/data_providers/users_data_providers/employer_data_provider.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/models/responses/response_data/stats.dart';
import 'package:verifysafe/core/data/models/user.dart';
import 'package:verifysafe/core/data/states/employer_state.dart';
import 'package:verifysafe/core/utilities/utilities.dart';
import 'package:verifysafe/locator.dart';

import '../models/user.dart';

class EmployerViewModel extends EmployerState {
  final EmployerDataProvider _employerDp = locator<EmployerDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //page number
  int pageNumber = 1;

  //total records
  int totalRecords = 0;

  String _employersMessage = '';
  String get employersMessage => _employersMessage;

  //list of employers
  List<User> _employers = [];
  List<User> get employers => _employers;

  //selected employer
  User? selectedEmployer;

  Stats? _employerStats;
  Stats? get employerStats => _employerStats;

  /// employer dashboard stat
  fetchEmployerDashboardStats() {
    setState(ViewState.busy);

    _employerDp.fetchDashboardStats().then(
      (response) {
        _message = response.message ?? defaultSuccessMessage;
        _employerStats = response.data;
        setState(ViewState.retrieved);
      },
      onError: (error) {
        _message = Utilities.formatMessage(error.toString(), isSuccess: false);
        setState(ViewState.error);
      },
    );
  }


  List<User> get recentWorker =>
      _employers.sublist(0, _employers.length < 3 ? _employers.length : 3);

  /// employers attached to [UserType.agency]
  fetchEmployersDetails({bool firstCall = true}) {
    if (firstCall) {
      pageNumber = 1;
      setSecondState(ViewState.busy);
    } else {
      setPaginatedState(ViewState.busy);
    }

    _employerDp
        .fetchEmployers(pageNumber: pageNumber, limit: 5)
        .then(
          (response) {
            _message = response.message ?? defaultSuccessMessage;
            totalRecords = response.data?.total ?? 0;
            pageNumber++;

            if (firstCall) {
              //populate  list
              _employers = List<User>.from(response.data?.data ?? []);
              setSecondState(ViewState.retrieved);
            } else {
              //add to list
              _employers.addAll(List<User>.from(response.data?.data ?? []));
              setPaginatedState(ViewState.retrieved);
            }
          },
          onError: (error) {
            _message = Utilities.formatMessage(
              error.toString(),
              isSuccess: false,
            );
            if (firstCall) {
              setSecondState(ViewState.error);
            } else {
              setPaginatedState(ViewState.error);
            }
          },
        );
  }

  /// fetch employers
  fetchEmployers({required String? keyword}) async{
    setSecondState(ViewState.busy);
    await _employerDp.fetchEmployers(keyword: keyword).then(
          (response) {
        _employersMessage = response.message ?? defaultSuccessMessage;
        _employers = List<User>.from(response.data?.data ?? []);
        setSecondState(ViewState.retrieved);
      },
      onError: (error) {
        _employersMessage = Utilities.formatMessage(error.toString(), isSuccess: false);
        setSecondState(ViewState.error);
      },
    );
  }

  reset(){
    setSecondState(ViewState.idle, refreshUi: false);
    _employers.clear();
  }
}

final employerViewModel = ChangeNotifierProvider<EmployerViewModel>((ref) {
  return EmployerViewModel();
});
