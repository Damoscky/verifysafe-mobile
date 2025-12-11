import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verifysafe/core/constants/app_constants.dart';
import 'package:verifysafe/core/data/data_providers/guarantor_data_provider/guarantor_data_provider.dart';
import 'package:verifysafe/core/data/data_providers/users_data_providers/employer_data_provider.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/models/guarantor.dart';
import 'package:verifysafe/core/data/models/responses/response_data/stats.dart';
import 'package:verifysafe/core/data/states/base_state.dart';
import 'package:verifysafe/core/data/states/employer_state.dart';
import 'package:verifysafe/core/utilities/utilities.dart';
import 'package:verifysafe/locator.dart';

import '../../utilities/date_utilitites.dart';

class GuarantorViewModel extends BaseState {
  final GuarantorDataProvider _guarantorDp = locator<GuarantorDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  Stats? _guarantorStats;
  Stats? get guarantorStats => _guarantorStats;

  //list of guarantors
  List<Guarantor> _guarantors = [];
  List<Guarantor> get guarantors => _guarantors;

  //selected guarantor
  Guarantor? selectedGuarantor;

  String get name => selectedGuarantor?.name ?? 'N/A';
  String get date => DateUtilities.abbrevMonthDayYear(selectedGuarantor?.requestedAt?.toString() ?? DateTime.now().toString());
  String get time => DateUtilities.formatTimeAMPM(dateTime: selectedGuarantor?.requestedAt ?? DateTime.now());
  String? get approvedDate => selectedGuarantor?.approvedAt == null ? null : DateUtilities.abbrevMonthDayYear(selectedGuarantor?.approvedAt?.toString() ?? DateTime.now().toString());
  String get relationship => selectedGuarantor?.relationship ?? 'N/A';
  String get email => selectedGuarantor?.email ?? 'N/A';
  String get address => selectedGuarantor?.address ?? 'N/A';
  String get status => selectedGuarantor?.status ?? '';
  String get phone => selectedGuarantor?.phone ?? 'N/A';
  String get country => selectedGuarantor?.country ?? 'N/A';
  String get stateOfResidence => selectedGuarantor?.state ?? 'N/A';
  String get lga => selectedGuarantor?.city ?? 'N/A';


  int get accepted => _guarantorStats?.approved ?? 0;
  int get pending => _guarantorStats?.pending ?? 0;
  int get rejected => _guarantorStats?.declined ?? 0;
  int get total => _guarantorStats?.total ?? 0;


  fetchGuarantors() async{
    setState(ViewState.busy);
    await _guarantorDp.fetchGuarantors().then(
          (response) {
        _message = response.message ?? defaultSuccessMessage;
        _guarantorStats = response.data?.stats;
        _guarantors = response.data?.data ?? [];
        setState(ViewState.retrieved);
      },
      onError: (error) {
        _message = Utilities.formatMessage(error.toString(), isSuccess: false);
        setState(ViewState.error);
      },
    );
  }

  addGuarantor({
    required String name,
    required String? relationship,
    required String email,
    required String phone,
    required int? stateId,
    required int? cityId,
    required String address
  }) async{
    setSecondState(ViewState.busy);
    final details = {
      'name':name,
      'email':email,
      'phone':Utilities.cleanPhoneNumber(phoneNumber: phone),
      'relationship': relationship,
      'state_id':stateId,
      'city_id':cityId,
      'address': address,
      'type': 'guarantor',
    };
    await _guarantorDp.addGuarantor(details: details).then(
          (response) {
        _message = response.message ?? defaultSuccessMessage;
        _guarantors.add(response.data ?? Guarantor());
        setSecondState(ViewState.retrieved);
      },
      onError: (error) {
        _message = Utilities.formatMessage(error.toString(), isSuccess: false);
        setSecondState(ViewState.error);
      },
    );
  }
}

final guarantorViewModel = ChangeNotifierProvider<GuarantorViewModel>((ref) {
  return GuarantorViewModel();
});
