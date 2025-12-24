import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/data/models/user.dart';
import 'package:verifysafe/core/data/view_models/worker_view_model.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/widgets/app_loader.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/error_state.dart';
import 'package:verifysafe/ui/widgets/verifysafe_container.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/data/enum/view_state.dart';
import '../../../core/data/models/worker/worker.dart';
import '../../../core/utilities/debouncer.dart';
import '../../../core/utilities/utilities.dart';
import '../show_flush_bar.dart';

class SelectWorker extends ConsumerStatefulWidget {
  final String searchHintText;
  final ValueChanged<User> onDone;
  const SelectWorker({super.key, required this.searchHintText, required this.onDone});

  @override
  ConsumerState<SelectWorker> createState() => _SelectWorkerState();
}

class _SelectWorkerState extends ConsumerState<SelectWorker> {

  late TextEditingController _searchController;
  late Debouncer debouncer;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    debouncer = Debouncer(milliseconds: 800);
    ref.read(workerViewModel).reset();
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
    final vm = ref.watch(workerViewModel);
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
                  //search worker
                  await vm.fetchWorkers(keyword: _searchController.text.trim());
                  showFlushBar(
                      context: context,
                      success: vm.secondState == ViewState.retrieved,
                      message: vm.workerMessage
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
                    if(vm.workers.isEmpty){
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
                      itemCount: vm.workers.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (BuildContext context, int index) {
                        final worker = vm.workers[index];
                        final name = worker.name ?? 'N/A';
                        final email = worker.email ?? 'N/A';
                        return Clickable(
                          onPressed: (){
                            vm.selectedWorker = worker;
                            widget.onDone(worker);
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
                          message: vm.workerMessage,
                          onPressed: ()=>vm.fetchWorkers(keyword: _searchController.text)),
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
