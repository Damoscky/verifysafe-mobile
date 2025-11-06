import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/data/view_models/authentication_vms/onboarding_vms/onboarding_vm.dart';

class StepCounter extends ConsumerWidget {
  final String currentStep;
  const StepCounter({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.read(onboardingViewModel);
    return Row(
      children: [
        Text(
          'Step',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.textSecondary
          ),
        ),
        SizedBox(width: 16.w,),
        Text(
          '${vm.currentStep(name: currentStep)} of ${vm.totalSteps()}',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.textPrimary
          ),
        ),

      ],
    );
  }
}
