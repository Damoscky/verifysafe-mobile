import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/core/utilities/date_utilitites.dart';
// import 'package:verifysafe/core/utilities/extensions/color_extensions.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/custom_button.dart';
import 'package:verifysafe/ui/widgets/display_image.dart';
import 'package:verifysafe/ui/widgets/verifysafe_container.dart';

enum NotificationType { simple, titleAndBody, callToAction }

class Notifications extends ConsumerStatefulWidget {
  const Notifications({super.key});

  @override
  ConsumerState<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends ConsumerState<Notifications> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: "Notification",
        showBottom: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Clickable(
              onPressed: () {
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(100, 100, 0, 0),
                  items: [
                    PopupMenuItem(
                      value: 'clear',
                      child: Text(
                        'Clear Notification',
                        style: textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ).then((value) {
                  if (value != null) {
                    //todo ::: handle clear notification here
                  }
                });
              },
              child: Icon(Icons.more_vert, color: ColorPath.slateGrey),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimension.paddingLeft,
          vertical: 24.h,
        ),
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index1) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today",
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.text4,
                    ),
                  ),
                  SizedBox(height: 16),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index2) {
                      return NotificationItem(
                        notificationType: index1 % 2 == 1
                            ? NotificationType.callToAction
                            : index2 % 2 == 0
                            ? NotificationType.titleAndBody
                            : NotificationType.simple,
                      );
                    },
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 16.h),
                    itemCount: 2,
                  ),
                  SizedBox(height: 12.h),
                  Container(height: 1.sp, color: ColorPath.athensGrey4),
                ],
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 12);
            },
            itemCount: 2,
          ),
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final NotificationType notificationType;
  const NotificationItem({
    super.key,
    this.notificationType = NotificationType.simple,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return VerifySafeContainer(
      padding: notificationType != NotificationType.callToAction
          ? EdgeInsets.zero
          : EdgeInsets.all(16.w),
      bgColor: _handleColor(),
      child: notificationType == NotificationType.callToAction
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                VerifySafeContainer(
                  padding: REdgeInsets.symmetric(
                    vertical: 8.h,
                    horizontal: 16.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "SadeOni Limited",
                        style: textTheme.titleMedium?.copyWith(fontSize: 16.sp),
                      ),
                      DisplayImage(
                        // image: null,
                        image:
                            "https://mir-s3-cdn-cf.behance.net/user/276/888fd91082619909.61d2827bbd7a2.jpg",
                        firstName: "AB",
                        lastName: "CD",
                        size: 32.w,
                        borderWidth: 2.w,
                        borderColor: ColorPath.persianGreen,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  "Dear Folashade,\n\nSisi Oge has requested to be your employer as a nail technician, Lekki Lagos",
                  style: textTheme.titleMedium?.copyWith(fontSize: 16.sp),
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: () {},
                        buttonHeight: 52.h,
                        buttonText: "Accept",
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: CustomButton(
                        onPressed: () {},
                        buttonHeight: 52.h,
                        buttonText: "Decline",
                        buttonTextColor: Colors.black,
                        borderColor: ColorPath.aquamarine,
                        // useBorderColor: true,
                        bgColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  DateUtilities.timeAgo(
                    dateTime: DateTime.now().subtract(Duration(minutes: 10)),
                  ),
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.text5,
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "New worker profile: Onyeka Eze! View profile to see ratings and background checks.",
                  style: textTheme.titleMedium?.copyWith(fontSize: 16.sp),
                ),
                SizedBox(height: 2),
                if (notificationType == NotificationType.titleAndBody)
                  Column(
                    children: [
                      Text(
                        "Please share the reasons for the termination of employment and provide a rating for the employer.",
                        style: textTheme.bodySmall,
                      ),
                      SizedBox(height: 2),
                    ],
                  ),
                Text(
                  DateUtilities.timeAgo(
                    dateTime: DateTime.now().subtract(Duration(minutes: 10)),
                  ),
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.text5,
                  ),
                ),
              ],
            ),
    );
  }

  Color _handleColor() {
    switch (notificationType) {
      case NotificationType.simple:
      case NotificationType.titleAndBody:
        return Colors.transparent;
      case NotificationType.callToAction:
        return ColorPath.athensGrey4;

      // default:
      //   return Colors.transparent;
    }
  }
}
