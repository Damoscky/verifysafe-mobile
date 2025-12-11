import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/data/view_models/guarantor_view_models/guarantor_view_model.dart';
import 'package:verifysafe/core/utilities/date_utilitites.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/verifysafe_container.dart';
import 'package:verifysafe/ui/widgets/verifysafe_tag.dart';

import '../../../core/constants/named_routes.dart';
import '../../../core/data/models/guarantor.dart';
import '../../../core/utilities/navigator.dart';
import '../../pages/guarantor/view_guarantor_details.dart';

class GuarantorCardItem extends StatelessWidget {
  final void Function()? onPressed;
  final Guarantor guarantor;

  const GuarantorCardItem({super.key, this.onPressed, required this.guarantor});

  @override
  Widget build(BuildContext context) {
    final name = guarantor.name ?? 'N/A';
    final date = DateUtilities.abbrevMonthDayYear(guarantor.requestedAt?.toString() ?? DateTime.now().toString());
    final time = DateUtilities.formatTimeAMPM(dateTime: guarantor.requestedAt ?? DateTime.now());
    final relationship = guarantor.relationship ?? 'N/A';
    final email = guarantor.email ?? 'N/A';
    final address = guarantor.address ?? 'N/A';
    final status = guarantor.status ?? '';

    return Clickable(
      onPressed: onPressed ?? (){
        final container =
        ProviderScope.containerOf(context);

        final vm =
        container.read(guarantorViewModel);
        vm.selectedGuarantor = guarantor;
        pushNavigation(context: context, widget: ViewGuarantorDetails(), routeName: NamedRoutes.viewGuarantorDetails);
      },
      child: VerifySafeContainer(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
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
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.textPrimary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '$date $time',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.text4,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10.w),
                VerifySafeTag(status: status),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Contact',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.text4,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        email,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.text5,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Relationship',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.text4,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        relationship,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.text5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Address',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.text4,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  address,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.text5,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
