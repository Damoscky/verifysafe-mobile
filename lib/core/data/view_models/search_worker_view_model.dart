import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verifysafe/core/constants/app_constants.dart';
import 'package:verifysafe/core/data/data_providers/users_data_providers/worker_data_provider.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/models/user.dart';
import 'package:verifysafe/core/data/states/worker_state.dart';
import 'package:verifysafe/core/utilities/utilities.dart';
import 'package:verifysafe/locator.dart';

class SearchWorkerViewModel extends WorkerState {
  final WorkerDataProvider _workerDataProvider = locator<WorkerDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //page number
  int pageNumber = 1;

  //total records
  int totalRecords = 0;

  List<User> _workers = [];
  List<User> get workers => _workers;

  /// workers attached to [UserType.employer] or [UserType.agency]
  searchWorker({bool firstCall = true,String? query}) async {
    if (firstCall) {
      pageNumber = 1;
      setSecondState(ViewState.busy);
    } else {
      setPaginatedState(ViewState.busy);
    }

   await  _workerDataProvider
        .fetchWorkers(pageNumber: pageNumber, limit: 5,query: query)
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

final searchWorkerViewModel = ChangeNotifierProvider<SearchWorkerViewModel>((ref) {
  return SearchWorkerViewModel();
});
