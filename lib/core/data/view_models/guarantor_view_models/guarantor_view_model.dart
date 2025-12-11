import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verifysafe/core/constants/app_constants.dart';
import 'package:verifysafe/core/data/data_providers/guarantor_data_provider/guarantor_data_provider.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/models/guarantor.dart';
import 'package:verifysafe/core/data/models/responses/response_data/stats.dart';
import 'package:verifysafe/core/data/states/base_state.dart';
import 'package:verifysafe/core/utilities/utilities.dart';
import 'package:verifysafe/locator.dart';

import '../../../utilities/date_sorter.dart';
import '../../../utilities/date_utilitites.dart';

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

  //list of guarantors(sorted)
  List<Guarantor> _sortedGuarantors = [];
  List<Guarantor> get sortedGuarantors => _sortedGuarantors;

  String? selectedSortOption;

  //selected guarantor
  Guarantor? selectedGuarantor;

  List<String> statusType = [
    'Pending',
    'Approved',
    'Declined'
  ];

  Map<String, dynamic> selectedFilterOptions = {};

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
  bool get isPending => status.toLowerCase() == 'pending';
  bool get isDeclined => status.toLowerCase() == 'declined';
  bool get isActive => selectedGuarantor?.isActive ?? false;


  int get accepted => _guarantorStats?.approved ?? 0;
  int get pending => _guarantorStats?.pending ?? 0;
  int get rejected => _guarantorStats?.declined ?? 0;
  int get total => _guarantorStats?.total ?? 0;


  fetchGuarantors({bool withFilters = false}) async{
    setState(ViewState.busy);
    await _guarantorDp.fetchGuarantors(
      filterOptions: Utilities.returnQueryString(
          params: selectedFilterOptions,
          omitKeys: {'start_date', 'end_date'} //filter out this key so its not sent to backend to filter games
      )
    ).then(
          (response) {
        _message = response.message ?? defaultSuccessMessage;
        _guarantorStats = response.data?.stats;
        if(!withFilters){
          _guarantors = response.data?.data ?? [];
        }
        _sortedGuarantors = List.from(response.data?.data ?? []);
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
      'state_id':stateId.toString(),
      'city_id':cityId.toString(),
      'address': address,
      'type': 'guarantor',
    };
    await _guarantorDp.addGuarantor(details: details).then(
          (response) {
        _message = response.message ?? defaultSuccessMessage;
        fetchGuarantors();
        setSecondState(ViewState.retrieved);
      },
      onError: (error) {
        _message = Utilities.formatMessage(error.toString(), isSuccess: false);
        setSecondState(ViewState.error);
      },
    );
  }

  deactivateGuarantor() async{
    setThirdState(ViewState.busy);
    await _guarantorDp.deactivateGuarantor(id: selectedGuarantor?.id).then(
          (response) {
        _message = response.message ?? defaultSuccessMessage;
        final pos = _guarantors.indexWhere((guarantor)=>guarantor.id == selectedGuarantor?.id);
        if(pos>=0){
          _sortedGuarantors[pos] = response.data ?? Guarantor();
          selectedGuarantor = response.data ?? Guarantor();
        }
        setThirdState(ViewState.retrieved);
      },
      onError: (error) {
        _message = Utilities.formatMessage(error.toString(), isSuccess: false);
        setThirdState(ViewState.error);
      },
    );
  }

  sortGuarantorList(String? sortOption){
    selectedSortOption = sortOption;

    if(selectedSortOption == null){
      _sortedGuarantors = _guarantors;
      notifyListeners();
      return;
    }

    final sorter = DateSorter<Guarantor>(
      list: _sortedGuarantors,
      getDate: (guarantor) => guarantor.requestedAt,
    );

    switch(selectedSortOption?.toLowerCase()){
      case 'ascending':
        _sortedGuarantors = sorter.sort(ascending: true);
      case 'descending':
        _sortedGuarantors = sorter.sort(ascending: false);
    }

    notifyListeners();
  }

  setFilterOptions({String? status, String? startDate, String? endDate})async{

    print('status:::$status>>>');

    if(status != null){
      print('here>>>');
      selectedFilterOptions['status'] = status.toLowerCase();
      print('here>>>${selectedFilterOptions['status']}.......status:::$status');
    }

    if(startDate != null && endDate != null){
      selectedFilterOptions['start_date'] = startDate;
      selectedFilterOptions['end_date'] = endDate;
      selectedFilterOptions['date_filter'] = "$startDate|$endDate";
    }

    print('filter options:::${selectedFilterOptions.toString()}>>>>');
  }

  clearFilters(){
    selectedFilterOptions = {};
    _sortedGuarantors = _guarantors;
    notifyListeners();
  }
}

final guarantorViewModel = ChangeNotifierProvider.autoDispose<GuarantorViewModel>((ref) {
  return GuarantorViewModel();
});
