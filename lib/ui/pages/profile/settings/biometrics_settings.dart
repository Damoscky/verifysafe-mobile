import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/core/utilities/biometric_utils.dart';
import 'package:verifysafe/core/utilities/secure_storage/secure_storage_utils.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/show_flush_bar.dart';

class BiometricsSettings extends StatefulWidget {
  const BiometricsSettings({super.key});

  @override
  State<BiometricsSettings> createState() => _BiometricsSettingsState();
}

class _BiometricsSettingsState extends State<BiometricsSettings> {
  bool _isEnabled = false;
  bool _hasBio = false;

  @override
  void initState() {
    updateBiometricState();
    hasBioMetrics();
    super.initState();
  }

  updateBiometricState() {
    SecureStorageUtils.retrieveBiometricPref().then((value) {
      setState(() {
        _isEnabled = value;
      });
    });
  }

  hasBioMetrics() async {
    _hasBio = await BiometricUtils.canAuthenticate();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: customAppBar(
        context: context,
        showBottom: true,
        title: "Biometric Settings",
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
            Text(
              "Manage how you use your biometrics",
              style: textTheme.bodyMedium?.copyWith(color: colorScheme.text4),
            ),
            SizedBox(height: 16.h),
            if (_hasBio)
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login with ${Platform.isIOS ? "Face ID" : "Biometrics"}",
                        style: textTheme.bodyLarge?.copyWith(
                          color: colorScheme.blackText,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      // Text(
                      //   "See all notification",
                      //   style: textTheme.bodySmall?.copyWith(
                      //     color: colorScheme.textSecondary,
                      //   ),
                      // ),
                    ],
                  ),
                  Spacer(),
                  CupertinoSwitch(
                    activeTrackColor: ColorPath.meadowGreen,
                    value: _isEnabled,
                    onChanged: (value) async {
                      setState(() {
                        _isEnabled = value;
                      });
                      await SecureStorageUtils.biometricsEnabled(value: value);

                      if (value) {
                        showFlushBar(
                          context: context,
                          message: "Biometrics enabled successfuly",
                        );
                      } else {
                        showFlushBar(
                          context: context,
                          message: "Biometrics disabled successfuly",
                        );
                      }
                    },
                  ),
                ],
              )
            else
              Text(
                "Device Does not have access to Biometrics",
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.error,
                  fontWeight: FontWeight.w700,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
