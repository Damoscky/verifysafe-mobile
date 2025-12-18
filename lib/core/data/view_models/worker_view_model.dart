import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verifysafe/core/constants/app_constants.dart';
import 'package:verifysafe/core/data/data_providers/users_data_providers/worker_data_provider.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/models/responses/response_data/stats.dart';
import 'package:verifysafe/core/data/models/responses/response_data/worker_dashboard_response.dart';
import 'package:verifysafe/core/data/models/user.dart';
import 'package:verifysafe/core/data/models/worker/worker.dart';
import 'package:verifysafe/core/data/states/worker_state.dart';
import 'package:verifysafe/core/utilities/utilities.dart';
import 'package:verifysafe/locator.dart';

class WorkerViewModel extends WorkerState {
  final WorkerDataProvider _workerDataProvider = locator<WorkerDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //page number
  int pageNumber = 1;

  //total records
  int totalRecords = 0;

  String _workerMessage = '';
  String get workerMessage => _workerMessage;

  //list of workers
  List<Worker> _workers = [];
  List<Worker> get workers => _workers;

  //selected worker
  Worker? selectedWorker;

  WorkerDashboardResponse? _dashboardData;

  Stats? get dashboardStats => _dashboardData?.stats;
  List<EmploymentData> get recentWorkHistory =>
      List<EmploymentData>.from(_dashboardData?.data?.data ?? []);
  List<EmploymentData> get subWorkHistoryList => recentWorkHistory.sublist(
    0,
    recentWorkHistory.length < 3 ? recentWorkHistory.length : 3,
  );

  /// worker dashboard card and recent work history
  fetchWorkerDashboard() {
    setState(ViewState.busy);

    _workerDataProvider.workHistoriesOverview().then(
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

  List<User> _workers = [];
  List<User> get workers => _workers;
  List<User> get recentWorker =>
      _workers.sublist(0, _workers.length < 3 ? _workers.length : 3);

  /// workers attached to [UserType.employer] or [UserType.agency]
  fetchWorkersDetails({bool firstCall = true}) {
    if (firstCall) {
      pageNumber = 1;
      setSecondState(ViewState.busy);
    } else {
      setPaginatedState(ViewState.busy);
    }

    _workerDataProvider
        .fetchWorkers(pageNumber: pageNumber, limit: 5)
        .then(
          (response) {
            _message = response.message ?? defaultSuccessMessage;
            totalRecords = response.data?.total ?? 0;
            pageNumber++;

            if (firstCall) {
              //populate  list
              _workers = List<User>.from(response.data?.data ?? []);
              setSecondState(ViewState.retrieved);
            } else {
              //add to list
              _workers.addAll(List<User>.from(response.data?.data ?? []));
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
}

final workerViewModel = ChangeNotifierProvider<WorkerViewModel>((ref) {
  return WorkerViewModel();
});
