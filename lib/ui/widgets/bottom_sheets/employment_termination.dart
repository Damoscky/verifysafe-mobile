import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/data/view_models/employment_view_model.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/core/utilities/validator.dart';
import 'package:verifysafe/ui/widgets/show_flush_bar.dart';
import '../../../core/constants/app_asset.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/data/enum/view_state.dart';
import '../../../core/data/models/user.dart';
import '../custom_button.dart';
import '../custom_text_field.dart';
import 'action_completed.dart';
import 'base_bottom_sheet.dart';


class EmploymentTermination extends ConsumerStatefulWidget {
  final bool isEmployer;
  final User user;
  const EmploymentTermination({super.key, required this.isEmployer, required this.user});

  @override
  ConsumerState<EmploymentTermination> createState() => _EmploymentTerminationState();
}

class _EmploymentTerminationState extends ConsumerState<EmploymentTermination> {

  final _reason = TextEditingController();
  final _description = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: AppDimension.bottomSheetPaddingLeft, right: AppDimension.bottomSheetPaddingRight, top: 45.h, bottom: 31.h),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Terminate Employment',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.textPrimary
              ),
            ),
            SizedBox(height: 16.h,),
            if(widget.isEmployer)RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.textPrimary
                ),
                children: [
                  TextSpan(
                    text: 'You are about to end ',
                  ),
                  TextSpan(
                    text: '${widget.user.name ?? 'N/A'} ',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: 'employment',
                  ),
                ],
              ),
            )
            else RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.textPrimary
                ),
                children: [
                  TextSpan(
                    text: 'You are about to end your employment with ',
                  ),
                  TextSpan(
                    text: widget.user.name ?? 'N/A',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h,),
            CustomTextField(
              hintText: 'Reason for termination',
              label: 'Reason for termination',
              keyboardType: TextInputType.text,
              controller: _reason,
              validator: FieldValidator.validate,
            ),
            SizedBox(height: 16.h,),
            CustomTextField(
              hintText: 'Description',
              label: 'Description',
              useDefaultHeight: false,
              fillColor: Colors.white,
              maxLines: 3,
              keyboardType: TextInputType.text,
              controller: _description,
              validator: FieldValidator.validate,
            ),
            SizedBox(height: 24.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: CustomButton(
                  showLoader: false,
                  buttonText: 'Terminate',
                  onPressed: ()async{

                    final validate = _formKey.currentState!.validate();

                    if(validate){

                      baseBottomSheet(
                        context: context,
                        content: ActionCompleted(
                          asset: AppAsset.actionConfirmation,
                          title: 'Terminate Employment',
                          subtitle: 'Are you sure you want to Terminate Employment?',
                          buttonText: 'Yes, Terminate',
                          onPressed: ()async{

                            //close confirmation bottom-sheet
                            popNavigation(context: context);
                            //close employment termination bottom-sheet
                            popNavigation(context: context);

                            final vm = ref.read(employmentViewModel);

                            await vm.terminateEmployment(
                                reason: _reason.text,
                                description: _description.text,
                                exitType: widget.isEmployer ? 'terminate':'resignation',
                                userId: widget.user.id
                            );

                            showFlushBar(
                                context: context,
                                message: vm.message,
                                success: vm.state == ViewState.retrieved
                            );


                          },
                        ),
                      );

                    }



                  }
              ),
            )


          ],
        ),
      ),
    );
  }
}
