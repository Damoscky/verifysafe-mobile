import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/data/view_models/employer_view_model.dart';
import 'package:verifysafe/core/data/view_models/general_data_view_model.dart';
import 'package:verifysafe/core/data/view_models/worker_view_model.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/widgets/bottom_sheets/select_employer.dart';
import 'package:verifysafe/ui/widgets/bottom_sheets/select_worker.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/upload_attachment.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/data/view_models/user_view_model.dart';
import '../../../core/utilities/validator.dart';
import '../../widgets/bottom_sheets/action_completed.dart';
import '../../widgets/bottom_sheets/base_bottom_sheet.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_drop_down.dart';
import '../../widgets/custom_text_field.dart';


class SubmitReport extends ConsumerStatefulWidget {
  const SubmitReport({super.key});

  @override
  ConsumerState<SubmitReport> createState() => _SubmitReportState();
}

class _SubmitReportState extends ConsumerState<SubmitReport> {

  List<String> dummyEmployers = [];
  List<String> dummyWorkers = [];
  String? _misconductType;
  String? _userType;
  final _description = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userVm = ref.read(userViewModel);
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Submit a Report',
        showBottom: true,
        appbarBottomPadding: 10.h,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: AppDimension.paddingLeft, right: AppDimension.paddingRight, bottom: 40.h, top: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer(
              builder: (context, ref, child){
                final employerVm = ref.watch(employerViewModel);
                final workerVm = ref.watch(workerViewModel);
                return Clickable(
                  onPressed: (){
                    if(userVm.isWorker){
                      baseBottomSheet(
                          context: context,
                          content: SelectEmployer(
                            searchHintText: 'Search Employer',
                            onDone: (value){
                              dummyEmployers.add(value.name ?? '');
                              setState(() {});
                            },

                          )
                      );
                      return;
                    }

                    if(userVm.isEmployer){
                      baseBottomSheet(
                          context: context,
                          content: SelectWorker(
                            searchHintText: 'Search Worker',
                            onDone: (value){
                              dummyWorkers.add(value.name ?? '');
                              setState(() {});
                            },

                          )
                      );
                      return;
                    }

                  },
                  child: Builder(
                    builder: (context){
                      if(userVm.isWorker){
                        return CustomDropdown(
                          hintText: "Select Employer",
                          label: 'Select Employer',
                          enabled: false,
                          value: employerVm.selectedEmployer?.name,
                          onChanged: (value){},
                          items: dummyEmployers,
                        );
                      }
                      if(userVm.isEmployer){
                        return CustomDropdown(
                          hintText: "Select Worker",
                          label: 'Select Worker',
                          enabled: false,
                          value: workerVm.selectedWorker?.name,
                          onChanged: (value){},
                          items: dummyWorkers,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 16.h,),
            Consumer(
              builder: (context, ref, child){
                final genVm = ref.watch(generalDataViewModel);
                return CustomDropdown(
                  hintText: "Select Report Type",
                  label: 'Select Report Type',
                  value: _misconductType,
                  onChanged: (value){
                    setState(() {
                      _misconductType = value;
                    });
                  },
                  items: genVm.misconductTypes,
                );
              },
            ),
            SizedBox(height: 16.h,),
            CustomTextField(
              hintText: 'Description',
              label: 'Comment',
              keyboardType: TextInputType.text,
              maxLines: 4,
              useDefaultHeight: false,
              //controller: _email,
              validator: FieldValidator.validate,
            ),
            SizedBox(height: 20.h,),
            UploadAttachment(
              onPressed: (){},
            ),
            SizedBox(height: 40.h,),
            CustomButton(
                buttonText: 'Done',
                onPressed: (){
                  baseBottomSheet(
                    context: context,
                    content: ActionCompleted(
                      asset: AppAsset.actionConfirmation,
                      title: 'Submit',
                      subtitle: 'Are you sure you want to submit this report?',
                      buttonText: 'Yes, Submit',
                      onPressed: (){
                        popNavigation(context: context);
                      },
                    ),
                  );

                }
            ),
          ],
        ),
      ),
    );
  }
}
