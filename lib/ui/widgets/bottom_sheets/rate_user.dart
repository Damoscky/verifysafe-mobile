import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/view_models/authentication_vms/authentication_view_model.dart';
import 'package:verifysafe/core/data/view_models/review_view_model.dart';
import 'package:verifysafe/core/utilities/navigator.dart';

import '../../../core/constants/color_path.dart';
import '../custom_button.dart';
import '../custom_drop_down.dart';
import '../custom_text_field.dart';
import '../rate_widget.dart';
import '../show_flush_bar.dart';

class RateUser extends ConsumerStatefulWidget {
  final bool isEmployer;
  const RateUser({super.key, required this.isEmployer});

  @override
  ConsumerState<RateUser> createState() => _RateUserState();
}

class _RateUserState extends ConsumerState<RateUser> {

  int? _selectedValue;
  final _description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(reviewViewModel);
    return IgnorePointer(
      ignoring: vm.thirdState == ViewState.busy,
      child: Padding(
        padding: EdgeInsets.only(left: AppDimension.bottomSheetPaddingLeft, right: AppDimension.bottomSheetPaddingRight, top: 45.h, bottom: 31.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.isEmployer ? 'Rate Employer':'Rate Worker',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.textPrimary
              ),
            ),
            SizedBox(height: 20.h,),
            Text(
              'How was your experience working here?',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textPrimary
              ),
            ),
            SizedBox(height: 20.h,),
            Rate(
              onSelect: (value) {
                print(value);
                _selectedValue = value;
              },
            ),
            // SizedBox(height: 16.h,),
            // CustomDropdown(
            //   hintText: "Select a Reason",
            //   label: 'Select Reason',
            //   fillColor: Colors.white,
            //   onChanged: (value){
            //
            //   },
            //   items: ['Nigeria', 'Australia'],
            // ),
            SizedBox(height: 16.h,),
            CustomTextField(
              hintText: 'Got any comments?',
              label: 'Comments',
              useDefaultHeight: false,
              fillColor: Colors.white,
              maxLines: 3,
              keyboardType: TextInputType.text,
              controller: _description,
            ),
            SizedBox(height: 16.h,),
            Align(
              alignment: Alignment.center,
              child: Text(
                'We would love to know',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: ColorPath.nevadaGrey
                ),
              ),
            ),
            SizedBox(height: 33.74.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: CustomButton(
                showLoader: vm.thirdState == ViewState.busy,
                  buttonText: 'Submit',
                  onPressed: ()async{

                    if(_selectedValue == null){
                      showFlushBar(
                          context: context,
                          message: 'Kindly select a rate value by clicking on an emoji to proceed',
                          success: false
                      );
                      return;
                    }

                    await vm.rateUser(
                        rating: _selectedValue,
                        description: _description.text,
                        revieweeId: ref.read(authenticationViewModel).userId,
                        userType: widget.isEmployer ? 'employer':'worker'
                    );

                    if(vm.thirdState == ViewState.retrieved){
                      popNavigation(context: context);
                    }

                    showFlushBar(
                        context: context,
                        message: vm.message,
                      success: vm.thirdState == ViewState.retrieved
                    );

                  }
              ),
            )


          ],
        ),
      ),
    );
  }
}
