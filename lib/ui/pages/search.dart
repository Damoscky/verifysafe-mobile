import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/named_routes.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/models/user.dart';
import 'package:verifysafe/core/data/view_models/worker_view_model.dart';
import 'package:verifysafe/core/utilities/date_utilitites.dart';
import 'package:verifysafe/core/utilities/extensions/color_extensions.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/core/utilities/utilities.dart';
import 'package:verifysafe/ui/pages/billing/bill_type.dart';
import 'package:verifysafe/ui/pages/workers/view_worker.dart';
import 'package:verifysafe/ui/widgets/app_loader.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';
import 'package:verifysafe/ui/widgets/empty_state.dart';
import 'package:verifysafe/ui/widgets/show_flush_bar.dart';
import 'package:verifysafe/ui/widgets/verifysafe_container.dart';

import '../../core/constants/app_asset.dart';
import '../../core/constants/color_path.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_button.dart';

class Search extends ConsumerStatefulWidget {
  const Search({super.key});

  @override
  ConsumerState<Search> createState() => _SearchState();
}

class _SearchState extends ConsumerState<Search> {
  final _searchFocusNode = FocusNode();
  final TextEditingController _search = TextEditingController();

  @override
  void initState() {
    _searchFocusNode.requestFocus();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      fetchSearchHistory();
    });
    super.initState();
  }

  fetchSearchHistory() async {
    final vm = ref.read(workerViewModel);
    await vm.fetchSearchHistory();
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(workerViewModel);
    return Scaffold(
      appBar: customAppBar(context: context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimension.paddingLeft),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    controller: _search,
                    focusNode: _searchFocusNode,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.textPrimary,
                    ),
                    onChanged: (value) => setState(() {}),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      errorText: null,
                      errorMaxLines: 1,
                      errorStyle: const TextStyle(height: 0, fontSize: 0),
                      hintText: 'Search Worker',
                      hintStyle: Theme.of(context).textTheme.bodyLarge
                          ?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.textFieldHint,
                          ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 14.w),
                        child: CustomAssetViewer(
                          asset: AppAsset.search,
                          height: 16.h,
                          width: 16.w,
                        ),
                      ),
                      suffixIcon: _search.text.isEmpty
                          ? null
                          : Padding(
                              padding: EdgeInsets.only(right: 14.w),
                              child: Clickable(
                                onPressed: () {
                                  setState(() {
                                    _search.clear();
                                  });
                                },
                                child: CustomAssetViewer(
                                  asset: AppAsset.close,
                                  height: 16.h,
                                  width: 16.w,
                                ),
                              ),
                            ),
                      prefixIconConstraints: BoxConstraints(
                        minWidth: 16.w,
                        minHeight: 16.h,
                      ),
                      suffixIconConstraints: BoxConstraints(
                        minWidth: 16.w,
                        minHeight: 16.h,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      contentPadding: EdgeInsets.only(
                        left: 14.w,
                        right: 14.w,
                        top: 10.h,
                        bottom: 10.h,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.textPrimary,
                          width: 1.w,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.textPrimary,
                          width: 1.w,
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.textPrimary,
                          width: 0.5.w,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.textPrimary,
                          width: 1.w,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  flex: 1,
                  child: CustomButton(
                    onPressed: () async {
                      if (_search.text.isNotEmpty) {
                        await vm.searchPlatformWorker(query: _search.text);

                        showFlushBar(
                          context: context,
                          message: vm.message,
                          success: vm.searchState == ViewState.retrieved,
                        );
                      } else {
                        showFlushBar(
                          context: context,
                          message: "Provide Worker Name to search for",
                          success: false,
                        );
                      }
                    },
                    buttonText: "Search",
                  ),
                ),
              ],
            ),
            SizedBox(height: 29.h),
            if (_search.text.isEmpty && vm.history.isNotEmpty) recentSearch(),
            if (_search.text.isNotEmpty) searchResults(),
          ],
        ),
      ),
    );
  }

  recentSearch() {
    final vm = ref.watch(workerViewModel);

    if (vm.historyState == ViewState.busy) {
      return LinearProgressIndicator(
        minHeight: 30,
        borderRadius: BorderRadius.circular(12.r),
        color: ColorPath.chateauGrey.withCustomOpacity(.5),
        backgroundColor: ColorPath.athensGrey,
      );
    }
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Your recent searches',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.textPrimary,
                ),
              ),
              SizedBox(width: 8.w),
              CustomAssetViewer(
                asset: AppAsset.clock,
                height: 16.h,
                width: 16.w,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: ListView.separated(
              itemCount: vm.history.length,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                final searchData = vm.history[index];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Clickable(
                        onPressed: () {
                          pushNavigation(
                            context: context,
                            widget: ViewWorker(
                              workerData: searchData.workerData ?? User(),
                            ),
                            routeName: NamedRoutes.viewWorker,
                          );
                        },
                        child: Text(
                          searchData.workerData?.name ?? '',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(
                                  context,
                                ).colorScheme.textPrimary,
                              ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Clickable(
                      onPressed: () {
                        vm.history.remove(searchData);
                        setState(() {});
                      },
                      child: CustomAssetViewer(
                        asset: AppAsset.close,
                        height: 16.h,
                        width: 16.w,
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 16.h);
              },
            ),
          ),
        ],
      ),
    );
  }

  searchResults() {
    final vm = ref.watch(workerViewModel);

    if (vm.searchState == ViewState.busy) {
      return Padding(
        padding: EdgeInsets.only(top: 32.h),
        child: AppLoader(),
      );
    }

    if (vm.searchState == ViewState.retrieved && vm.searchResults.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(top: 40.h),
        child: EmptyState(
          asset: AppAsset.searchEmptyState,
          assetHeight: 106.49.h,
          assetWidth: 123.34.w,
          useBgCard: false,
          title: 'No results found',
          subtitle: 'Search a different keyword.',
          showCtaButton: false,
        ),
      );
    }

    if (vm.searchState == ViewState.error &&
        vm.message.toLowerCase().contains("subscribe")) {
      return VerifySafeContainer(
        bgColor: ColorPath.athensGrey5,
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        border: Border.all(color: ColorPath.susBlue, width: 1.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _search.text,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10.w),
                CustomAssetViewer(
                  asset: AppAsset.searchLocked,
                  height: 45.h,
                  width: 45.w,
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'You are unable to view profile, subscribe to continue',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.text5,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10.w),
                CustomButton(
                  buttonWidth: null,
                  useBorderColor: true,
                  borderRadius: 16.r,
                  borderColor: ColorPath.shamrockGreen,
                  buttonHorizontalPadding: 16.w,
                  buttonTextColor: Theme.of(context).colorScheme.textPrimary,
                  buttonText: 'Subscribe',
                  onPressed: () {
                    pushNavigation(
                      context: context,
                      widget: BillType(),
                      routeName: NamedRoutes.billType,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Expanded(
      child: ListView.separated(
        itemCount: vm.searchResults.length,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          final workerData = vm.searchResults[index];
          return VerifySafeContainer(
            bgColor: ColorPath.athensGrey5,
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            border: Border.all(color: ColorPath.mysticGrey, width: 1.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            workerData.name ?? 'N/A',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.textPrimary,
                                ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'ID: ${workerData.workerId ?? "---"}',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).colorScheme.text5,
                                ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                    CustomAssetViewer(
                      asset: AppAsset.searchFound,
                      height: 45.h,
                      width: 45.w,
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Utilities.capitalizeWord(
                              workerData.gender ?? "Gender: N/A",
                            ),
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.textPrimary,
                                ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'DOB: ${workerData.workerInfo?.dateOfBirth != null ? DateUtilities.monthDayYear(date: DateTime.tryParse(workerData.workerInfo?.dateOfBirth ?? "")) : "N/A"}',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).colorScheme.text5,
                                ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                    CustomButton(
                      buttonWidth: null,
                      useBorderColor: true,
                      borderRadius: 16.r,
                      borderColor: ColorPath.shamrockGreen,
                      buttonHorizontalPadding: 16.w,
                      buttonTextColor: Theme.of(
                        context,
                      ).colorScheme.textPrimary,
                      buttonText: 'View Profile',
                      onPressed: () {
                        pushNavigation(
                          context: context,
                          widget: ViewWorker(workerData: workerData),
                          routeName: NamedRoutes.viewWorker,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 16.h);
        },
      ),
    );
  }
}
