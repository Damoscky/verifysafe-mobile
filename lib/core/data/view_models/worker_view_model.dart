import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verifysafe/core/constants/app_constants.dart';
import 'package:verifysafe/core/data/data_providers/users_data_providers/worker_data_provider.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/models/responses/response_data/stats.dart';
import 'package:verifysafe/core/data/models/responses/response_data/worker_dashboard_response.dart';
import 'package:verifysafe/core/data/models/worker/worker.dart';
import 'package:verifysafe/core/data/states/worker_state.dart';
import 'package:verifysafe/core/utilities/utilities.dart';
import 'package:verifysafe/locator.dart';

class WorkerViewModel extends WorkerState {
  final WorkerDataProvider _workerDataProvider = locator<WorkerDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  String _workerMessage = '';
  String get workerMessage => _workerMessage;

  //list of workers
  List<Worker> _workers = [];
  List<Worker> get workers => _workers;

  //selected worker
  Worker? selectedWorker;

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

  /// fetch employers
  fetchWorkers({required String? keyword}) async{
    setSecondState(ViewState.busy);
    await _workerDataProvider.fetchWorkers(keyword: keyword).then(
          (response) {
        _workerMessage = response.message ?? defaultSuccessMessage;
        _workers = response.data ?? [];
        setSecondState(ViewState.retrieved);
      },
      onError: (error) {
        _workerMessage = Utilities.formatMessage(error.toString(), isSuccess: false);
        setSecondState(ViewState.error);
      },
    );
  }

  reset(){
    setSecondState(ViewState.idle, refreshUi: false);
    _workers.clear();
  }
}

final workerViewModel = ChangeNotifierProvider<WorkerViewModel>((ref) {
  return WorkerViewModel();
});
