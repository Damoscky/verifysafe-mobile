import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verifysafe/core/constants/app_constants.dart';
import 'package:verifysafe/core/data/data_providers/users_data_providers/agency_data_provider.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/models/responses/response_data/stats.dart';
import 'package:verifysafe/core/data/states/agency_state.dart';
import 'package:verifysafe/core/utilities/utilities.dart';
import 'package:verifysafe/locator.dart';

class AgencyViewModel extends AgencyState {
  final AgencyDataProvider _agencyDp = locator<AgencyDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  AgencyStats? _agencyStats;
  AgencyStats? get agencyStats => _agencyStats;

  String get totalRegistration => ((_agencyStats?.employers?.totalCount ?? 0) + (_agencyStats?.workers?.totalCount ?? 0)).toString();
  String get registeredEmployers => _agencyStats?.employers?.totalCount?.toString() ?? "0";
  String get registeredWorkers => _agencyStats?.workers?.totalCount?.toString() ?? "0";



  /// agency dashboard stat
  fetchAgencyDashboardStats() {
    setState(ViewState.busy);

    _agencyDp.fetchDashboardStats().then(
      (response) {
        _message = response.message ?? defaultSuccessMessage;
        _agencyStats = response.data;
        setState(ViewState.retrieved);
      },
      onError: (error) {
        _message = Utilities.formatMessage(error.toString(), isSuccess: false);
        setState(ViewState.error);
      },
    );
  }
}

final agencyViewModel = ChangeNotifierProvider<AgencyViewModel>((ref) {
  return AgencyViewModel();
});
