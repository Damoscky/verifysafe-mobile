import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/core/constants/named_routes.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/pages/profile/settings/two_fa_pin_screen.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/verifysafe_container.dart';

class TwoFaSettings extends StatefulWidget {
  const TwoFaSettings({super.key});

  @override
  State<TwoFaSettings> createState() => _TwoFaSettingsState();
}

class _TwoFaSettingsState extends State<TwoFaSettings> {
  bool isEnabled = false;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: customAppBar(
        context: context,
        showBottom: true,
        title: "Two Factor Authentication",
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: AppDimension.paddingLeft,
          right: AppDimension.paddingRight,
          bottom: 40.h,
          top: 32.h,
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            VerifySafeContainer(
              padding: EdgeInsets.all(16.w),
              bgColor: ColorPath.athensGrey4,
              borderRadius: BorderRadius.circular(16.r),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Two Factor Authentication",
                        style: textTheme.bodyLarge?.copyWith(
                          color: colorScheme.blackText,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "Enable 2FA",
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  CupertinoSwitch(
                    activeTrackColor: ColorPath.meadowGreen,
                    value: isEnabled,
                    onChanged: (value) async {
                      setState(() {
                        isEnabled = !isEnabled;
                      });
                      pushNavigation(
                        context: context,
                        widget: TwoFaPinScreen(),
                        routeName: NamedRoutes.twoFaPinScreen,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
