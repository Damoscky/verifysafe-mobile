import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/data/models/user.dart';
import 'package:verifysafe/core/utilities/utilities.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/data_tile.dart';

class ViewContactPerson extends StatelessWidget {
  final User data;
  final bool canEdit;
  const ViewContactPerson({super.key, required this.data, this.canEdit = true});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: "Contact Person",
        //todo:: confirm if contact person is editable as BE did not provide
        // actions: [
        //   if (canEdit)
        //     Padding(
        //       padding: EdgeInsets.only(right: 24.w),
        //       child: Clickable(
        //         onPressed: () {
        //           pushNavigation(
        //             context: context,
        //             widget: ContactPerson(),
        //             routeName: NamedRoutes.contactPerson,
        //           );
        //         },
        //         child: Text(
        //           "Edit",
        //           style: textTheme.bodyMedium?.copyWith(
        //             fontWeight: FontWeight.w700,
        //             color: ColorPath.meadowGreen,
        //           ),
        //         ),
        //       ),
        //     ),
        // ],
        showBottom: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimension.paddingLeft,
          vertical: 16.h,
        ),
        children: [
          Text(
            "Contact Person Information",
            style: textTheme.bodyMedium?.copyWith(color: colorScheme.text4),
          ),
          SizedBox(height: 16.h),
          DataTile(
            title: "Name",
            data: data.employer?.contactPerson != null && (data.employer?.contactPerson?.isNotEmpty ?? false) ? data.employer?.parseContactPerson()['name'] ?? "" : "N/A",
          ),
          SizedBox(height: 16.h),
          DataTile(
            title: "Position",
            data:data.employer?.contactPerson != null && (data.employer?.contactPerson?.isNotEmpty ?? false) ?  data.employer?.parseContactPerson()['role'] ?? "" : "N/A",
          ),
          SizedBox(height: 16.h),
          DataTile(
            title: "Phone Number",
            data:data.employer?.contactPerson != null && (data.employer?.contactPerson?.isNotEmpty ?? false) ?  Utilities.formatPhoneWithCode(
              phoneNumber: data.employer?.parseContactPerson()['phone'] ?? "",
            ) : "N/A",
          ),

          SizedBox(height: 16.h),
          DataTile(
            title: "Email Address",
            data:data.employer?.contactPerson != null && (data.employer?.contactPerson?.isNotEmpty ?? false) ?  data.employer?.parseContactPerson()['email'] ?? "" : "N/A",
          ),
        ],
      ),
    );
  }
}
