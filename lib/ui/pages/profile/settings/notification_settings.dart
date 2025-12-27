import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/view_models/user_view_model.dart';
import 'package:verifysafe/core/utilities/secure_storage/secure_storage_utils.dart';
import 'package:verifysafe/ui/widgets/busy_overlay.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/show_flush_bar.dart';

class NotificationSettings extends ConsumerStatefulWidget {
  const NotificationSettings({super.key});

  @override
  ConsumerState<NotificationSettings> createState() =>
      _NotificationSettingsState();
}

class _NotificationSettingsState extends ConsumerState<NotificationSettings> {
  bool isEnabled = false;

  @override
  void initState() {
    updateUser2FA();
    super.initState();
  }

  updateUser2FA() async {
    isEnabled = await SecureStorageUtils.retrievePN();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final userVm = ref.watch(userViewModel);

    return BusyOverlay(
      show: userVm.state == ViewState.busy,
      child: Scaffold(
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
                        "${isEnabled ? "Disable" : "Enable"} Push Notification",
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
                    value: isEnabled,
                    onChanged: (value) async {
                      setState(() {
                        isEnabled = !isEnabled;
                      });
                      Map<String, dynamic> details = {
                        "push_notification_enabled": value,
                      };

                      await userVm.updateUserData(details: details);
                      if (userVm.state == ViewState.retrieved) {
                        showFlushBar(
                          context: context,
                          message: value
                              ? "Push Notification Enabled successfully."
                              : "Push Notification Disabled successfully.",
                        );
                      } else {
                        showFlushBar(
                          context: context,
                          message: userVm.message,
                          success: false,
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
