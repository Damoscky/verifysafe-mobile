import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/named_routes.dart';
import 'package:verifysafe/core/data/view_models/landing_view_model.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/pages/authentication/login.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';
import '../../core/constants/color_path.dart';
import '../widgets/custom_dot.dart';

class Landing extends ConsumerStatefulWidget {
  const Landing({super.key});

  @override
  ConsumerState<Landing> createState() => _LandingState();
}

class _LandingState extends ConsumerState<Landing> {
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(landingViewModel);


    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Theme.of(context).colorScheme.whiteText,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Swiper(
                    autoplay: false,
                    autoplayDisableOnInteraction: true,
                    loop: false,
                    controller: vm.swiperController,
                    itemCount: vm.images.length,
                    scale: 0.8,
                    duration: 1000,
                    autoplayDelay: 3000,
                    fade: 1,
                    curve: Curves.easeInOut,
                    itemHeight: double.infinity,
                    itemWidth: double.infinity,
                    onIndexChanged: (index) => vm.updateIndex(index),
                    itemBuilder: (BuildContext context, int index) {
                      return CustomAssetViewer(
                        asset: vm.images[index],
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  Positioned(
                    right: 46.w,
                    top: 10.h,
                    child: SafeArea(
                      child: Clickable(
                        onPressed: (){
                          replaceNavigation(context: context, widget: const Login(), routeName: NamedRoutes.login);
                        },
                        child: Text(
                          'Skip',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: ColorPath.troutGrey
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: AppDimension.paddingLeft,
                right: AppDimension.paddingRight,
                bottom: 64.h,
                top: 24.h
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IntrinsicWidth(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            vm.titles[vm.currentIndex],
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).colorScheme.textPrimary
                            ),
                          ),
                          SizedBox(height: 8.h,),
                          Container(
                            height: 1.h,
                            color: Theme.of(context).colorScheme.textTertiary,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h,),
                  Text(
                    vm.subtitles[vm.currentIndex],
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
                        fontWeight: FontWeight.w400,
                        height: 1.5.h,
                        color: Theme.of(context).colorScheme.textSecondary
                    ),
                  ),
                  SizedBox(height: 52.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                            vm.images.length,
                                (index) => CustomDot(
                              isActive: vm.currentIndex == index,
                            )),
                      ),
                      Clickable(
                        onPressed: (){
                          if(vm.currentIndex == 2){
                            replaceNavigation(context: context, widget: const Login(), routeName: NamedRoutes.login);
                            return;
                          }
                          vm.moveToNext();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 16.h,
                            horizontal: 16.w,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.brandColor,
                            borderRadius: BorderRadius.all(Radius.circular(16.r))
                          ),
                          child: Center(
                            child: CustomAssetViewer(
                                asset: AppAsset.forwardArrow,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),


          ],
        ),
      ),
    );

  }
}
