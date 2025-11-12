import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({super.key});

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: customAppBar(
        context: context,
        showBottom: true,
        title: "Notification Settings",
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
              "General Notification",
              style: textTheme.bodyMedium?.copyWith(color: colorScheme.text4),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Enable Push Notification",
                      style: textTheme.bodyLarge?.copyWith(
                        color: colorScheme.blackText,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "See all notification",
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.textSecondary,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                CupertinoSwitch(
                  activeTrackColor: ColorPath.meadowGreen,
                  value: true,
                  onChanged: (value) {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
