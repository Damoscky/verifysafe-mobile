import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/core/constants/named_routes.dart';
import 'package:verifysafe/core/data/models/user.dart';
import 'package:verifysafe/core/utilities/date_utilitites.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/ui/pages/workers/view_worker.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/display_image.dart';
import 'package:verifysafe/ui/widgets/verifysafe_container.dart';
import 'package:verifysafe/ui/widgets/verifysafe_tag.dart';

class WorkerDataItem extends StatelessWidget {
  final User workerData;
  const WorkerDataItem({super.key, required this.workerData});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Clickable(
      onPressed: () {
        pushNavigation(
          context: context,
          widget: ViewWorker(workerData: workerData,),
          routeName: NamedRoutes.viewWorker,
        );
      },
      child: VerifySafeContainer(
        padding: EdgeInsets.all(16.w),
        borderRadius: BorderRadius.circular(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        workerData.name ?? "",
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "ID: ${workerData.workerId ?? workerData.employer?.employerId ?? "---"}",
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.text4,
                              fontSize: 10.sp,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Icon(
                              Icons.circle,
                              color: colorScheme.text4,
                              size: 6,
                            ),
                          ),
                          Text(
                            "${DateUtilities.monthDayYear(date: workerData.workerInfo?.createdAt)} ${DateUtilities.time(date: DateTime.now().toUtc())}",
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.text4,
                              fontSize: 10.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                DisplayImage(
                  image: workerData.avatar,
                  // image:
                  //     "https://mir-s3-cdn-cf.behance.net/user/276/888fd91082619909.61d2827bbd7a2.jpg",
                  firstName: workerData.name?.split(" ").first ?? "",
                  lastName: workerData.name?.split(" ").last ?? "",
                  borderWidth: 2.w,
                  borderColor: ColorPath.athensGrey4,
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Job Type:",
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.text4,
                        ),
                      ),
                      Text(
                        workerData.workerInfo?.jobRole ?? "N/A",
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.blackText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Status:",
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.text4,
                        ),
                      ),
                      VerifySafeTag(status: workerData.workerStatus ?? "N/A"),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email:",
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.text4,
                        ),
                      ),
                      Text(
                        workerData.email?.toLowerCase() ?? "",
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.blackText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                if (workerData.employer != null)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: "From: ",
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.text4,
                            ),
                            children: [
                              TextSpan(
                                text: DateUtilities.monthDayYear(
                                  date: workerData.employer?.startDate,
                                ),
                                style: textTheme.bodySmall?.copyWith(
                                  color: colorScheme.blackText,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            text: "To: ",
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.text4,
                            ),
                            children: [
                              workerData.employer?.endDate != null
                                  ? TextSpan(
                                      text: DateUtilities.monthDayYear(
                                        date:
                                            workerData.employer?.endDate ??
                                            DateTime.now(),
                                      ),
                                      style: textTheme.bodySmall?.copyWith(
                                        color: colorScheme.blackText,
                                      ),
                                    )
                                  : TextSpan(
                                      text: "Present",
                                      style: textTheme.bodySmall?.copyWith(
                                        color: ColorPath.niagaraGreen,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ],
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
