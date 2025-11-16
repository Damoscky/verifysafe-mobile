import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';
import 'package:verifysafe/ui/widgets/empty_state.dart';
import 'package:verifysafe/ui/widgets/verifysafe_container.dart';

import '../../core/constants/app_asset.dart';
import '../../core/constants/color_path.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_button.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimension.paddingLeft),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textPrimary,
                ),
                onChanged: (value){},
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  errorText: null,
                  errorMaxLines: 1,
                  errorStyle: const TextStyle(height: 0, fontSize: 0),
                  hintText: 'Search',
                  hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.textFieldHint
                  ),
                 prefixIcon: Padding(
                   padding: EdgeInsets.only(left: 14.w),
                   child: CustomAssetViewer(
                     asset:AppAsset.search,
                     height: 16.h,
                     width: 16.w,
                   ),
                 ),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(right: 14.w),
                    child: CustomAssetViewer(
                      asset:AppAsset.close,
                      height: 16.h,
                      width: 16.w,
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints(
                    minWidth: 16.w,
                    minHeight: 16.h,
                  ),
                  suffixIconConstraints: BoxConstraints(
                    minWidth: 16.w,
                    minHeight: 16.h,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  contentPadding: EdgeInsets.only(left: 14.w, right: 14.w, top: 10.h, bottom: 10.h),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color:  Theme.of(context).colorScheme.textPrimary, width: 1.w),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:  Theme.of(context).colorScheme.textPrimary, width: 1.w),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.textPrimary, width: 0.5.w)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color:  Theme.of(context).colorScheme.textPrimary, width: 1.w)),
                )),
            SizedBox(height: 29.h,),
            recentSearch()


          ],
        ),
      ),
    );
  }

  recentSearch(){
    if(1 + 1 == 3){
      return Padding(
        padding:EdgeInsets.only(top: 40.h),
        child: EmptyState(
            asset: AppAsset.searchEmptyState,
            assetHeight: 106.49.h,
            assetWidth: 123.34.w,
            useBgCard: false,
            title: 'No results found',
            subtitle: 'Search a different keyword.',
          showCtaButton: false,
        ),
      );
    }
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Your recent searches',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.textPrimary
                ),
              ),
              SizedBox(width: 8.w,),
              CustomAssetViewer(asset: AppAsset.clock, height: 16.h, width: 16.w,)
            ],
          ),
          SizedBox(height: 16.h,),
          Expanded(
            child:  ListView.separated(
              itemCount: 4,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child:  Text(
                        'Chukwudi Obi',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.textPrimary,
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w,),
                    Clickable(
                      onPressed:(){},
                        child: CustomAssetViewer(asset: AppAsset.close, height: 16.h, width: 16.w,))
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 16.h,);
              },
            ),
          )
        ],
      ),
    );
  }

  searchResults(){
    return Expanded(
      child:  ListView.separated(
        itemCount: 1,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          return VerifySafeContainer(
            bgColor: ColorPath.athensGrey5,
            padding: EdgeInsets.symmetric(
              vertical: 16.h,
              horizontal: 16.w
            ),
              border: Border.all(color: ColorPath.mysticGrey, width: 1.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Jideson Kosoko',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.textPrimary
                              ),
                            ),
                            SizedBox(height: 2.h,),
                            Text(
                              'ID: 1190',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).colorScheme.text5
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10.w,),
                      CustomAssetViewer(asset: AppAsset.searchFound, height: 45.h, width: 45.w,)

                    ],
                  ),
                  SizedBox(height: 16.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Male',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.textPrimary
                              ),
                            ),
                            SizedBox(height: 2.h,),
                            Text(
                              'DOB: February 28, 1999',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).colorScheme.text5
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10.w,),
                      CustomButton(
                        buttonWidth: null,
                          useBorderColor: true,
                          borderRadius: 16.r,
                          borderColor: ColorPath.shamrockGreen,
                          buttonHorizontalPadding: 16.w,
                          buttonTextColor: Theme.of(context).colorScheme.textPrimary,
                          buttonText: 'View Profile',
                          onPressed: (){

                          }
                      )

                    ],
                  ),


                ],
              ));
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 16.h,);
        },
      ),
    );
  }
}
