import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/data/view_models/guarantor_view_model.dart';
import 'package:verifysafe/ui/widgets/busy_overlay.dart';
import 'package:verifysafe/ui/widgets/details.dart';
import 'package:verifysafe/ui/widgets/show_flush_bar.dart';
import 'package:verifysafe/ui/widgets/verifysafe_container.dart';
import 'package:verifysafe/ui/widgets/verifysafe_tag.dart';
import '../../../core/constants/app_asset.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/data/enum/view_state.dart';
import '../../../core/utilities/navigator.dart';
import '../../widgets/bottom_sheets/action_completed.dart';
import '../../widgets/bottom_sheets/base_bottom_sheet.dart';
import '../../widgets/clickable.dart';
import '../../widgets/custom_appbar.dart';

class ViewGuarantorDetails extends ConsumerWidget {
  const ViewGuarantorDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(guarantorViewModel);
    return BusyOverlay(
      show: vm.thirdState == ViewState.busy,
      child: Scaffold(
        appBar: customAppBar(
            context: context,
            title: vm.name,
            showBottom: true,
            appbarBottomPadding: 10.h,
            actions:[
              if((!vm.isPending || !vm.isDeclined) && vm.isActive)Padding(
                padding: EdgeInsets.only(right: AppDimension.paddingRight),
                child: Clickable(
                  onPressed: (){
                    baseBottomSheet(
                      context: context,
                      content: ActionCompleted(
                        asset: AppAsset.actionConfirmation,
                        title: 'Deactivate',
                        subtitle: 'Are you sure you want to deactivate guarantor’s profile?',
                        buttonText: 'Yes, Deactivate',
                        onPressed: ()async{
                          popNavigation(context: context);

                          await vm.deactivateGuarantor();
                          showFlushBar(
                              context: context,
                              message: vm.message,
                            success: vm.thirdState == ViewState.retrieved
                          );

                        },
                      ),
                    );
                  },
                  child:  Text(
                    'Deactivate',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.text4
                    ),
                  ),
                ),
              )
            ]
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: AppDimension.paddingLeft, right: AppDimension.paddingRight, bottom: 40.h, top: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VerifySafeContainer(
                  bgColor: ColorPath.aquaGreen,
                  padding: EdgeInsets.symmetric(
                      vertical: 16.h,
                      horizontal: 16.w
                  ),
                  border: Border.all(color: ColorPath.gloryGreen, width: 1.w),
                  borderRadius: BorderRadius.all(Radius.circular(16.r)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        vm.name,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.textPrimary
                        ),
                      ),
                      // SizedBox(height: 4.h,),
                      // Text(
                      //   'Domestic Worker',
                      //   style: Theme.of(context)
                      //       .textTheme
                      //       .bodyLarge
                      //       ?.copyWith(
                      //       fontWeight: FontWeight.w400,
                      //       color: Theme.of(context).colorScheme.textPrimary
                      //   ),
                      // ),
                      SizedBox(height: 16.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Timestamp',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).colorScheme.text4
                                  ),
                                ),
                                SizedBox(height: 8.h,),
                                Text(
                                  vm.date,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: Theme.of(context).colorScheme.text4
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10.w,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Status',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).colorScheme.text4
                                  ),
                                ),
                                SizedBox(height: 8.h,),
                                VerifySafeTag(status: vm.status)
                              ],
                            ),
                          ),
                        ],
                      )

                    ],
                  )
              ),
              SizedBox(height: 16.h,),
              Details(label: 'Request Date', value: vm.date),
              if(vm.approvedDate != null)SizedBox(height: 16.h,),
              if(vm.approvedDate != null)Details(label: 'Date Accepted', value: vm.approvedDate ?? ''),
              SizedBox(height: 16.h,),
              Details(label: 'Relationship', value:vm.relationship),
              SizedBox(height: 16.h,),
              Details(label: 'Email', value: vm.email),
              SizedBox(height: 16.h,),
              Details(label: 'Phone', value: vm.phone),
              SizedBox(height: 16.h,),
              Details(label: 'Country of Residence', value: vm.country),
              SizedBox(height: 16.h,),
              Details(label: 'State of Residence', value: vm.stateOfResidence),
              SizedBox(height: 16.h,),
              Details(label: 'Local Government Area', value: vm.lga),
              SizedBox(height: 16.h,),
              Details(label: 'Address', value: vm.address),
            ],
          ),
        ),
      ),
    );
  }
}


