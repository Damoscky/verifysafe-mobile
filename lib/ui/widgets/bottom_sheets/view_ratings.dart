import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/utilities/navigator.dart';

import '../../../core/constants/app_asset.dart';
import '../../../core/constants/color_path.dart';
import '../custom_button.dart';
import '../custom_svg.dart';

class ViewRatings extends StatelessWidget {
  const ViewRatings({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 24.h,
        horizontal: 24.w
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
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
                          .titleMedium
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
                          .bodyLarge
                          ?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.text4
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.w,),
              CustomAssetViewer(asset: AppAsset.verificationBadge, height: 40.h, width: 40.w,)

            ],
          ),
          SizedBox(height: 16.h,),
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
          SizedBox(height: 16.h,),
          Text(
            'New to the field but very interested in design and eager to learn. New to the field but very interested in design and eager to learn. New to the field but very interested in design and eager to learn.New to the field but very interested in design and eager to learn.New to the field but very interested in design and eager to learn. New to the field but very interested in design and eager to learn.New to the field but very interested in design and eager to learn.',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.text5
            ),
          ),
          SizedBox(height: 40.h,),
          CustomButton(
              buttonText: 'Done',
              onPressed: (){
                popNavigation(context: context);
              }
          )

        ],
      ),
    );
  }
}
