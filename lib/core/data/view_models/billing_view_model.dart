import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verifysafe/core/constants/app_constants.dart';
import 'package:verifysafe/core/data/data_providers/billing_data_provider/billing_data_providers.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/models/billing_plan.dart';
import 'package:verifysafe/core/data/models/responses/response_data/billing_dashboard_response.dart';
import 'package:verifysafe/core/data/models/responses/response_data/init_payment_response.dart';
import 'package:verifysafe/core/data/models/responses/response_data/subscription_response.dart';
import 'package:verifysafe/core/data/states/base_state.dart';
import 'package:verifysafe/core/utilities/utilities.dart';
import 'package:verifysafe/locator.dart';

class BillingViewModel extends BaseState {
  final BillingDataProviders _billingDp = locator<BillingDataProviders>();

  //message
  String _message = '';
  String get message => _message;

  List<BillingPlan> _billings = [];
  List<BillingPlan> get billings => _billings;

  BillingPlan? selectedBillPlan;
  bool isMonthly = true;
  GlobalKey globalKey = GlobalKey();

  fetchBillings() async {
    setThirdState(ViewState.busy);

    await _billingDp.fetchBillings().then(
      (response) {
        _message = response.message ?? defaultSuccessMessage;
        _billings = response.data ?? [];
        setThirdState(ViewState.retrieved);
      },
      onError: (error) {
        _message = Utilities.formatMessage(error.toString(), isSuccess: false);
        setThirdState(ViewState.error);
      },
    );
  }

  InitPaymentResponse? _initPaymentResponse;
  InitPaymentResponse? get initPaymentResponse => _initPaymentResponse;

  initializeSubscriptionPayment() async {
    setSecondState(ViewState.busy);
    final details = {
      "price_id": isMonthly
          ? selectedBillPlan?.prices?.first.id
          : selectedBillPlan?.prices?.last.id,
      "callback_url": "https://verify-safe.netlify.app/complete-subscription",
    };

    await _billingDp
        .initBillPayment(details: details)
        .then(
          (response) {
            _message = response.message ?? defaultSuccessMessage;
            _initPaymentResponse = response.data;
            setSecondState(ViewState.retrieved);
          },
          onError: (error) {
            _message = Utilities.formatMessage(
              error.toString(),
              isSuccess: false,
            );
            setSecondState(ViewState.error);
          },
        );
  }

  SubscriptionResponse? _subscriptionData;
  SubscriptionResponse? get subscriptionData => _subscriptionData;

  completeSubscriptionPayment() async {
    setThirdState(ViewState.busy);
    final details = {"reference": _initPaymentResponse?.reference};

    await _billingDp
        .verifyBillPayment(details: details)
        .then(
          (response) {
            _message = response.message ?? defaultSuccessMessage;
            _subscriptionData = response.data;
            setThirdState(ViewState.retrieved);
          },
          onError: (error) {
            _message = Utilities.formatMessage(
              error.toString(),
              isSuccess: false,
            );
            setThirdState(ViewState.error);
          },
        );
  }

  cancelSubscription() async {
    setSecondState(ViewState.busy);

    await _billingDp.cancel().then(
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

  //page number
  int pageNumber = 1;

  //total records
  int totalRecords = 0;

  String? sortOption;
  String? startDate;
  String? endDate;

  BillingDashboardResponse? _dashboardResponse;

  List<SubscriptionResponse> _billingHistories = [];
  List<SubscriptionResponse> get billingHistories => _billingHistories;

  fetchBillingHistory({required String userID, bool firstCall = true}) async {
    if (firstCall) {
      pageNumber = 1;
      setState(ViewState.busy);
    } else {
      setPaginatedState(ViewState.busy);
    }
    await _billingDp
        .fetchBillingHistory(
          userID: userID,
          limit: 10,
          sortBy: sortOption,
          dateFilter: startDate != null && endDate != null
              ? "$startDate|$endDate"
              : null,
        )
        .then(
          (response) {
            _message = response.message ?? defaultSuccessMessage;
            totalRecords = response.data?.data?.total ?? 0;
            pageNumber++;
            _dashboardResponse = response.data;

            if (firstCall) {
              //populate  list
              _billingHistories = List<SubscriptionResponse>.from(
                _dashboardResponse?.data?.data ?? [],
              );
              setState(ViewState.retrieved);
            } else {
              //add to list
              _billingHistories.addAll(
                List<SubscriptionResponse>.from(
                  _dashboardResponse?.data?.data ?? [],
                ),
              );
              setPaginatedState(ViewState.retrieved);
            }
          },
          onError: (error) {
            _message = Utilities.formatMessage(
              error.toString(),
              isSuccess: false,
            );
            if (firstCall) {
              setState(ViewState.error);
            } else {
              setPaginatedState(ViewState.error);
            }
          },
        );
  }

  reset() {
    selectedBillPlan = null;
    isMonthly = true;
    notifyListeners();
  }
}

final billingViewModel = ChangeNotifierProvider<BillingViewModel>((ref) {
  return BillingViewModel();
});
