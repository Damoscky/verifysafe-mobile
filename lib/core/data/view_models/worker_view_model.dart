import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verifysafe/core/constants/app_constants.dart';
import 'package:verifysafe/core/data/data_providers/users_data_providers/worker_data_provider.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/models/responses/response_data/stats.dart';
import 'package:verifysafe/core/data/models/responses/response_data/worker_dashboard_response.dart';
import 'package:verifysafe/core/data/states/worker_state.dart';
import 'package:verifysafe/core/utilities/utilities.dart';
import 'package:verifysafe/locator.dart';

class WorkerViewModel extends WorkerState {
  final WorkerDataProvider _workerDataProvider = locator<WorkerDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  WorkerDashboardResponse? _dashboardData;

  Stats? get dashboardStats => _dashboardData?.stats;
  List<EmploymentData> get recentWorkHistory => _dashboardData?.data ?? [];

  /// worker dashboard card and recent work history
  fetchWorkerDashboard() {
    setState(ViewState.busy);

    _workerDataProvider.fetchDashboardData().then(
      (response) {
        _message = response.message ?? defaultSuccessMessage;
        _dashboardData = response.data;
        setState(ViewState.retrieved);
      },
      onError: (error) {
        _message = Utilities.formatMessage(error.toString(), isSuccess: false);
        setState(ViewState.error);
      },
    );
  }
}

final workerViewModel = ChangeNotifierProvider<WorkerViewModel>((ref) {
  return WorkerViewModel();
});
