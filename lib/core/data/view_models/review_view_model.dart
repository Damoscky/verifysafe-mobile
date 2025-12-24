import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verifysafe/core/constants/app_constants.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/models/responses/response_data/stats.dart';
import 'package:verifysafe/core/data/models/review.dart';
import 'package:verifysafe/core/data/states/base_state.dart';
import 'package:verifysafe/core/utilities/utilities.dart';
import 'package:verifysafe/locator.dart';

import '../../utilities/date_sorter.dart';
import '../../utilities/date_utilitites.dart';
import '../data_providers/review_data_provider.dart';

class ReviewViewModel extends BaseState {
  final ReviewDataProvider _reviewDp = locator<ReviewDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  Stats? _ratingStats;
  Stats? get ratingStats => _ratingStats;

  //list of reviews
  List<Review> _reviews = [];
  List<Review> get reviews => _reviews;

  //list of reviews(sorted)
  List<Review> _sortedReviews = [];
  List<Review> get sortedReviews => _sortedReviews;

  String? selectedSortOption;

  //selected review
  Review? selectedReview;

  //page number
  int pageNumber = 1;

  //total records
  int totalRecords = 0;

  Map<String, dynamic> selectedFilterOptions = {};

  String get name => selectedReview?.name ?? 'N/A';
  bool get isVerified => selectedReview?.status?.toLowerCase() == 'verified';
  double get rating => double.tryParse(selectedReview?.rating?.toString() ??'0') ?? 0;
  String get job => selectedReview?.jobType ?? 'N/A';
  String get feedback => selectedReview?.feedback ?? 'N/A';
  String get date => DateUtilities.abbrevMonthDayYear(selectedReview?.date?.toString() ?? DateTime.now().toString());



  int get total => _ratingStats?.total ?? 0;


  fetchRatings({bool firstCall = true, bool refreshUi = true, bool withFilters = false}) async {
    if(firstCall){
      pageNumber = 1;
      if(refreshUi)setState(ViewState.busy);
    }
    else{
      setPaginatedState(ViewState.busy);
    }



    await _reviewDp.fetchRatings(
      pageNumber: pageNumber,
        filterOptions: Utilities.returnQueryString(
            params: selectedFilterOptions,
            omitKeys: {'start_date', 'end_date'} //filter out this key so its not sent to backend to filter games
        )
    ).then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      totalRecords = response.data?.data?.total ?? 0;
      if(firstCall){
        if(!withFilters){
          _reviews = response.data?.data?.data ?? [];
        }
        _reviews = List.from(response.data?.data?.data ?? []);
        setState(ViewState.retrieved);
      }
      else{
        if(!withFilters){
          _reviews.addAll(response.data?.data?.data ?? []);
        }
        _reviews.addAll(response.data?.data?.data ?? []);
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


  sortReviewList(String? sortOption){
    selectedSortOption = sortOption;

    if(selectedSortOption == null){
      _sortedReviews = _reviews;
      notifyListeners();
      return;
    }

    final sorter = DateSorter<Review>(
      list: _sortedReviews,
      getDate: (guarantor) => guarantor.date,
    );

    switch(selectedSortOption?.toLowerCase()){
      case 'ascending':
        _sortedReviews = sorter.sort(ascending: true);
      case 'descending':
        _sortedReviews = sorter.sort(ascending: false);
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
    _sortedReviews = _reviews;
    notifyListeners();
  }
}

final reviewViewModel = ChangeNotifierProvider.autoDispose<ReviewViewModel>((ref) {
  return ReviewViewModel();
});
