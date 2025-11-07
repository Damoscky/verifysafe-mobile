import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';

import '../../../../core/constants/app_dimension.dart';
import '../../../../core/constants/color_path.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';

class BiometricsSetup extends StatefulWidget {
  const BiometricsSetup({super.key});

  @override
  State<BiometricsSetup> createState() => _BiometricsSetupState();
}

class _BiometricsSetupState extends State<BiometricsSetup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: AppDimension.paddingLeft, right: AppDimension.paddingRight, top: 74.h),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              CustomAssetViewer(asset: AppAsset.biometricsSetup, height: 156.94.h, width: 210.62.w,),
              SizedBox(height: 44.06.h,),
              Text(
                'Enable Fingerprint',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.textPrimary
                ),
              ),
              SizedBox(height: 10.h,),
              Text(
                "If you enable touch ID you don't need to enter your password when you Login",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.text5
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 70.h,),
              CustomButton(
                  buttonText: 'Continue',
                  onPressed: (){

                  }
              ),
              SizedBox(height: 16.h,),
              CustomButton(
                  buttonText: 'Not now',
                  useBorderColor: true,
                  borderColor: ColorPath.meadowGreen,
                  buttonTextColor: Theme.of(context).colorScheme.textPrimary,
                  onPressed: (){

                  }
              ),

            ],
          ),
        ),
      ),
    );
  }
}
