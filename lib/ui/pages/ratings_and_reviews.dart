import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/ui/widgets/bottom_sheets/view_ratings.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';
import 'package:verifysafe/ui/widgets/verifysafe_container.dart';

import '../../core/constants/color_path.dart';
import '../widgets/bottom_sheets/base_bottom_sheet.dart';
import '../widgets/bottom_sheets/sort_options.dart';
import '../widgets/clickable.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/sort_and_filter_tab.dart';

class RatingsAndReviews extends StatefulWidget {
  const RatingsAndReviews({super.key});

  @override
  State<RatingsAndReviews> createState() => _RatingsAndReviewsState();
}

class _RatingsAndReviewsState extends State<RatingsAndReviews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          context: context,
          title: 'Ratings & Reviews',
          showBottom: true,
          appbarBottomPadding: 10.h,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppDimension.paddingLeft, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VerifySafeContainer(
              bgColor: ColorPath.gulfBlue,
              padding: EdgeInsets.symmetric(
                vertical: 16.h,
                horizontal: 16.w
              ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Reviews',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: ColorPath.chateauGrey
                            ),
                          ),
                          SizedBox(height: 2.h,),
                          Text(
                            '09',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: ColorPath.porcelainGrey
                            ),
                          ),


                              ],
                      ),
                    ),
                    SizedBox(width: 10.w,),
                    CustomAssetViewer(asset: AppAsset.ratingsIllustration, height: 48.h, width: 48.w,)

                  ],
                )
            ),
            SizedBox(height: 16.h,),
            Text(
              'You’re viewing all ratings and reviews below',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textSecondary
              ),
            ),
            SizedBox(height: 16.h,),
            SortAndFilterTab(
                sortOnPressed: (){
                  baseBottomSheet(
                    context: context,
                    content: SortOptions(
                      filterOptions: [
                        'Date',
                        'Ascending',
                        'Descending'
                      ],
                      onSelected: (value){
                        //todo: perform action
                      },
                    ),
                  );
                },
                filterOnPressed: (){
                  //todo: open filter options bottom-sheet
                }),
            SizedBox(height: 16.h,),
            ListView.separated(
              itemCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                return Clickable(
                  onPressed: (){
                    baseBottomSheet(
                      context: context,
                      content: ViewRatings(),
                    );
                  },
                  child: VerifySafeContainer(
                      padding: EdgeInsets.symmetric(
                          vertical: 16.h,
                          horizontal: 16.w
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(16.r)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Jideson & Co.',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: Theme.of(context).colorScheme.textPrimary
                                      ),
                                    ),
                                    SizedBox(height: 4.h,),
                                    Text(
                                      'Domestic Worker',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context).colorScheme.text4
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10.w,),
                              CustomAssetViewer(asset: AppAsset.verificationBadge)

                            ],
                          ),
                          SizedBox(height: 12.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Timestamp',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context).colorScheme.text4
                                      ),
                                    ),
                                    SizedBox(height: 4.h,),
                                    Text(
                                      'Dec 19, 2013',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: Theme.of(context).colorScheme.text5
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 30.w,),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Ratings',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context).colorScheme.text4
                                      ),
                                    ),
                                    SizedBox(height: 4.h,),
                                    RatingBar.builder(
                                      initialRating: 3.5,
                                      unratedColor: ColorPath.athensGrey5,
                                      minRating: 0,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      ignoreGestures: true,
                                      itemSize: 20.h,
                                      itemPadding: EdgeInsets.only(right: 4.w),
                                      itemBuilder: (context, _) => CustomAssetViewer(asset: AppAsset.star),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h,),
                          Text(
                            '1901 Donovan Cir. Shiloh, Tokyo 86563',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.text5
                            ),
                          ),

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
