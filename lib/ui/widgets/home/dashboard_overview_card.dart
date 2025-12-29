import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/core/data/enum/user_type.dart';
import 'package:verifysafe/core/data/view_models/agency_view_model.dart';
import 'package:verifysafe/core/data/view_models/employer_view_model.dart';
import 'package:verifysafe/core/data/view_models/worker_view_model.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';
import 'package:verifysafe/ui/widgets/verifysafe_container.dart';

class DashboardOverviewCard extends ConsumerStatefulWidget {
  final UserType userType;
  const DashboardOverviewCard({super.key, this.userType = UserType.worker});

  @override
  ConsumerState<DashboardOverviewCard> createState() =>
      _DashboardOverviewCardState();
}

class _DashboardOverviewCardState extends ConsumerState<DashboardOverviewCard> {
  @override
  Widget build(BuildContext context) {
    // final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return VerifySafeContainer(
      padding: EdgeInsets.all(16.w),
      border: Border.all(color: ColorPath.mysticGrey.withValues(alpha: .1)),
      borderRadius: BorderRadius.circular(16.r),
      gradient: LinearGradient(
        begin: AlignmentDirectional.topCenter,
        end: AlignmentDirectional.bottomCenter,

        colors: [
          ColorPath.tangaroa.withValues(alpha: .3),
          ColorPath.congressBlue.withValues(alpha: .3),
        ],
      ),
      child: Column(
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
                      overviewText(),

                      style: textTheme.bodyMedium?.copyWith(
                        color: ColorPath.chateauGrey,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    FittedBox(
                      child: Text(
                        first(),
                        style: textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20.w),
              CustomSvg(asset: AppAsset.employmentIcon, height: 50.h),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: OverviewInfoCard(
                  title: overviewTexts().first,
                  data: second(),
                  asset: overviewAssets().first,
                  color: overviewColors().first,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: OverviewInfoCard(
                  title: overviewTexts().last,
                  data: third(),
                  color: overviewColors().last,
                  asset: overviewAssets().last,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String first() {
    final workerVm = ref.watch(workerViewModel);
    final employerVm = ref.watch(employerViewModel);
    final agencyVm = ref.watch(agencyViewModel);

    switch (widget.userType) {
      case UserType.worker:
        return workerVm.dashboardStats?.total?.toString() ?? "0";
      case UserType.employer:
        return employerVm.employerStats?.total?.toString() ?? "0";
      case UserType.agency:
        return agencyVm.totalRegistration;
    }
  }

  String second() {
    final workerVm = ref.watch(workerViewModel);
    final employerVm = ref.watch(employerViewModel);
    final agencyVm = ref.watch(agencyViewModel);

    switch (widget.userType) {
      case UserType.worker:
        return workerVm.dashboardStats?.previous?.toString() ?? "0";
      case UserType.employer:
        return employerVm.employerStats?.active?.toString() ?? "0";
      case UserType.agency:
        return agencyVm.registeredEmployers;
    }
  }

  String third() {
    final workerVm = ref.watch(workerViewModel);
    final employerVm = ref.watch(employerViewModel);
    final agencyVm = ref.watch(agencyViewModel);

    switch (widget.userType) {
      case UserType.worker:
        return workerVm.dashboardStats?.current?.toString() ?? "0";
      case UserType.employer:
        return employerVm.employerStats?.past?.toString() ?? "0";
      case UserType.agency:
        return agencyVm.registeredWorkers;
    }
  }

  String overviewText() {
    switch (widget.userType) {
      case UserType.worker:
        return "Total No. of Employment";
      case UserType.employer:
        return "Total No. of Workers";

      case UserType.agency:
        return "Total Registration";
    }
  }

  List<String> overviewTexts() {
    switch (widget.userType) {
      case UserType.worker:
        return ["Past Jobs", "Present Jobs"];
      case UserType.employer:
        return ["Active Workers", "Past Workers"];
      case UserType.agency:
        return ["Registered Employers", "Registered Workers"];
    }
  }

  List<String> overviewAssets() {
    switch (widget.userType) {
      case UserType.worker:
      case UserType.agency:
        return [AppAsset.circularDB, AppAsset.circularDoc];
      case UserType.employer:
        return [AppAsset.circularDoc, AppAsset.circularDB];
    }
  }

  List<Color> overviewColors() {
    switch (widget.userType) {
      case UserType.worker:
      case UserType.agency:
        return [ColorPath.milanoRed, ColorPath.funGreen];
      case UserType.employer:
        return [ColorPath.funGreen, ColorPath.milanoRed];
    }
  }
}

//SUB WIDGETS
class OverviewInfoCard extends StatelessWidget {
  final String? title;
  final String? data;
  final String asset;
  final Color color;
  const OverviewInfoCard({
    super.key,
    this.title,
    this.data,
    this.asset = AppAsset.circularDoc,
    this.color = ColorPath.funGreen,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return VerifySafeContainer(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
      borderRadius: BorderRadius.circular(16.r),
      // color: ColorPath.aquamarine,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title ?? "",
                  style: textTheme.bodyMedium?.copyWith(
                    color: ColorPath.paleGrey,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              CustomSvg(asset: asset),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            data ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.titleSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
