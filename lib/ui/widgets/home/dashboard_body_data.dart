import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/core/constants/named_routes.dart';
import 'package:verifysafe/core/data/enum/user_type.dart';
import 'package:verifysafe/core/data/view_models/worker_view_model.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/pages/authentication/onboarding/employer/employer_info.dart';
import 'package:verifysafe/ui/pages/authentication/onboarding/worker/basic_info.dart';
import 'package:verifysafe/ui/pages/search.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';
import 'package:verifysafe/ui/widgets/custom_text_field.dart';
import 'package:verifysafe/ui/widgets/home/dashboard_report_card.dart';
import 'package:verifysafe/ui/widgets/home/work_histories_data.dart';
import 'package:verifysafe/ui/widgets/home/workers_data.dart';
import 'package:verifysafe/ui/widgets/screen_title.dart';
import 'package:verifysafe/ui/widgets/verifysafe_container.dart';

class DashboardBodyData extends ConsumerStatefulWidget {
  final UserType userType;
  const DashboardBodyData({super.key, this.userType = UserType.worker});

  @override
  ConsumerState<DashboardBodyData> createState() => _DashboardBodyDataState();
}

class _DashboardBodyDataState extends ConsumerState<DashboardBodyData> {
  @override
  Widget build(BuildContext context) {
    final workerVm = ref.watch(workerViewModel);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.userType != UserType.worker)
          Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w),
            child: Clickable(
              onPressed: () {
                pushNavigation(
                  context: context,
                  widget: Search(),
                  routeName: NamedRoutes.search,
                );
              },
              child: CustomTextField(
                hintText: "Search...",
                onChanged: (value) {},
                enabled: false,
                borderColor: ColorPath.niagaraGreen,
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(CupertinoIcons.search),
                ),
              ),
            ),
          ),
        if (widget.userType == UserType.agency)
          Column(
            children: [
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: Clickable(
                      onPressed: () {
                        //todo::: handle route to add worker
                        pushNavigation(
                          context: context,
                          widget: BasicInfo(),
                          routeName: NamedRoutes.basicInfo,
                        );
                      },
                      child: VerifySafeContainer(
                        bgColor: ColorPath.aquaGreen,
                        border: Border.all(color: ColorPath.gloryGreen),
                        margin: EdgeInsets.only(left: 24.w),
                        padding: EdgeInsets.all(12.h),
                        child: Row(
                          children: [
                            CustomSvg(
                              asset: AppAsset.addWorker,
                              height: 32.h,
                              width: 32.w,
                            ),
                            SizedBox(width: 8.w),
                            Text("Add Worker"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Clickable(
                      onPressed: () {
                        //todo::: handle route to add employer
                        pushNavigation(
                          context: context,
                          widget: EmployerInfo(),
                          routeName: NamedRoutes.employerInfo,
                        );
                      },
                      child: VerifySafeContainer(
                        // bgColor: ColorPath.aquaGreen,
                        border: Border.all(color: ColorPath.athensGrey3),
                        margin: EdgeInsets.only(right: 24.w),
                        padding: EdgeInsets.all(12.h),
                        child: Row(
                          children: [
                            CustomSvg(
                              asset: AppAsset.addEmployer,
                              height: 32.h,
                              width: 32.w,
                            ),
                            SizedBox(width: 8.w),
                            Text("Add Employer"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

        if (widget.userType != UserType.agency)
          Column(
            children: [
              SizedBox(height: 24.h),
              DashboardReportCard(userType: widget.userType),
            ],
          ),

        Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w),
          child: ScreenTitle(
            headerText: bodyHeaderTexts().first,
            secondSub: bodyHeaderTexts().last,
          ),
        ),
        if (widget.userType == UserType.worker)
          WorkHistoriesData(workHistories: workerVm.recentWorkHistory)
        else
          WorkersData(),
      ],
    );
  }

  List<String> bodyHeaderTexts() {
    switch (widget.userType) {
      case UserType.worker:
        return [
          "Recent Work History",
          "Showing all but most recent history below",
        ];
      case UserType.employer:
      case UserType.agency:
        return ["Registered Workers", "Showing all registered workers below"];
    }
  }
}
