import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/data/models/user.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/custom_divider.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';
import 'package:verifysafe/ui/widgets/data_tile.dart';
import 'package:verifysafe/ui/widgets/document_widget.dart';

class ViewWorkerVerificationInfo extends StatelessWidget {
  final User workerData;

  const ViewWorkerVerificationInfo({super.key, required this.workerData});

  @override
  Widget build(BuildContext context) {
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
            data:
                workerData.workerIdentity?.identityName?.toUpperCase() ?? "N/A",
          ),
          CustomDivider(verticalSpace: 14),
          Row(
            children: [
              Expanded(
                child: DataTile(
                  title:
                      "${workerData.workerIdentity?.identityName?.toUpperCase() ?? "Document"} ID",
                  data: workerData.workerIdentity?.identityNumber ?? "N/A",
                ),
              ),
              if (workerData.workerIdentity?.status?.toLowerCase().contains(
                    "approved",
                  ) ??
                  false)
                CustomSvg(asset: AppAsset.verificationBadge),
            ],
          ),

          CustomDivider(verticalSpace: 14),
          DataTile(
            title: "Reviewed by",
            data: workerData.workerIdentity?.reviewedBy?.name ?? "N/A",
          ),
          CustomDivider(verticalSpace: 14),
          // TODO::: HANDLE DOC VIEWER/DOWNLOAD
          if (workerData.workerIdentity?.identityFileUrl != null)
            DocumentWidget(
              fileName: workerData.workerIdentity?.identityFileUrl
                  ?.split('/')
                  .last,
              onPressed: () {},
            ),
        ],
      ),
    );
  }
}
