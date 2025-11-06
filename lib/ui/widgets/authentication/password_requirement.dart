import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';
import '../../../core/data/view_models/authentication_vms/password_vm.dart';

class PasswordRequirement extends ConsumerWidget {
  const PasswordRequirement({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(passwordViewModel);
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(top: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Password Strength:',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
                fontWeight: FontWeight.w400,
                color: colorScheme.text5
            ),
          ),
          SizedBox(height: 16.h,),
          ListView.separated(
            itemCount: vm.results.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (BuildContext context, int index) {
              final requirement = vm.pwdRequirements[index];
              final isVerified = vm.results[index];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomAssetViewer(
                    asset: AppAsset.passwordCheckmark,
                    height: 16.h,
                    width: 16.w,
                    colorFilter: ColorFilter.mode(
                      isVerified ? ColorPath.meadowGreen : colorScheme.pwdInactive,
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: 8.w,),
                  Expanded(
                    child:  Text(
                      requirement,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: isVerified ? ColorPath.meadowGreen : colorScheme.pwdInactive,
                      ),
                    ),
                  )
                ],
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 16.h,);
            },
          )
        ],
      ),
    );
  }
}
