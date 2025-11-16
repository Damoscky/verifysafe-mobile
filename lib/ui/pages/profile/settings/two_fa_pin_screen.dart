import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/widgets/bottom_sheets/action_completed.dart';
import 'package:verifysafe/ui/widgets/bottom_sheets/base_bottom_sheet.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/screen_title.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';

class TwoFaPinScreen extends StatefulWidget {
  const TwoFaPinScreen({super.key});

  @override
  State<TwoFaPinScreen> createState() => _TwoFaPinScreenState();
}

class _TwoFaPinScreenState extends State<TwoFaPinScreen> {
  final _otp = TextEditingController();
  bool isConfirmPin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimension.paddingLeft,
          vertical: 24.h,
        ),
        children: [
          ScreenTitle(headerText: "Two Factor Authentication"),
          SizedBox(height: 10.h),
          Text(
            isConfirmPin
                ? "Re-enter 4 digit pin"
                : "Set 4 digit pin you won’t forget",
          ),
          SizedBox(height: 54.h),
          PinCodeTextField(
            length: 4,
            controller: _otp,
            mainAxisAlignment: MainAxisAlignment.center,
            separatorBuilder: (context, index) {
              return SizedBox(width: 16.w);
            },
            obscureText: false,
            animationType: AnimationType.fade,
            backgroundColor: Colors.transparent,
            obscuringCharacter: "*",
            keyboardType: TextInputType.number,
            cursorColor: Theme.of(context).colorScheme.textPrimary,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            pinTheme: PinTheme(
              disabledColor: Colors.transparent,
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.all(Radius.circular(4.r)),
              fieldHeight: 44.h,
              fieldWidth: 44.w,
              inactiveColor: Theme.of(
                context,
              ).colorScheme.pinCodeInactiveBorderColor,
              activeColor: Theme.of(
                context,
              ).colorScheme.pinCodeActiveBorderColor,
              borderWidth: 2.w,
              selectedColor: Theme.of(
                context,
              ).colorScheme.pinCodeInactiveBorderColor,
              selectedFillColor: Theme.of(
                context,
              ).colorScheme.pinCodeInactiveFillColor,
              inactiveFillColor: Theme.of(
                context,
              ).colorScheme.pinCodeInactiveFillColor,
              activeFillColor: Theme.of(
                context,
              ).colorScheme.pinCodeActiveFillColor,
            ),
            textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              //fontSize: 31.sp,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.brandColor,
            ),
            enabled: true,
            appContext: context,
            animationDuration: const Duration(milliseconds: 300),
            enableActiveFill: true,
            onCompleted: (v) {
              debugPrint("Completed: $v");
              if (isConfirmPin) {
                baseBottomSheet(
                  context: context,
                  isDismissible: false,
                  enableDrag: false,
                  content: ActionCompleted(
                    title: 'Success!',
                    subtitle:
                        'Two factor authentication has been enable successfully',
                    buttonText: 'Done',
                    onPressed: () {
                      popNavigation(context: context);
                      popNavigation(context: context);
                    },
                  ),
                );
                return;
              }
              setState(() {
                isConfirmPin = true;
                _otp.text = '';
              });
            },
            onChanged: (value) {
              //model.otp = value;
            },
          ),
          SizedBox(height: 10.h),
          if (isConfirmPin)
            Text("Re-enter 4 digit code", textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
