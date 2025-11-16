import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/named_routes.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/pages/guarantor/view_guarantor_details.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/listview_items/guarantor_card_item.dart';

class EmployerManageWorkerGuanantor extends StatefulWidget {
  const EmployerManageWorkerGuanantor({super.key});

  @override
  State<EmployerManageWorkerGuanantor> createState() =>
      _EmployerManageWorkerGuanantorState();
}

class _EmployerManageWorkerGuanantorState
    extends State<EmployerManageWorkerGuanantor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: "Manage Guarantor"),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimension.paddingLeft,
          vertical: 16.h,
        ),
        children: [
          ListView.separated(
            itemCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (BuildContext context, int index) {
              return GuarantorCardItem(
                onPressed: () {
                  pushNavigation(
                    context: context,
                    widget: const ViewGuarantorDetails(),
                    routeName: NamedRoutes.viewGuarantorDetails,
                  );
                },
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 16.h);
            },
          ),
        ],
      ),
    );
  }
}
