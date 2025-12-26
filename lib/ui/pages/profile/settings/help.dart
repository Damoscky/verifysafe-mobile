import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/data/view_models/review_view_model.dart';
import 'package:verifysafe/core/utilities/validator.dart';
import 'package:verifysafe/ui/widgets/busy_overlay.dart';
import 'package:verifysafe/ui/widgets/screen_title.dart';

import '../../../../core/constants/app_dimension.dart';
import '../../../../core/constants/color_path.dart';
import '../../../../core/data/enum/view_state.dart';
import '../../../../core/utilities/navigator.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/show_flush_bar.dart';

class Help extends ConsumerStatefulWidget {
  const Help({super.key});

  @override
  ConsumerState<Help> createState() => _HelpState();
}

class _HelpState extends ConsumerState<Help> {

  final _subject = TextEditingController();
  final _description = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(reviewViewModel);
    return BusyOverlay(
      show: vm.secondState == ViewState.busy,
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          showBottom: true,
          title: "Help",
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: AppDimension.paddingLeft,
            right: AppDimension.paddingRight,
            bottom: 40.h,
            top: 32.h,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ready To Help You ",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 10.h,),
                Text(
                  "Please contact VerifySafe if you have any questions or concerns. We are always friendly and happy to answer your questions.",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                    color: ColorPath.nevadaGrey
                  ),
                ),
                SizedBox(height: 20.h,),
                CustomTextField(
                  hintText: 'Enter subject',
                  label: 'Subject',
                  keyboardType: TextInputType.text,
                  controller: _subject,
                  validator: FieldValidator.validate,
                ),
                SizedBox(height: 16.h,),
                CustomTextField(
                  useDefaultHeight: false,
                  maxLines: 7,
                  label: 'Description',
                  hintText: "Enter Description...",
                  controller: _description,
                  validator: FieldValidator.validate,
                ),
                SizedBox(height: 40.h,),
                CustomButton(onPressed: () async{

                  final validate = _formKey.currentState!.validate();
                  if(validate){
                    await vm.shareFeedback(
                        description: _description.text,
                        subject: _subject.text,
                        type: 'support',
                    );
                    if(vm.secondState == ViewState.retrieved){
                      popNavigation(context: context);
                    }
                    showFlushBar(
                        context: context,
                        message: vm.message,
                        success: vm.secondState == ViewState.retrieved
                    );
                  }



                }, buttonText: "Submit"),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
