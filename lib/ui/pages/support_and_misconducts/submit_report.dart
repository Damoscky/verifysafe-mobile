import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/data/view_models/employer_view_model.dart';
import 'package:verifysafe/core/data/view_models/general_data_view_model.dart';
import 'package:verifysafe/core/data/view_models/misconducts_view_model.dart';
import 'package:verifysafe/core/data/view_models/worker_view_model.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/widgets/bottom_sheets/select_employer.dart';
import 'package:verifysafe/ui/widgets/bottom_sheets/select_worker.dart';
import 'package:verifysafe/ui/widgets/busy_overlay.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/upload_attachment.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/data/enum/view_state.dart';
import '../../../core/data/models/user.dart';
import '../../../core/data/view_models/user_view_model.dart';
import '../../../core/utilities/image_and_doc_utils.dart';
import '../../../core/utilities/validator.dart';
import '../../widgets/bottom_sheets/action_completed.dart';
import '../../widgets/bottom_sheets/base_bottom_sheet.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_drop_down.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/show_flush_bar.dart';


class SubmitReport extends ConsumerStatefulWidget {
  final bool isReportingWorker;
  final bool isReportingEmployer;
  final User? user;
  const SubmitReport({super.key, this.isReportingEmployer = false, this.isReportingWorker = false, this.user});

  @override
  ConsumerState<SubmitReport> createState() => _SubmitReportState();
}

class _SubmitReportState extends ConsumerState<SubmitReport> {

  List<String> dummyEmployers = [];
  List<String> dummyWorkers = [];
  String? _misconductType;
  String? _userType;
  String? _imageUrl;
  final _description = TextEditingController();
  final _name = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if(widget.isReportingWorker || widget.isReportingEmployer){
      //set selected worker
      final workerVm = ref.read(workerViewModel);
      workerVm.selectedWorker = widget.user;
      //init text controller
      _name.text = workerVm.selectedWorker?.name ?? '';

    }

    if(widget.isReportingEmployer){
      //set selected employer
      final employerVm = ref.read(employerViewModel);
      employerVm.selectedEmployer = widget.user;
      //init text controller
      _name.text =  employerVm.selectedEmployer?.name ?? '';
    }
  }

  @override
  void dispose() {
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userVm = ref.read(userViewModel);
    final generalVm = ref.watch(generalDataViewModel);
    final vm = ref.watch(misconductsViewModel);
    return BusyOverlay(
      show: generalVm.generalState == ViewState.busy || vm.secondState == ViewState.busy,
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          title: 'Submit a Report',
          showBottom: true,
          appbarBottomPadding: 10.h,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: AppDimension.paddingLeft, right: AppDimension.paddingRight, bottom: 40.h, top: 20.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(widget.isReportingWorker || widget.isReportingEmployer)
                    CustomTextField(
                    hintText: 'Email',
                    label: widget.isReportingEmployer ? 'Employer':'Worker',
                    keyboardType: TextInputType.text,
                    controller: _name,
                    enabled: false,
                    validator: FieldValidator.validate,
                  )
                else
                  if(userVm.isWorker || userVm.isEmployer)Consumer(
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
                                  if(dummyEmployers.contains(value.name ?? '')){
                                    setState(() {});
                                    return;
                                  }
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
                                  if(dummyWorkers.contains(value.name ?? '')){
                                    setState(() {});
                                    return;
                                  }
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
                )
                  else agencyFlow(context),
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
                  controller: _description,
                  validator: FieldValidator.validate,
                ),
                SizedBox(height: 20.h,),
                UploadAttachment(
                  title: _imageUrl?.split('/').last,
                  subtitle: _imageUrl != null ? '':null,
                  buttonText: _imageUrl != null ? 'Change File':null,
                  onPressed: ()async{
                    final base64String = await ImageAndDocUtils.pickAndCropImage(
                      context: context,
                    );
                    if (base64String != null) {
                      await generalVm.uploadImage(base64String: base64String);
                      if(generalVm.generalState == ViewState.retrieved){
                        setState(() {
                          _imageUrl = generalVm.fileUploadsResponse.first.url;
                        });
                      }
                      showFlushBar(
                        context: context,
                        message: generalVm.message,
                        success: generalVm.generalState == ViewState.retrieved,
                      );
                    }
                  },
                ),
                SizedBox(height: 40.h,),
                CustomButton(
                    buttonText: 'Done',
                    onPressed: ()async{

                      final validate = _formKey.currentState!.validate();
                      if(validate){

                        final employerVm = ref.read(employerViewModel);
                        final workerVm = ref.read(workerViewModel);
                        final isWorkerType = _userType?.toLowerCase() == 'worker';
                        final isEmployerType = _userType?.toLowerCase() == 'employer';

                        if(!widget.isReportingEmployer && !widget.isReportingWorker){

                          if(userVm.isWorker && employerVm.selectedEmployer == null){
                            showFlushBar(
                                context: context,
                                message: 'Select an employer to proceed',
                                success: false
                            );
                            return;
                          }

                          if(userVm.isEmployer && workerVm.selectedWorker == null){
                            showFlushBar(
                                context: context,
                                message: 'Select a worker to proceed',
                                success: false
                            );
                            return;
                          }

                          if(userVm.isAgency && _userType == null){
                            showFlushBar(
                                context: context,
                                message: 'Select a user type',
                                success: false
                            );
                            return;
                          }

                          if(userVm.isAgency && isWorkerType && workerVm.selectedWorker == null){
                            showFlushBar(
                                context: context,
                                message: 'Select a worker to proceed',
                                success: false
                            );
                            return;
                          }

                          if(userVm.isAgency && isEmployerType && employerVm.selectedEmployer == null){
                            showFlushBar(
                                context: context,
                                message: 'Select an employer to proceed',
                                success: false
                            );
                            return;
                          }
                        }

                        if(_misconductType == null){
                          showFlushBar(
                              context: context,
                              message: 'Select a report type to proceed',
                              success: false
                          );
                          return;
                        }

                        baseBottomSheet(
                          context: context,
                          content: ActionCompleted(
                            asset: AppAsset.actionConfirmation,
                            title: 'Submit',
                            subtitle: 'Are you sure you want to submit this report?',
                            buttonText: 'Yes, Submit',
                            onPressed: ()async{

                              popNavigation(context: context);

                              if(!widget.isReportingEmployer && !widget.isReportingWorker){
                                await vm.submitReport(
                                    reporteeId:
                                    userVm.isWorker
                                        ? employerVm.selectedEmployer?.employer?.identifier
                                        : userVm.isEmployer
                                        ? workerVm.selectedWorker?.id
                                        : isWorkerType
                                        ? workerVm.selectedWorker?.id
                                        : isEmployerType
                                        ? employerVm.selectedEmployer?.employer?.identifier
                                        :'',
                                    reporteeType:
                                    userVm.isWorker
                                        ? 'employer'
                                        : userVm.isEmployer
                                        ? 'worker'
                                        : isWorkerType
                                        ? 'worker'
                                        : isEmployerType
                                        ? 'employer'
                                        :'',
                                    reportType: _misconductType,
                                    comment: _description.text,
                                    attachment: _imageUrl
                                );
                              }
                              else{
                                await vm.submitReport(
                                    reporteeId:
                                    widget.isReportingWorker
                                        ? workerVm.selectedWorker?.id
                                        : employerVm.selectedEmployer?.employer?.identifier,
                                    reporteeType:
                                    widget.isReportingWorker
                                        ? 'worker'
                                        : 'employer',
                                    reportType: _misconductType,
                                    comment: _description.text,
                                    attachment: _imageUrl
                                );
                              }

                              // if(vm.secondState == ViewState.retrieved){
                              //   popNavigation(context: context);
                              // }

                              showFlushBar(
                                  context: context,
                                  message: vm.message,
                                  success: vm.secondState == ViewState.retrieved
                              );

                            },
                          ),
                        );

                      }





                    }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  agencyFlow(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomDropdown(
          hintText: "Select User Type",
          label: 'Select User Type',
          value: _userType,
          onChanged: (value){
            setState(() {
              _userType = value;
            });
          },
          items: ['Employer', 'Worker'],
        ),
        SizedBox(height: 16.h,),
        if(_userType != null)BounceInLeft(
          duration: const Duration(milliseconds: 800),
          delay: const Duration(milliseconds: 200),
          child: Consumer(
            builder: (context, ref, child){
              final employerVm = ref.watch(employerViewModel);
              final workerVm = ref.watch(workerViewModel);
              return Clickable(
                onPressed: (){
                  if(_userType?.toLowerCase() == 'employer'){
                    baseBottomSheet(
                        context: context,
                        content: SelectEmployer(
                          searchHintText: 'Search Employer',
                          onDone: (value){
                            if(dummyEmployers.contains(value.name ?? '')){
                              setState(() {});
                              return;
                            }
                            dummyEmployers.add(value.name ?? '');
                            setState(() {});
                          },

                        )
                    );
                    return;
                  }

                  if(_userType?.toLowerCase() == 'worker'){
                    baseBottomSheet(
                        context: context,
                        content: SelectWorker(
                          searchHintText: 'Search Worker',
                          onDone: (value){
                            if(dummyWorkers.contains(value.name ?? '')){
                              setState(() {});
                              return;
                            }
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
                    if(_userType?.toLowerCase() == 'employer'){
                      return CustomDropdown(
                        hintText: "Select Employer",
                        label: 'Select Employer',
                        enabled: false,
                        value: employerVm.selectedEmployer?.name,
                        onChanged: (value){},
                        items: dummyEmployers,
                      );
                    }
                    if(_userType?.toLowerCase() == 'worker'){
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
        )


      ],
    );
  }
}
