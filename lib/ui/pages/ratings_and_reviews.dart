import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/data/view_models/review_view_model.dart';
import 'package:verifysafe/ui/widgets/bottom_sheets/filters/review_filter_options.dart';
import 'package:verifysafe/ui/widgets/bottom_sheets/view_ratings.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';
import 'package:verifysafe/ui/widgets/verifysafe_container.dart';

import '../../core/constants/color_path.dart';
import '../../core/data/enum/view_state.dart';
import '../../core/utilities/date_utilitites.dart';
import '../../core/utilities/utilities.dart';
import '../widgets/app_loader.dart';
import '../widgets/bottom_sheets/base_bottom_sheet.dart';
import '../widgets/bottom_sheets/sort_options.dart';
import '../widgets/clickable.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/empty_state.dart';
import '../widgets/error_state.dart';
import '../widgets/sort_and_filter_tab.dart';

class RatingsAndReviews extends ConsumerStatefulWidget {
  const RatingsAndReviews({super.key});

  @override
  ConsumerState<RatingsAndReviews> createState() => _RatingsAndReviewsState();
}

class _RatingsAndReviewsState extends ConsumerState<RatingsAndReviews> {

  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController= ScrollController();
    final vm = ref.read(reviewViewModel);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      vm.fetchRatings();
    });
    _scrollListener(vm);
    super.initState();
  }

  _scrollListener(ReviewViewModel vm) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //check paginated state
        if(vm.paginatedState != ViewState.error){
          //check if data is not being currently fetched and also check total records
          if (vm.paginatedState != ViewState.busy && vm.sortedReviews.length < vm.totalRecords) {
            //fetch more ratings/reviews
            vm.fetchRatings(
                firstCall: false
            );
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(reviewViewModel);
    return Scaffold(
      appBar: customAppBar(
          context: context,
          title: 'Ratings & Reviews',
          showBottom: true,
          appbarBottomPadding: 10.h,
      ),
      body: Builder(
        builder: (context) {
          if(vm.state == ViewState.busy){
            return Center(
              child: AppLoader(),
            );
          }

          if(vm.state == ViewState.retrieved){
            return SingleChildScrollView(
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
                                  Utilities.formatAmount(
                                    addDecimal: false,
                                    amount: vm.ratingStats?.total?.toDouble()),
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
                            initialValue: vm.selectedSortOption,
                            filterOptions: [
                              'Ascending',
                              'Descending'
                            ],
                            onSelected: (value){
                              vm.sortReviewList(value);
                            },
                          ),
                        );
                      },
                      filterOnPressed: (){
                        baseBottomSheet(
                          context: context,
                          content: ReviewFilterOptions(

                          ),
                        );
                      }),
                  SizedBox(height: 16.h,),
                  if(vm.sortedReviews.isEmpty)EmptyState(
                    asset: AppAsset.empty,
                    useBgCard: false,
                    assetHeight: 200.h,
                    title: "No Ratings yet",
                    subtitle: "",
                    showCtaButton: false,
                  )
                  else ListView.separated(
                    controller: _scrollController,
                    itemCount: vm.sortedReviews.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int index) {
                      final review = vm.sortedReviews[index];
                      final name = review.name ?? 'N/A';
                      final job = review.jobType ?? 'N/A';
                      final date = DateUtilities.abbrevMonthDayYear(review.date?.toString() ?? DateTime.now().toString());
                      final rating = double.tryParse(review.rating?.toString() ??'0') ?? 0;
                      final feedback = review.feedback ?? 'N/A';
                      final isVerified = review.status?.toLowerCase() == 'verified';

                      return Clickable(
                        onPressed: (){
                          vm.selectedReview = review;
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
                                            name,
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
                                            job,
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
                                    if(isVerified)CustomAssetViewer(asset: AppAsset.verificationBadge)

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
                                            date,
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
                                            initialRating: rating,
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
                                  feedback,
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
                  ),
                  if(vm.paginatedState == ViewState.busy)
                    Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: Align(
                        alignment: Alignment.center,
                        child: AppLoader(
                          size: 16,
                        ),
                      ),
                    ),
                  if(vm.paginatedState == ViewState.error)
                    ErrorState(
                        message: vm.message,
                        isPaginationType: true,
                        onPressed: ()=>vm.fetchRatings(
                            firstCall: false,
                            withFilters: vm.selectedFilterOptions.isNotEmpty
                        ))
                ],
              ),
            );
          }

          if(vm.state == ViewState.error){
            return Center(
              child: ErrorState(
                  message: vm.message,
                  onPressed: ()=>vm.fetchRatings()),
            );
          }

          return const SizedBox.shrink();

        }
      ),
    );
  }
}
