import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';

import '../../core/data/enum/tag_type.dart';
import '../../core/utilities/utilities.dart';

class VerifySafeTag extends StatelessWidget {
  final String status;
  const VerifySafeTag({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: _statusContainerColor(status: status),
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
      ),
      child:Center(
        child: Text(
          _statusText(status: status),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: _statusTextColor(status: status),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Color _statusContainerColor({required String status}) {
    switch (status.toLowerCase()) {
      case 'accepted':
      case 'completed':
        return ColorPath.foamGreen;
      case 'pending':
      case 'in-progress':
        return ColorPath.dawnYellow;//dawnBrown
      case 'failed':
      case 'rejected':
        return ColorPath.athensGrey2;
      default:
        return Colors.white;
    }
  }

  //returns status color
 Color _statusTextColor({required String status}) {
    switch (status.toLowerCase()) {
      case 'accepted':
      case 'completed':
        return ColorPath.funGreen;
      case 'pending':
      case 'in-progress':
        return ColorPath.vesuBrown;
      case 'failed':
      case 'rejected':
        return ColorPath.athensGrey2;
      default:
        return Colors.white;
    }
  }

  String _statusText({required String? status}) {
    if (status == null) return '';
    return status.isEmpty ? 'N/A' : Utilities.capitalizeWord(status);
  }
}
