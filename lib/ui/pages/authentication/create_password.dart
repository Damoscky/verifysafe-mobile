import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/named_routes.dart';
import 'package:verifysafe/core/data/enum/password_type.dart';
import 'package:verifysafe/core/data/view_models/authentication_vms/password_vm.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/widgets/alert_dialogs/action_completed.dart';
import 'package:verifysafe/ui/widgets/authentication/password_requirement.dart';
import 'package:verifysafe/ui/widgets/authentication/terms.dart';

import '../../../core/constants/app_asset.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/utilities/validator.dart';
import '../../widgets/bottom_sheets/base_bottom_sheet.dart';
import '../../widgets/clickable.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_svg.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/screen_title.dart';

class CreatePassword extends ConsumerStatefulWidget {
  final PasswordType passwordType;
  const CreatePassword({super.key, required this.passwordType});

  @override
  ConsumerState<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends ConsumerState<CreatePassword> {

  final _pwd = TextEditingController();
  final _confirmPwd = TextEditingController();

  bool _hidePwd = true;
  bool _hideConfirmPwd = true;

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(passwordViewModel);
    return Scaffold(
      appBar: customAppBar(
        context: context,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppDimension.paddingLeft),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScreenTitle(
              headerText: 'Create your new password',
              secondSub: 'Please enter password below.',
              ),
            SizedBox(height: 24.h,),
            CustomTextField(
              label: 'Password',
              hintText: 'Enter your password',
              obscure: _hidePwd,
              controller: _pwd,
              validator: FieldValidator.validate,
              keyboardType: TextInputType.text,
              suffixIcon: Padding(
                padding: EdgeInsets.only(right: 16.w, left: 16.w),
                child: Clickable(
                  onPressed: (){
                    setState(() {
                      _hidePwd= !_hidePwd;
                    });
                  },
                  child: CustomAssetViewer(
                    asset:  _hidePwd
                        ? AppAsset.pwdHidden
                        : AppAsset.pwdVisible,
                    height: 16.h,
                    width: 16.w,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.textFieldSuffixIcon,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              onChanged: (value) => vm.checkPassWordRequirement(password: _pwd.text),
            ),
            SizedBox(height: 16.h,),
            CustomTextField(
              label: 'Confirm Password',
              hintText: 'Confirm your password',
              obscure: _hideConfirmPwd,
              controller: _confirmPwd,
              validator: FieldValidator.validate,
              keyboardType: TextInputType.text,
              suffixIcon: Padding(
                padding: EdgeInsets.only(right: 16.w, left: 16.w),
                child: Clickable(
                  onPressed: (){
                    setState(() {
                      _hideConfirmPwd= !_hideConfirmPwd;
                    });
                  },
                  child: CustomAssetViewer(
                    asset:  _hideConfirmPwd
                        ? AppAsset.pwdHidden
                        : AppAsset.pwdVisible,
                    height: 16.h,
                    width: 16.w,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.textFieldSuffixIcon,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
            PasswordRequirement(),
            if(widget.passwordType == PasswordType.forgotPassword)
              Padding(
              padding: EdgeInsets.only(top: 45.h),
              child: Align(
                alignment: Alignment.centerRight,
                child: CustomButton(
                    buttonWidth: null,
                    buttonHorizontalPadding: 43.w,
                    buttonText: 'Save',
                    onPressed: (){

                      baseBottomSheet(
                        context: context,
                        isDismissible: false,
                        enableDrag: false,
                        content: ActionCompleted(
                          title: 'Success!',
                          subtitle: 'You have successfully changed your password.',
                           buttonText: 'Sign in',
                           onPressed: (){
                            popUntilNavigation(context: context, route: NamedRoutes.login);
                           },
                        ),
                      );

                    }
                ),
              ),
            )
            else Padding(
              padding: EdgeInsets.only(top: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Terms(
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 24.h,),
                  CustomButton(
                      buttonText: 'Submit',
                      onPressed: (){
                        baseBottomSheet(
                          context: context,
                          isDismissible: false,
                          enableDrag: false,
                          content: ActionCompleted(
                            title: 'Success!',
                            subtitle: 'You have successfully created your password.',
                            buttonText: 'Sign in',
                            onPressed: (){
                              popUntilNavigation(context: context, route: NamedRoutes.login);
                            },
                          ),
                        );
                      }
                  ),

                ],
              ),
            )


          ],
        ),
      ),
    );
  }
}
