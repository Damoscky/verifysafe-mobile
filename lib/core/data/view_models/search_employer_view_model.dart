import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verifysafe/core/constants/app_constants.dart';
import 'package:verifysafe/core/data/data_providers/users_data_providers/employer_data_provider.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/models/user.dart';
import 'package:verifysafe/core/data/states/employer_state.dart';
import 'package:verifysafe/core/utilities/utilities.dart';
import 'package:verifysafe/locator.dart';

class SearchEmployerViewModel extends EmployerState {
  final EmployerDataProvider _employerDp = locator<EmployerDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //page number
  int pageNumber = 1;

  //total records
  int totalRecords = 0;

  List<User> _employers = [];
  List<User> get employers => _employers;

  /// employers attached to [UserType.agency]
  searchEmployers({bool firstCall = true, String? query}) {
    if (firstCall) {
      pageNumber = 1;
      setSecondState(ViewState.busy);
    } else {
      setPaginatedState(ViewState.busy);
    }

    _employerDp
        .fetchEmployers(pageNumber: pageNumber, limit: 5, query: query)
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
}

final searchEmployerViewModel = ChangeNotifierProvider<SearchEmployerViewModel>((ref) {
  return SearchEmployerViewModel();
});
