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
import 'package:verifysafe/ui/widgets/verifysafe_container.dart';

class TwoFaSettings extends ConsumerStatefulWidget {
  const TwoFaSettings({super.key});

  @override
  ConsumerState<TwoFaSettings> createState() => _TwoFaSettingsState();
}

class _TwoFaSettingsState extends ConsumerState<TwoFaSettings> {
  bool isEnabled = false;

  @override
  void initState() {
    updateUser2FA();
    super.initState();
  }

  updateUser2FA() async {
    isEnabled = await SecureStorageUtils.retrieve2FA();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final userVm = ref.watch(userViewModel);

    return BusyOverlay(
      show: userVm.passwordState == ViewState.busy,
      child: Scaffold(
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
                          "${isEnabled ? "Disable" : "Enable"} 2FA",
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

                        await userVm.update2FA(value: value);
                        if (userVm.passwordState == ViewState.retrieved) {
                          showFlushBar(
                            context: context,
                            message: value
                                ? "2FA Enabled successfully."
                                : "2FA Disabled successfully.",
                          );
                        } else {
                          showFlushBar(
                            context: context,
                            message: userVm.message,
                            success: false,
                          );
                        }
                        // pushNavigation(
                        //   context: context,
                        //   widget: TwoFaPinScreen(),
                        //   routeName: NamedRoutes.twoFaPinScreen,
                        // );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
