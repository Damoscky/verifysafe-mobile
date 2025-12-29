import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verifysafe/core/constants/app_constants.dart';
import 'package:verifysafe/core/data/data_providers/users_data_providers/worker_data_provider.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/models/responses/response_data/stats.dart';
import 'package:verifysafe/core/data/models/responses/response_data/worker_dashboard_response.dart';
import 'package:verifysafe/core/data/models/user.dart';
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

  //selected worker
  User? selectedWorker;

  List<String> statusType = ['active', 'inactive', 'pending', 'suspended'];
  String? selectedStatus;

  List<String> gender = ['male', 'female'];
  String? selectedGender;

  // List<String> employmentType = [
  //   'full',
  //   'female',
  // ];

  WorkerDashboardResponse? _dashboardData;

  Stats? get dashboardStats => _dashboardData?.stats;
  List<EmploymentData> get recentWorkHistory =>
      List<EmploymentData>.from(_dashboardData?.data?.data ?? []);
  List<EmploymentData> get subWorkHistoryList => recentWorkHistory.sublist(
    0,
    recentWorkHistory.length < 3 ? recentWorkHistory.length : 3,
  );

  /// worker dashboard card and recent work history
  fetchWorkerDashboard() async {
    setState(ViewState.busy);

   await  _workerDataProvider.workHistoriesOverview().then(
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

  String? sortOption;
  String? startDate;
  String? endDate;

  /// workers attached to [UserType.employer] or [UserType.agency]
  fetchWorkersDetails({bool firstCall = true}) async {
    if (firstCall) {
      pageNumber = 1;
      setSecondState(ViewState.busy);
    } else {
      setPaginatedState(ViewState.busy);
    }

    await _workerDataProvider
        .fetchWorkers(
          pageNumber: pageNumber,
          limit: 10,
          sortBy: sortOption,
          gender: selectedGender,
          status: selectedStatus,
          dateFilter: startDate != null && endDate != null
              ? "$startDate|$endDate"
              : null,
        )
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

  /// fetch workers under an employer/agency
  fetchWorkers({required String? keyword}) async {
    setSecondState(ViewState.busy);
    await _workerDataProvider
        .fetchWorkers(keyword: keyword)
        .then(
          (response) {
            _workerMessage = response.message ?? defaultSuccessMessage;
            _workers = List<User>.from(response.data?.data ?? []);
            setSecondState(ViewState.retrieved);
          },
          onError: (error) {
            _workerMessage = Utilities.formatMessage(
              error.toString(),
              isSuccess: false,
            );
            setSecondState(ViewState.error);
          },
        );
  }

  List<EmploymentData> _workerWorkHistories = [];
  List<EmploymentData> get workerWorkHistories => _workerWorkHistories;

  fetchWorkerWorkHistory({required String workerID}) async {
    setThirdState(ViewState.busy);
    await _workerDataProvider
        .workHistoriesOverview(userID: workerID)
        .then(
          (response) {
            _workerMessage = response.message ?? defaultSuccessMessage;
            _workerWorkHistories = List<EmploymentData>.from(
              _dashboardData?.data?.data ?? [],
            );
            setThirdState(ViewState.retrieved);
          },
          onError: (error) {
            _workerMessage = Utilities.formatMessage(
              error.toString(),
              isSuccess: false,
            );
            setThirdState(ViewState.error);
          },
        );
  }

  reset() {
    setSecondState(ViewState.idle, refreshUi: false);
    _workers.clear();
  }
}

final workerViewModel = ChangeNotifierProvider<WorkerViewModel>((ref) {
  return WorkerViewModel();
});
