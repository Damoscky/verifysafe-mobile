import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/core/constants/named_routes.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/view_models/worker_view_model.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/pages/authentication/onboarding/worker/basic_info.dart';
import 'package:verifysafe/ui/pages/workers/search_workers.dart';
import 'package:verifysafe/ui/widgets/app_loader.dart';
import 'package:verifysafe/ui/widgets/bottom_sheets/base_bottom_sheet.dart';
import 'package:verifysafe/ui/widgets/bottom_sheets/filters/worker_filter_options.dart';
import 'package:verifysafe/ui/widgets/bottom_sheets/sort_options.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/custom_text_field.dart';
import 'package:verifysafe/ui/widgets/home/workers_data.dart';
import 'package:verifysafe/ui/widgets/sort_and_filter_tab.dart';
import 'package:verifysafe/ui/widgets/work_widgets/workers_dashboard_card.dart';

class Workers extends ConsumerStatefulWidget {
  const Workers({super.key});

  @override
  ConsumerState<Workers> createState() => _WorkersState();
}

class _WorkersState extends ConsumerState<Workers> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollListener();
    });
  }

  _scrollListener() {
    final vm = ref.watch(workerViewModel);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //check paginated state
        if (vm.paginatedState != ViewState.error) {
          //check if data is not being currently fetched and also check total records
          if (vm.paginatedState != ViewState.busy &&
              vm.workers.length < vm.totalRecords) {
            //fetch more
            vm.fetchWorkersDetails(firstCall: false);
          }
        }
      }
    });
  }

  String? selectedSortOption;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final vm = ref.watch(workerViewModel);

    return Scaffold(
      appBar: customAppBar(
        context: context,
        showLeadingIcon: false,
        title: 'Workers',
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 24.w),
            child: Clickable(
              onPressed: () {
                pushNavigation(
                  context: context,
                  widget: BasicInfo(userRole: "worker"),
                  routeName: NamedRoutes.basicInfo,
                );
              },
              child: Row(
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 8.w),
                  Text(
                    "Add",
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        showBottom: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          vm.fetchWorkersDetails();
        },
        child: ListView(
          // padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 16.h),
          controller: _scrollController,
          children: [
            WorkersDashboardCard(total: vm.totalRecords.toString()),
            Padding(
              padding: EdgeInsets.only(left: 24.w, right: 24.w),
              child: Clickable(
                onPressed: () {
                  pushNavigation(
                    context: context,
                    widget: const SearchWorkers(),
                    routeName: NamedRoutes.searchWorker,
                  );
                },
                child: CustomTextField(
                  hintText: "Search for Worker",
                  onChanged: (value) {},
                  enabled: false,
                  readOnly: true,
                  borderColor: ColorPath.niagaraGreen,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(CupertinoIcons.search),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.h),

              child: SortAndFilterTab(
                sortOnPressed: () {
                  baseBottomSheet(
                    context: context,
                    content: SortOptions(
                      filterOptions: ['Ascending', 'Descending'],
                      initialValue: selectedSortOption,
                      onSelected: (value) {
                        if (value == 'Ascending') {
                          vm.sortOption = 'date_ascending';
                        }
                        if (value == 'Descending') {
                          vm.sortOption = 'date_descending';
                        }
                        if (value == null) {
                          vm.sortOption = null;
                        }
                        selectedSortOption = value;
                        setState(() {});
                        vm.fetchWorkersDetails();
                      },
                    ),
                  );
                },
                filterOnPressed: () {
                  baseBottomSheet(
                    context: context,
                    content: WorkerFilterOptions(),
                  );
                },
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.h),
              child: Text(
                "View workers data below",
                style: textTheme.bodyMedium?.copyWith(color: colorScheme.text4),
              ),
            ),

            WorkersData(workers: vm.workers),
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
    );
  }
}
