import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/named_routes.dart';
import 'package:verifysafe/core/data/enum/user_type.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/view_models/authentication_vms/authentication_view_model.dart';
import 'package:verifysafe/core/data/view_models/authentication_vms/onboarding_vms/onboarding_vm.dart';
import 'package:verifysafe/core/utilities/date_utilitites.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/pages/authentication/onboarding/worker/add_work_history.dart';
import 'package:verifysafe/ui/widgets/busy_overlay.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';
import 'package:verifysafe/ui/widgets/show_flush_bar.dart';

import '../../../../../core/constants/app_dimension.dart';
import '../../../../../core/constants/color_path.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_painter/dotted_border.dart';
import '../../../../widgets/screen_title.dart';
import '../../../../widgets/verifysafe_container.dart';

class WorkHistory extends ConsumerStatefulWidget {
  const WorkHistory({super.key});

  @override
  ConsumerState<WorkHistory> createState() => _WorkHistoryState();
}

class _WorkHistoryState extends ConsumerState<WorkHistory> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(onboardingViewModel).workHistory.clear();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authVm = ref.watch(authenticationViewModel);
    final onboardingVm = ref.watch(onboardingViewModel);
    return BusyOverlay(
      show: onboardingVm.state == ViewState.busy,
      child: Scaffold(
        appBar: customAppBar(context: context),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: AppDimension.paddingLeft,
              right: AppDimension.paddingRight,
              bottom: 40.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ScreenTitle(
                          headerText: 'Work History',
                          secondSub: 'add work history below.',
                        ),
                        SizedBox(height: 16.h),
                        ListView.separated(
                          itemCount: onboardingVm.workHistory.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            final historyData = onboardingVm.workHistory[index];
                            bool isPresent =
                                DateUtilities.monthDayYear(
                                  date: DateFormat(
                                    "dd-MM-yyyy",
                                  ).tryParse(historyData.endDate ?? ""),
                                ) ==
                                DateUtilities.monthDayYear(
                                  date: DateTime.now(),
                                );
                            return VerifySafeContainer(
                              bgColor: ColorPath.athensGrey2,
                              border: Border.all(
                                color: ColorPath.athensGrey3,
                                width: 1.w,
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 16.h,
                                horizontal: 16.w,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    historyData.employerName ?? '',
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.textPrimary,
                                        ),
                                  ),
                                  SizedBox(height: 5.h),
                                  Row(
                                    children: [
                                      Text(
                                        historyData.category ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: ColorPath.fiordGrey,
                                            ),
                                      ),
                                      Container(
                                        height: 4.h,
                                        width: 4.w,
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 8.w,
                                        ),
                                        decoration: BoxDecoration(
                                          color: ColorPath.fiordGrey,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      Text(
                                        historyData.jobRole ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: ColorPath.fiordGrey,
                                            ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5.h),
                                  RichText(
                                    textAlign: TextAlign.left,
                                    text: TextSpan(
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: ColorPath.oxfordBlue,
                                          ),
                                      children: [
                                        const TextSpan(text: 'Start Date: '),
                                        TextSpan(
                                          text: DateUtilities.monthDayYear(
                                            date: DateFormat("dd-MM-yyyy")
                                                .tryParse(
                                                  historyData.startDate ?? "",
                                                ),
                                          ),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.text5,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  RichText(
                                    textAlign: TextAlign.left,
                                    text: TextSpan(
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: ColorPath.oxfordBlue,
                                          ),
                                      children: [
                                        const TextSpan(text: 'End Date: '),
                                        TextSpan(
                                          text: isPresent
                                              ? "Present"
                                              : DateUtilities.monthDayYear(
                                                  date: DateFormat("dd-MM-yyyy")
                                                      .tryParse(
                                                        historyData.endDate ??
                                                            "",
                                                      ),
                                                ),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.text5,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                  Clickable(
                                    onPressed: () {
                                      onboardingVm.workHistory.remove(
                                        historyData,
                                      );
                                      setState(() {});
                                    },
                                    child: VerifySafeContainer(
                                      bgColor: ColorPath.fairPink,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 11.h,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Delete',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.textPrimary,
                                                ),
                                          ),
                                          SizedBox(width: 8.w),
                                          CustomAssetViewer(
                                            asset: AppAsset.delete,
                                            height: 20.h,
                                            width: 20.w,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 16.h);
                          },
                        ),
                        SizedBox(height: 16.h),
                        Clickable(
                          onPressed: () {
                            pushNavigation(
                              context: context,
                              widget: const AddWorkHistory(),
                              routeName: NamedRoutes.addWorkHistory,
                            );
                          },
                          child: CustomPaint(
                            painter: DottedBorder(
                              color: ColorPath.bermudaGreen,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.r),
                              ),
                            ),
                            child: VerifySafeContainer(
                              bgColor: Colors.transparent,
                              padding: EdgeInsets.symmetric(
                                vertical: 16.h,
                                horizontal: 16.w,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.r),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    size: 20.w,
                                    color: ColorPath.shamrockGreen,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    'Add experience',
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: ColorPath.shamrockGreen,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                CustomButton(
                  buttonText: 'Continue',
                  onPressed: () async {
                    if (onboardingVm.workHistory.isNotEmpty) {
                      await onboardingVm.createWorkHistory();

                      if (onboardingVm.state == ViewState.retrieved) {
                        //update user onboarding data
                        authVm.authorizationResponse?.onboarding =
                            onboardingVm.userOnboardingData;
                        authVm.updateUI();
                        onboardingVm.handleOnboardingNavigation(
                          context: context,
                          userType:
                              authVm
                                  .authorizationResponse
                                  ?.user
                                  ?.userEnumType ??
                              UserType.worker,
                          currentStep:
                              onboardingVm.userOnboardingData?.currentStep ??
                              '',
                        );
                      } else {
                        showFlushBar(
                          context: context,
                          message: onboardingVm.message,
                          success: false,
                        );
                      }
                    } else {
                      showFlushBar(
                        context: context,
                        message: "Add at least one Work History",
                        success: false,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
