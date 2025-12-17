import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/data/view_models/employer_view_model.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/widgets/app_loader.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/error_state.dart';
import 'package:verifysafe/ui/widgets/verifysafe_container.dart';

import '../../../core/constants/color_path.dart';
import '../../../core/data/enum/view_state.dart';
import '../../../core/data/models/employer/employer.dart';
import '../../../core/utilities/debouncer.dart';
import '../../../core/utilities/utilities.dart';
import '../show_flush_bar.dart';

class SelectEmployer extends ConsumerStatefulWidget {
  final String searchHintText;
  final ValueChanged<Employer> onDone;
  const SelectEmployer({super.key, required this.searchHintText, required this.onDone});

  @override
  ConsumerState<SelectEmployer> createState() => _SelectEmployerState();
}

class _SelectEmployerState extends ConsumerState<SelectEmployer> {

  late TextEditingController _searchController;
  late Debouncer debouncer;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    debouncer = Debouncer(milliseconds: 800);
    ref.read(employerViewModel).reset();
  }



  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final vm = ref.watch(employerViewModel);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppDimension.paddingTop,
        horizontal: AppDimension.bottomSheetPaddingLeft
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _searchController,
            autofocus: true,
            cursorColor: colorScheme.textFieldHint,
            onChanged: (value){
              debouncer.performAction(action: () async {
                if (value.isNotEmpty &&
                    value.length >= 3){
                  Utilities.hideKeyboard(context);
                  //search employer
                  await vm.fetchEmployers(keyword: _searchController.text.trim());
                  showFlushBar(
                      context: context,
                      success: vm.secondState == ViewState.retrieved,
                      message: vm.employersMessage
                  );
                }
              });
            },
            decoration: InputDecoration(
              hintText: widget.searchHintText,
              hintStyle: textTheme.bodyMedium?.copyWith(
                color: colorScheme.textFieldHint,
              ),
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                icon: Icon(Icons.clear, color: Colors.grey),
                onPressed: () {
                  _searchController.clear();
                },
              )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: colorScheme.textFieldHint,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: colorScheme.textFieldHint,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: colorScheme.textFieldHint,
                  width: 2.w,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
            ),
          ),
          SizedBox(height: 16.h,),
          Expanded(
            child: Builder(
              builder: (context) {
                if(vm.secondState == ViewState.busy){
                  return Center(
                    child: AppLoader(),
                  );
                }

                if(vm.secondState == ViewState.retrieved){
                  if(vm.employers.isEmpty){
                    return Center(
                      child: Text(
                        'No Results found',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.textPrimary
                        ),
                      ),
                    );
                  }
                  return ListView.separated(
                    itemCount: vm.employers.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int index) {
                      final employer = vm.employers[index];
                      final name = employer.name ?? 'N/A';
                      final email = employer.email ?? 'N/A';
                      return Clickable(
                        onPressed: (){
                          vm.selectedEmployer = employer;
                          widget.onDone(employer);
                          popNavigation(context: context);
                        },
                        child: VerifySafeContainer(
                          bgColor: ColorPath.athensGrey6,
                          padding: EdgeInsets.symmetric(
                            vertical: 8.h,
                            horizontal: 8.w
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).colorScheme.textPrimary
                                ),
                              ),
                              SizedBox(height: 2.h,),
                              Text(
                                email,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).colorScheme.textPrimary
                                ),
                              ),

                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 16.h,);
                    },
                  );
                }

                if(vm.secondState == ViewState.error){
                  return Center(
                    child: ErrorState(
                      message: vm.employersMessage,
                        onPressed: ()=>vm.fetchEmployers(keyword: _searchController.text)),
                  );
                }

                return const SizedBox.shrink();

              }
            ),
          )
        ],
      ),
    );
  }
}
