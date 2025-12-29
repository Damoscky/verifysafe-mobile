import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verifysafe/core/constants/app_constants.dart';
import 'package:verifysafe/core/data/data_providers/users_data_providers/employment_data_provider.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/states/base_state.dart';
import 'package:verifysafe/core/utilities/utilities.dart';
import 'package:verifysafe/locator.dart';


class EmploymentViewModel extends BaseState {
  final EmploymentDataProvider _employmentDp = locator<EmploymentDataProvider>();

  //message
  String _message = '';
  String get message => _message;


  //terminate employment
  terminateEmployment({
    required String reason,
    required String description,
    required String exitType,
    required String? userId
  }) async{
    setState(ViewState.busy);
    final details = {
      'exit_reason': reason,
      'comment': description,
      'exit_type': exitType,
      'work_history_id': userId
    };
    await _employmentDp.terminateEmploymentContract(details: details).then(
          (response) {
        _message = response.message ?? defaultSuccessMessage;
        setState(ViewState.retrieved);
      },
      onError: (error) {
        _message = Utilities.formatMessage(error.toString(), isSuccess: false);
        setState(ViewState.error);
      },
    );
  }

  //request employment contract
  requestEmploymentContract({
    required String? workerId,
  }) async{
    setSecondState(ViewState.busy);
    final details = {
      'worker_id': workerId,
    };
    await _employmentDp.requestEmploymentContract(details: details).then(
          (response) {
        _message = response.message ?? defaultSuccessMessage;
        setSecondState(ViewState.retrieved);
      },
      onError: (error) {
        _message = Utilities.formatMessage(error.toString(), isSuccess: false);
        setSecondState(ViewState.error);
      },
    );
  }

}

final employmentViewModel = ChangeNotifierProvider.autoDispose<EmploymentViewModel>((ref) {
  return EmploymentViewModel();
});
