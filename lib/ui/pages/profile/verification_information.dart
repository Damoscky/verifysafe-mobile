import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/data/enum/user_type.dart';
import 'package:verifysafe/core/data/view_models/user_view_model.dart';
import 'package:verifysafe/core/utilities/date_utilitites.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/custom_divider.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';
import 'package:verifysafe/ui/widgets/data_tile.dart';
import 'package:verifysafe/ui/widgets/document_widget.dart';

class VerificationInformation extends ConsumerWidget {
  const VerificationInformation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userVm = ref.watch(userViewModel);
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Verification Information',
        showBottom: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimension.paddingLeft,
          vertical: 16.h,
        ),
        children: [
          DataTile(
            title: "Goverment ID",
            data: userVm.userData?.userEnumType == UserType.worker
                ? userVm.userData?.workerIdentity?.identityName
                          ?.toUpperCase() ??
                      ""
                : userVm.userData?.identity?.identityName?.toUpperCase() ?? "",
          ),
          CustomDivider(verticalSpace: 14),
          Row(
            children: [
              Expanded(
                child: DataTile(
                  title:
                      "${userVm.userData?.userEnumType == UserType.worker ? userVm.userData?.workerIdentity?.identityName?.toUpperCase() : userVm.userData?.identity?.identityName?.toUpperCase()} ID",
                  data: userVm.userData?.userEnumType == UserType.worker
                      ? userVm.userData?.workerIdentity?.identityNumber ?? ""
                      : userVm.userData?.identity?.identityNumber ?? "",
                ),
              ),
              if (userVm.userData?.workerIdentity?.status
                      ?.toLowerCase()
                      .contains("approved") ??
                  false)
                CustomSvg(asset: AppAsset.verificationBadge),
              if (userVm.userData?.identity?.status
                      ?.toLowerCase()
                      .contains("approved") ??
                  false)
                CustomSvg(asset: AppAsset.verificationBadge),
            ],
          ),
          if (userVm.userData?.userEnumType != UserType.worker)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomDivider(verticalSpace: 14),
                DataTile(
                  title: "Incorporation Date",
                  data: DateUtilities.monthDayYear(
                    date: userVm.userData?.identity?.associatedDate,
                  ),
                ),
              ],
            ),

          CustomDivider(verticalSpace: 14),
          DataTile(
            title: "Reviewed by",
            data: userVm.userData?.userEnumType == UserType.worker
                ? userVm.userData?.workerIdentity?.reviewedBy?.name ?? "Awaiting Review"
                : userVm.userData?.identity?.reviewedBy?.name ?? "Awaiting Review",
          ),
          CustomDivider(verticalSpace: 14),
            if (( userVm.userData?.userEnumType == UserType.worker && userVm.userData?.workerIdentity?.identityFileUrl != null) ||   userVm.userData?.identity?.identityFileUrl != null)
          DocumentWidget(
            fileName: userVm.userData?.userEnumType == UserType.worker
                ? userVm.userData?.workerIdentity?.identityFileUrl
                      ?.split('/')
                      .last
                : userVm.userData?.identity?.identityFileUrl?.split('/').last,
            onPressed: () {
          // TODO::: HANDLE DOC VIEWER/DOWNLOAD
            },
          ),
        ],
      ),
    );
  }
}
