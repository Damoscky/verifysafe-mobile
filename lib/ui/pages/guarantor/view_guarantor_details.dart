import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/ui/widgets/details.dart';

import '../../../core/constants/app_asset.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/utilities/navigator.dart';
import '../../../core/utilities/utilities.dart';
import '../../widgets/bottom_sheets/action_completed.dart';
import '../../widgets/bottom_sheets/base_bottom_sheet.dart';
import '../../widgets/clickable.dart';
import '../../widgets/custom_appbar.dart';

class ViewGuarantorDetails extends StatefulWidget {
  const ViewGuarantorDetails({super.key});

  @override
  State<ViewGuarantorDetails> createState() => _ViewGuarantorDetailsState();
}

class _ViewGuarantorDetailsState extends State<ViewGuarantorDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          context: context,
          title: 'Guarantor name',
          showBottom: true,
          appbarBottomPadding: 10.h,
          actions:[
            Padding(
              padding: EdgeInsets.only(right: AppDimension.paddingRight),
              child: Clickable(
                onPressed: (){
                  baseBottomSheet(
                    context: context,
                    content: ActionCompleted(
                      asset: AppAsset.actionConfirmation,
                      title: 'Deactivate',
                      subtitle: 'Are you sure you want to deactivate guarantor’s profile?',
                      buttonText: 'Yes, Deactivate',
                      onPressed: (){
                        popNavigation(context: context);
                      },
                    ),
                  );
                },
                child:  Text(
                  'Deactivate',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.text4
                  ),
                ),
              ),
            )
          ]
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: AppDimension.paddingLeft, right: AppDimension.paddingRight, bottom: 40.h, top: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //todo: waiting on Ayeni(UI) to update the card
            Details(label: 'Request Date', value: 'April 18, 2026'),
            SizedBox(height: 16.h,),
            Details(label: 'Date Accepted', value: 'April 18, 2026'),
            SizedBox(height: 16.h,),
            Details(label: 'Relationship', value: 'Brother'),
            SizedBox(height: 16.h,),
            Details(label: 'Email', value: 'aaa@gmail.com'),
            SizedBox(height: 16.h,),
            Details(label: 'Phone', value: '+234 ${Utilities.formatSavedUserPhoneNumber(phoneNumber: '9021074117')}'),
            SizedBox(height: 16.h,),
            Details(label: 'Country of Residence', value: 'Nigeria'),
            SizedBox(height: 16.h,),
            Details(label: 'State of Residence', value: 'Lagos'),
            SizedBox(height: 16.h,),
            Details(label: 'Local Government Area', value: 'Amuwo'),
            SizedBox(height: 16.h,),
            Details(label: 'Address', value: '14a Karimu Kotun'),
          ],
        ),
      ),
    );
  }
}
