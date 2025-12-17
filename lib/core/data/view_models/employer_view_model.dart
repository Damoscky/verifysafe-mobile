import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verifysafe/core/constants/app_constants.dart';
import 'package:verifysafe/core/data/data_providers/users_data_providers/employer_data_provider.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/models/employer/employer.dart';
import 'package:verifysafe/core/data/models/responses/response_data/stats.dart';
import 'package:verifysafe/core/data/states/employer_state.dart';
import 'package:verifysafe/core/utilities/utilities.dart';
import 'package:verifysafe/locator.dart';

class EmployerViewModel extends EmployerState {
  final EmployerDataProvider _employerDp = locator<EmployerDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  String _employersMessage = '';
  String get employersMessage => _employersMessage;

  //list of employers
  List<Employer> _employers = [];
  List<Employer> get employers => _employers;

  //selected employer
  Employer? selectedEmployer;

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

  /// fetch employers
  fetchEmployers({required String? keyword}) async{
    setSecondState(ViewState.busy);
    await _employerDp.fetchEmployers(keyword: keyword).then(
          (response) {
        _employersMessage = response.message ?? defaultSuccessMessage;
        _employers = response.data ?? [];
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
