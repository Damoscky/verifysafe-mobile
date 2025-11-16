import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/custom_divider.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';
import 'package:verifysafe/ui/widgets/data_tile.dart';
import 'package:verifysafe/ui/widgets/document_widget.dart';

class VerificationInformation extends StatelessWidget {
  const VerificationInformation({super.key});

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
          DataTile(title: "Goverment ID", data: "NIN"),
          CustomDivider(verticalSpace: 14),
          Row(
            children: [
              Expanded(
                child: DataTile(title: "NIN ID", data: "7397232693"),
              ),
              CustomSvg(asset: AppAsset.verificationBadge),
            ],
          ),
          CustomDivider(verticalSpace: 14),
          DataTile(title: "Reviewed by", data: "Lambert Abiola"),
          CustomDivider(verticalSpace: 14),
          DocumentWidget(),
        ],
      ),
    );
  }
}
