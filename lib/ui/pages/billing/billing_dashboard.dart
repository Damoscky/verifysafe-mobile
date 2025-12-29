import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/core/constants/named_routes.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/view_models/billing_view_model.dart';
import 'package:verifysafe/core/data/view_models/user_view_model.dart';
import 'package:verifysafe/core/utilities/date_utilitites.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/core/utilities/utilities.dart';
import 'package:verifysafe/ui/pages/billing/bill_type.dart';
import 'package:verifysafe/ui/widgets/app_loader.dart';
import 'package:verifysafe/ui/widgets/busy_overlay.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/custom_painter/custom_progress_bar.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';
import 'package:verifysafe/ui/widgets/empty_state.dart';
import 'package:verifysafe/ui/widgets/naira_display.dart';
import 'package:verifysafe/ui/widgets/show_flush_bar.dart';
import 'package:verifysafe/ui/widgets/verifysafe_container.dart';
import 'package:verifysafe/ui/widgets/verifysafe_tag.dart';

class BillingDashboard extends ConsumerStatefulWidget {
  const BillingDashboard({super.key});

  @override
  ConsumerState<BillingDashboard> createState() => _BillingDashboardState();
}

class _BillingDashboardState extends ConsumerState<BillingDashboard> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      fetchBillingHistory();
      _scrollListener();
    });
    super.initState();
  }

  _scrollListener() {
    final vm = ref.watch(billingViewModel);
    final userVm = ref.watch(userViewModel);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //check paginated state
        if (vm.paginatedState != ViewState.error) {
          //check if data is not being currently fetched and also check total records
          if (vm.paginatedState != ViewState.busy &&
              vm.billingHistories.length < vm.totalRecords) {
            //fetch more
            vm.fetchBillingHistory(
              firstCall: false,
              userID: userVm.userData?.id ?? '',
            );
          }
        }
      }
    });
  }

  fetchBillingHistory() async {
    final vm = ref.read(billingViewModel);
    final userVm = ref.read(userViewModel);
    await vm.fetchBillingHistory(userID: userVm.userData?.id ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final vm = ref.watch(billingViewModel);
    final userVm = ref.watch(userViewModel);

    return BusyOverlay(
      show: vm.secondState == ViewState.busy,
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          title: "Billings & Payments",
          showBottom: true,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await fetchBillingHistory();
          },
          child: ListView(
            controller: _scrollController,
            padding: EdgeInsets.only(
              top: AppDimension.paddingTop,
              left: AppDimension.paddingLeft,
              right: AppDimension.paddingRight,
              bottom: AppDimension.paddingBottom,
            ),
            children: [
              Text("Manage your billing and payment details."),
              SizedBox(height: 16.h),
              //Plan Card
              if (userVm.userData?.billing != null)
                VerifySafeContainer(
                  padding: EdgeInsets.all(24.w),
                  borderRadius: BorderRadius.circular(16.r),
                  bgColor: ColorPath.athensGrey6,
                  border: Border.all(color: ColorPath.mysticGrey),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${userVm.userData?.billing?.currentPlan ?? ""} Plan",
                            style: textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          CustomSvg(asset: AppAsset.circularDoc),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "Due Amount",
                        style: textTheme.bodyMedium?.copyWith(
                          color: ColorPath.slateGrey,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      NairaDisplay(
                        amount:
                            double.tryParse(
                              userVm.userData?.billing?.amountPaid
                                      ?.toString() ??
                                  "0",
                            ) ??
                            0,
                        fontSize: 16.sp,
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            Utilities.capitalizeWord(
                              userVm.userData?.billing?.planInterval ?? "",
                            ),
                            style: textTheme.bodyMedium,
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Icon(
                              Icons.circle,
                              color: ColorPath.mirageBlack,
                              size: 6,
                            ),
                          ),
                          Text(
                            "Next Invoice Date: ${DateUtilities.monthDayYear(date: userVm.userData?.billing?.endDate)}",
                            style: textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        "${userVm.userData?.billing?.searchCountRemaining ?? 0} of ${userVm.userData?.billing?.searchesLimit ?? 0} searches used",
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(
                        width: double.infinity,
                        height: 8.h,
                        child: CustomPaint(
                          painter: CustomProgressBar(
                            percentage: userVm
                                .userData
                                ?.billing
                                ?.searchesUsagePercentage,
                            backgroundColor: ColorPath.gullGrey.withValues(
                              alpha: .2,
                            ),
                            strokeWidth: 8.w,
                            activeColor: ColorPath.shamrockGreen,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      if (userVm.userData?.billing?.isCancelled == true)
                        Clickable(
                          onPressed: () {
                            pushNavigation(
                              context: context,
                              widget: BillType(),
                              routeName: NamedRoutes.billType,
                            );
                          },
                          child: VerifySafeContainer(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 10.h,
                            ),
                            bgColor: ColorPath.aquaGreen,
                            border: Border.all(color: ColorPath.aquaGreen2),
                            child: Row(
                              children: [
                                Text(
                                  "Renew Plan",
                                  style: textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Icon(Icons.north_east),
                              ],
                            ),
                          ),
                        ),
                      if (userVm.userData?.billing?.isCancelled == false)
                        Clickable(
                          onPressed: () async {
                            await vm.cancelSubscription();

                            if (vm.secondState == ViewState.retrieved) {
                              popNavigation(context: context);
                              userVm.getUserData();
                              showFlushBar(
                                context: context,
                                message: vm.message,
                              );
                            } else {
                              showFlushBar(
                                context: context,
                                message: vm.message,
                                success: false,
                              );
                            }
                          },
                          child: VerifySafeContainer(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 10.h,
                            ),
                            bgColor: ColorPath.provincialPink,
                            border: Border.all(color: ColorPath.thunderbirdRed),
                            child: Row(
                              children: [
                                Text(
                                  "Cancel Plan",
                                  style: textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Icon(Icons.delete_outline_outlined),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              SizedBox(height: 18.h),
              if (vm.state == ViewState.retrieved &&
                  vm.billingHistories.isEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 32.h),
                  child: EmptyState(
                    asset: AppAsset.empty,
                    useBgCard: false,
                    assetHeight: 200.h,
                    title: "No Subscription History yet",
                    subtitle: "",
                    showCtaButton: true,
                    ctaText: "Subscribe",
                    onPressed: () {
                      pushNavigation(
                        context: context,
                        widget: BillType(),
                        routeName: NamedRoutes.billType,
                      );
                    },
                  ),
                )
              else
                Builder(
                  builder: (context) {
                    if (vm.state == ViewState.busy) {
                      return Padding(
                        padding: EdgeInsets.only(top: 32.h),
                        child: AppLoader(),
                      );
                    }
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final billingData = vm.billingHistories[index];
                        return VerifySafeContainer(
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    billingData.subscriber?.name ?? "N/A",
                                    style: textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  VerifySafeTag(
                                    status: billingData.paymentStatus ?? "",
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              Text(billingData.plan ?? "---"),
                              SizedBox(height: 8.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Billing Date",
                                          style: textTheme.bodySmall?.copyWith(
                                            color: colorScheme.text4,
                                          ),
                                        ),
                                        Text(
                                          DateUtilities.monthDayYear(
                                            date: billingData.endDate,
                                          ),
                                          style: textTheme.bodySmall?.copyWith(
                                            color: colorScheme.blackText,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Payment Date",
                                          style: textTheme.bodySmall?.copyWith(
                                            color: colorScheme.text4,
                                          ),
                                        ),
                                        Text(
                                          DateUtilities.monthDayYear(
                                            date: billingData.subscribedAt,
                                          ),

                                          style: textTheme.bodySmall?.copyWith(
                                            color: colorScheme.blackText,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.h),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Amount Due",
                                    style: textTheme.bodySmall?.copyWith(
                                      color: colorScheme.text4,
                                    ),
                                  ),
                                  NairaDisplay(
                                    amount:
                                        double.tryParse(
                                          billingData.amount?.toString() ?? "0",
                                        ) ??
                                        0,
                                    fontSize: 16.sp,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => SizedBox(height: 16.h),
                      itemCount: vm.billingHistories.length,
                    );
                  },
                ),
              if (vm.paginatedState == ViewState.busy)
                Column(
                  children: [
                    SizedBox(height: 8.h),
                    AppLoader(size: 30.h),
                    SizedBox(height: 8.h),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
