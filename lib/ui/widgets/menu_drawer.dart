import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/core/constants/named_routes.dart';
import 'package:verifysafe/core/data/enum/user_type.dart';
import 'package:verifysafe/core/data/view_models/user_view_model.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/pages/billing/bill_type.dart';
import 'package:verifysafe/ui/pages/guarantor/manage_guarantor.dart';
import 'package:verifysafe/ui/pages/profile/settings/rate_app.dart';
import 'package:verifysafe/ui/pages/profile/settings/terms_and_condition.dart';
import 'package:verifysafe/ui/pages/ratings_and_reviews.dart';
import 'package:verifysafe/ui/pages/support_and_misconducts/support_and_misconducts.dart';
import 'package:verifysafe/ui/widgets/display_image.dart';
import 'package:verifysafe/ui/widgets/menu_item.dart';

class MenuDrawer extends ConsumerWidget {
  final UserType userType;
  const MenuDrawer({super.key, this.userType = UserType.worker});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final vm = ref.watch(userViewModel);
    return Drawer(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      backgroundColor: Colors.white,
      width: MediaQuery.of(context).size.width / 1.4.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 40.h,
                      left: 16.w,
                      right: 16.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DisplayImage(
                          // image: null,
                          image: vm.avatar,
                          firstName: vm.firstName,
                          size: 72,
                          lastName: vm.lastName,
                          borderWidth: 2.w,
                          borderColor: ColorPath.persianGreen,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          vm.userData?.name ?? '',
                          style: textTheme.titleMedium,
                        ),
                        // SizedBox(height: 4.h),
                        // Text("@sadeoni"),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 1.h,
                    color: ColorPath.stormGrey.withValues(alpha: .3),
                    margin: EdgeInsets.only(top: 8.h, bottom: 40.h),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(left: 16.w, right: 16.w),
                      child: SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MenuItem(
                              title: "Ratings & Reviews",
                              asset: AppAsset.ratings,
                              onPressed: () {
                                pushNavigation(
                                  context: context,
                                  widget: RatingsAndReviews(),
                                  routeName: NamedRoutes.ratingsAndReviews,
                                );
                              },
                            ),
                            SizedBox(height: 24.h),
                            if (userType != UserType.worker)
                              Column(
                                children: [
                                  MenuItem(
                                    title: "Billing & Payment",
                                    asset: AppAsset.billing,
                                    onPressed: () {
                                      pushNavigation(
                                        context: context,
                                        widget: BillType(),
                                        routeName: NamedRoutes.billType,
                                      );
                                    },
                                  ),
                                  SizedBox(height: 24.h),
                                  MenuItem(
                                    title: "Manage Guarantors",
                                    asset: AppAsset.manage,
                                    onPressed: () {
                                      pushNavigation(
                                        context: context,
                                        widget: ManageGuarantor(),
                                        routeName: NamedRoutes.manageGuarantor,
                                      );
                                    },
                                  ),
                                  SizedBox(height: 24.h),
                                ],
                              ),
                            MenuItem(
                              title: "Support & Misconducts",
                              asset: AppAsset.support,
                              onPressed: () {
                                pushNavigation(
                                  context: context,
                                  widget: SupportAndMisconducts(),
                                  routeName: NamedRoutes.supportAndMisconducts,
                                );
                              },
                            ),
                            SizedBox(height: 24.h),
                            if (userType == UserType.worker)
                              Column(
                                children: [
                                  MenuItem(
                                    title: "Manage Guarantors",
                                    asset: AppAsset.guarantor,
                                    onPressed: () {
                                      pushNavigation(
                                        context: context,
                                        widget: ManageGuarantor(),
                                        routeName: NamedRoutes.manageGuarantor,
                                      );
                                    },
                                  ),
                                  SizedBox(height: 24.h),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 1.h,
                    color: ColorPath.stormGrey.withValues(alpha: .3),
                    margin: EdgeInsets.only(top: 8.h, bottom: 40.h),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MenuItem(
                          title: "Rate the VerifySafe app",
                          asset: AppAsset.rateApp,
                          onPressed: () {
                            pushNavigation(
                              context: context,
                              widget: RateApp(),
                              routeName: NamedRoutes.rateApp,
                            );
                          },
                        ),
                        SizedBox(height: 24.h),
                        MenuItem(
                          title: "Share your  feedback",
                          asset: AppAsset.feedback,
                          onPressed: () {
                            pushNavigation(
                              context: context,
                              widget: RateApp(),
                              routeName: NamedRoutes.rateApp,
                            );
                          },
                        ),
                        SizedBox(height: 24.h),
                        MenuItem(
                          title: "Terms & Conditions",
                          asset: AppAsset.tandc,
                          onPressed: () {
                            pushNavigation(
                              context: context,
                              widget: TermsAndCondition(),
                              routeName: NamedRoutes.termsAndCondition,
                            );
                          },
                        ),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
