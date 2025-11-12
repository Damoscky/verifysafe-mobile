import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/core/data/enum/user_type.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/custom_text_field.dart';
import 'package:verifysafe/ui/widgets/home/work_histories_data.dart';
import 'package:verifysafe/ui/widgets/sort_and_filter_tab.dart';
import 'package:verifysafe/ui/widgets/work_widgets/employers_dashboard_card.dart';

class Employers extends ConsumerStatefulWidget {
  const Employers({super.key});

  @override
  ConsumerState<Employers> createState() => _EmployersState();
}

class _EmployersState extends ConsumerState<Employers> {
  final UserType userType = UserType.agency;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: customAppBar(
        context: context,
        showLeadingIcon: false,
        title: 'Employer',
        actions: [
          Padding(
            padding: EdgeInsets.only(right:AppDimension.paddingRight),
            child: Clickable(
              onPressed: () {
                //todo::: handle route here
              },
              child: Row(
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 8.w),
                  Text(
                    "Add",
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        showBottom: true,
      ),
      body: ListView(
        // padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 16.h),
        children: [
          EmployersDashboardCard(),
          Padding(
            padding: EdgeInsets.only(left:AppDimension.paddingLeft, right: AppDimension.paddingRight),
            child: CustomTextField(
              hintText: "Search for Employer",
              onChanged: (value) {
                // todo::: handle route to search screen here
              },
              enabled: false,
              borderColor: ColorPath.niagaraGreen,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(CupertinoIcons.search),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimension.paddingLeft),
            child: SortAndFilterTab(
              sortOnPressed: () {},
              filterOnPressed: () {},
            ),
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimension.paddingLeft),
            child: Text(
              "View work history below",
              style: textTheme.bodyMedium?.copyWith(color: colorScheme.text4),
            ),
          ),

          WorkHistoriesData(),
        ],
      ),
    );
  }
}
