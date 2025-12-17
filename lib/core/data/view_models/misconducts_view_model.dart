import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verifysafe/core/constants/app_constants.dart';
import 'package:verifysafe/core/data/data_providers/misconducts_data_provider/misconducts_data_provider.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/models/misconduct.dart';
import 'package:verifysafe/core/data/models/responses/response_data/stats.dart';
import 'package:verifysafe/core/data/states/base_state.dart';
import 'package:verifysafe/core/utilities/utilities.dart';
import 'package:verifysafe/locator.dart';

import '../../utilities/date_sorter.dart';
import '../../utilities/date_utilitites.dart';

class MisconductsViewModel extends BaseState {
  final MisconductsDataProvider _misconductsDp = locator<MisconductsDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  Stats? _misconductsStats;
  Stats? get misconductsStats => _misconductsStats;

  //list of reports
  List<Misconduct> _misconductReports = [];
  List<Misconduct> get misconductReports => _misconductReports;

  //list of repotts(sorted)
  List<Misconduct> _sortedReports = [];
  List<Misconduct> get sortedReports => _sortedReports;

  String? selectedSortOption;

  //selected report
  Misconduct? selectedReport;

  //page number
  int pageNumber = 1;

  //total records
  int totalRecords = 0;


  Map<String, dynamic> selectedFilterOptions = {};




  String get name => selectedReport?.reporter?.name ?? 'N/A';
  String get date => DateUtilities.abbrevMonthDayYear(selectedReport?.date?.toString() ?? DateTime.now().toString());
  String get reportType => selectedReport?.type ?? 'N/A';
  String get comment => selectedReport?.comment ?? 'N/A';
  String get status => selectedReport?.status ?? '';
  bool get isPending => status.toLowerCase() == 'pending';
  bool get isDeclined => status.toLowerCase() == 'declined';
  bool get isActive => selectedReport?.isActive ?? false;
  List<String> get attachments => selectedReport?.attachments ?? [];
  bool get hasAttachments => attachments.isNotEmpty;


  int get resolved => _misconductsStats?.resolved ?? 0;
  int get pending => _misconductsStats?.pending ?? 0;
  int get suspended => _misconductsStats?.suspended ?? 0;
  int get total => _misconductsStats?.total ?? 0;


  fetchReports({bool firstCall = true, bool refreshUi = true, bool withFilters = false}) async {
    if(firstCall){
      pageNumber = 1;
      if(refreshUi)setState(ViewState.busy);
    }
    else{
      setPaginatedState(ViewState.busy);
    }



    await _misconductsDp.fetchMisconductReports(
        filterOptions: Utilities.returnQueryString(
            params: selectedFilterOptions,
            omitKeys: {'start_date', 'end_date'} //filter out this key so its not sent to backend to filter games
        )
    ).then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      totalRecords = response.data?.data?.total ?? 0;
      if(firstCall){
        if(!withFilters){
          _misconductReports = response.data?.data?.data ?? [];
        }
        _sortedReports = List.from(response.data?.data?.data ?? []);
        setState(ViewState.retrieved);
      }
      else{
        if(!withFilters){
          _misconductReports.addAll(response.data?.data?.data ?? []);
        }
        _sortedReports.addAll(response.data?.data?.data ?? []);
        setPaginatedState(ViewState.retrieved);
      }
      pageNumber++;
    }, onError: (e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      if(firstCall){
        setState(ViewState.error);
      }else{
        setPaginatedState(ViewState.error);
      }
    });
  }





  sortList(String? sortOption){
    selectedSortOption = sortOption;

    if(selectedSortOption == null){
      _sortedReports = _misconductReports;
      notifyListeners();
      return;
    }

    final sorter = DateSorter<Misconduct>(
      list: _sortedReports,
      getDate: (report) => report.date,
    );

    switch(selectedSortOption?.toLowerCase()){
      case 'ascending':
        _sortedReports = sorter.sort(ascending: true);
      case 'descending':
        _sortedReports = sorter.sort(ascending: false);
    }

    notifyListeners();
  }

  setFilterOptions({String? status, String? startDate, String? endDate})async{

    if(status != null){
      selectedFilterOptions['status'] = status.toLowerCase();
    }

    if(startDate != null && endDate != null){
      selectedFilterOptions['start_date'] = startDate;
      selectedFilterOptions['end_date'] = endDate;
      selectedFilterOptions['date_filter'] = "$startDate|$endDate";
    }

  }

  clearFilters(){
    selectedFilterOptions = {};
    _sortedReports = _misconductReports;
    notifyListeners();
  }
}

final misconductsViewModel = ChangeNotifierProvider.autoDispose<MisconductsViewModel>((ref) {
  return MisconductsViewModel();
});
