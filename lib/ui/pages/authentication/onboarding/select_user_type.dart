import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/named_routes.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/pages/authentication/onboarding/agency/agency_info.dart';
import 'package:verifysafe/ui/pages/authentication/onboarding/employer/employer_info.dart';
import 'package:verifysafe/ui/pages/authentication/onboarding/worker/basic_info.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';
import 'package:verifysafe/ui/widgets/verifysafe_container.dart';

import '../../../../core/constants/app_dimension.dart';
import '../../../../core/constants/color_path.dart';
import '../../../../core/data/view_models/authentication_vms/onboarding_vms/onboarding_vm.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/screen_title.dart';

class SelectUserType extends ConsumerStatefulWidget {
  const SelectUserType({super.key});

  @override
  ConsumerState<SelectUserType> createState() => _SelectUserTypeState();
}

class _SelectUserTypeState extends ConsumerState<SelectUserType> {
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(onboardingViewModel);
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
              firstSub: 'Join VerifySafe in few steps',
              headerText: 'Sign up with email',
            ),
            SizedBox(height: 24.h,),
            Text(
              'Sign up as a',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.text5
              ),
            ),
            SizedBox(height: 10.h,),
            ListView.separated(
              itemCount: vm.titles.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                final isSelected = index == vm.userType;
                final title = vm.titles[index];
                final subtitle = vm.subtitles[index];
                final asset = vm.assets[index];
                return Clickable(
                  onPressed: (){
                    vm.userType = index;

                    // if(vm.userType == 0){
                      //nav to basic info
                      pushNavigation(context: context, widget: const BasicInfo(), routeName: NamedRoutes.basicInfo);
                      return;
                    // }

                    // if(vm.userType == 1){
                    //   //nav to agency info
                    //   pushNavigation(context: context, widget: const AgencyInfo(), routeName: NamedRoutes.agencyInfo);
                    //   return;
                    // }

                    // //nav to employer info
                    // pushNavigation(context: context, widget: const EmployerInfo(), routeName: NamedRoutes.employerInfo);

                  },
                  child: VerifySafeContainer(
                    padding: EdgeInsets.symmetric(
                      vertical: 16.h,
                      horizontal: 16.w
                    ),
                      bgColor: isSelected ? ColorPath.clearGreen:Theme.of(context).colorScheme.onboardingContainerBg,
                      border: Border.all(
                        color: isSelected ? ColorPath.shamrockGreen:Theme.of(context).colorScheme.onboardingContainerBorder
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 48.h,
                            width: 48.w,
                            decoration: BoxDecoration(
                              color: isSelected ? ColorPath.mintGreen:Theme.of(context).colorScheme.assetBg,
                              borderRadius: BorderRadius.all(Radius.circular(8.r))
                            ),
                            child: Center(
                              child: CustomAssetViewer(
                                  asset: asset,
                                height: 32.h,
                                width: 32.w,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).colorScheme.textPrimary
                                  ),
                                ),
                                Text(
                                  subtitle,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).colorScheme.text4
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 16.h,);
              },
            )


          ],
        ),
      ),
    );
  }
}
