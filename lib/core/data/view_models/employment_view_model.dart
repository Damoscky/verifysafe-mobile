import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verifysafe/core/constants/app_constants.dart';
import 'package:verifysafe/core/data/data_providers/users_data_providers/employment_data_provider.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/models/responses/response_data/stats.dart';
import 'package:verifysafe/core/data/models/review.dart';
import 'package:verifysafe/core/data/states/base_state.dart';
import 'package:verifysafe/core/utilities/utilities.dart';
import 'package:verifysafe/locator.dart';
import '../../utilities/date_sorter.dart';
import '../../utilities/date_utilitites.dart';
import '../data_providers/review_data_provider.dart';

class EmploymentViewModel extends BaseState {
  final EmploymentDataProvider _employmentDp = locator<EmploymentDataProvider>();

  //message
  String _message = '';
  String get message => _message;


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

}

final employmentViewModel = ChangeNotifierProvider.autoDispose<EmploymentViewModel>((ref) {
  return EmploymentViewModel();
});
