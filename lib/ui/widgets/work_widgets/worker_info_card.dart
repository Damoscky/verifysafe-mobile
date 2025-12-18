import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/ui/widgets/display_image.dart';
import 'package:verifysafe/ui/widgets/verifysafe_container.dart';

class WorkerInfoCard extends StatelessWidget {
  final String? image;
  final String? firstName;
  final String? lastName;
  final String? workerID;

  

  const WorkerInfoCard({super.key,this.image,this.firstName,this.lastName,this.workerID});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return VerifySafeContainer(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          DisplayImage(
            image:
                image,
            firstName: firstName ?? "A",
            lastName: lastName ?? "A",
            borderWidth: 2.w,
            size: 64.h,
            borderColor: ColorPath.persianGreen,
          ),
          SizedBox(width: 18.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$firstName $lastName",
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.blackText,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "VerifySafe ID: ",
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.textSecondary,
                      ),
                      children: [
                        TextSpan(
                          text: workerID,
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.text4,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
