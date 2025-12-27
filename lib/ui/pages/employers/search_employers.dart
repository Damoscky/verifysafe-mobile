import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/view_models/search_employer_view_model.dart';
import 'package:verifysafe/core/utilities/debouncer.dart';
import 'package:verifysafe/ui/widgets/app_loader.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/custom_text_field.dart';
import 'package:verifysafe/ui/widgets/home/employers_data.dart';

class SearchEmployers extends ConsumerStatefulWidget {
  const SearchEmployers({super.key});

  @override
  ConsumerState<SearchEmployers> createState() => _SearchEmployersState();
}

class _SearchEmployersState extends ConsumerState<SearchEmployers> {
  final _scrollController = ScrollController();
  final _searchFocusNode = FocusNode();
  final Debouncer _debouncer = Debouncer();
  final TextEditingController _search = TextEditingController();

    @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollListener();
      ref.read(searchEmployerViewModel).employers.clear();
      _searchFocusNode.requestFocus();
      setState(() {});
    });
  }

  _scrollListener() {
    final vm = ref.watch(searchEmployerViewModel);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //check paginated state
        if (vm.paginatedState != ViewState.error) {
          //check if data is not being currently fetched and also check total records
          if (vm.paginatedState != ViewState.busy &&
              vm.employers.length < vm.totalRecords) {
            //fetch more
            vm.searchEmployers(firstCall: false, query: _search.text);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(searchEmployerViewModel);
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Search for Employer'),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w),
            child: CustomTextField(
              hintText: "Search for Employer",
              controller: _search,
              focusPointer: _searchFocusNode,
              onChanged: (value) {
                _debouncer.performAction(
                  action: () async {
                    await vm.searchEmployers(query: value);
                  },
                );
              },
              borderColor: ColorPath.niagaraGreen,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(CupertinoIcons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              controller: _scrollController,
              children: [
                SizedBox(height: 16.h),
                if (vm.secondState == ViewState.busy)
                  Padding(
                    padding: EdgeInsets.only(top: 100.0),
                    child: AppLoader(),
                  )
                else
                  EmployersData(employers: vm.employers, emptyStateTitle: ''),
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
        ],
      ),
    );
  }
}
