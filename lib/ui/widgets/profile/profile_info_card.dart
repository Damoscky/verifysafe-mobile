import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_asset.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/core/constants/named_routes.dart';
import 'package:verifysafe/core/data/enum/user_type.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/view_models/general_data_view_model.dart';
import 'package:verifysafe/core/data/view_models/user_view_model.dart';
import 'package:verifysafe/core/utilities/image_and_doc_utils.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/core/utilities/utilities.dart';
import 'package:verifysafe/ui/pages/profile/show_id.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/custom_button.dart';
import 'package:verifysafe/ui/widgets/custom_svg.dart';
import 'package:verifysafe/ui/widgets/display_image.dart';
import 'package:verifysafe/ui/widgets/show_flush_bar.dart';
import 'package:verifysafe/ui/widgets/verifysafe_container.dart';

class ProfileInfoCard extends ConsumerWidget {
  final bool showIdButton;
  final bool canCapture;

  const ProfileInfoCard({
    super.key,
    this.showIdButton = false,
    this.canCapture = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final userVm = ref.watch(userViewModel);
    final generalVm = ref.watch(generalDataViewModel);

    return VerifySafeContainer(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              DisplayImage(
                image: userVm.avatar,
                firstName: userVm.firstName,
                lastName: userVm.lastName,
                borderWidth: 2.w,
                size: 64.h,
                borderColor: ColorPath.persianGreen,
              ),
              if (generalVm.generalUploadState == ViewState.busy ||
                  userVm.state == ViewState.busy)
                Positioned(
                  top: 12.5,
                  right: 12.5,
                  child: CircularProgressIndicator(
                    color: ColorPath.congressBlue,
                  ),
                ),
              if (canCapture)
                Clickable(
                  onPressed: () async {
                    //todo: update [ImageAndDocUtils.getimage] to  [ImageAndDocUtils.pickAndCropImage]
                    final file = await ImageAndDocUtils.pickAndCropImage(context: context);
                    if (file != null) {
                      // final base64String =
                      //     await ImageAndDocUtils.fileToBase64ImageString(
                      //       file: file,
                      //     );

                      await generalVm.uploadImage(base64String: file);

                      if (generalVm.generalState == ViewState.retrieved) {
                        final details = {
                          "avatar": generalVm.fileUploadsResponse.first.url,
                        };
                        await userVm.updateUserData(details: details);
                      } else {
                        showFlushBar(
                          context: context,
                          message: generalVm.message,
                          success: false,
                        );
                      }
                    }
                  },
                  child: CustomSvg(asset: AppAsset.capture),
                ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            userVm.userData?.name ?? '',
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.blackText,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          //only Employer and Worker have ID.
          if (userVm.userData?.userEnumType != UserType.agency)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text.rich(
                  TextSpan(
                    text: "ID: ",
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.textSecondary,
                    ),
                    children: [
                      TextSpan(
                        text: userId(userVm),
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.text4,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Icon(
                    Icons.circle,
                    color: ColorPath.shamrockGreen,

                    size: 6,
                  ),
                ),
                Text(
                  status(userVm),
                  style: textTheme.bodyMedium?.copyWith(
                    color:
                        userVm.userData?.workerStatus?.toLowerCase() ==
                            'verified'
                        ? ColorPath.shamrockGreen
                        : ColorPath.paleGrey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          if (showIdButton)
            Column(
              children: [
                SizedBox(height: 8.h),
                CustomButton(
                  buttonWidth: null,
                  onPressed: () {
                    if (userVm.userData?.avatar != null) {
                      pushNavigation(
                        context: context,
                        widget: ShowId(userData: userVm.userData!),
                        routeName: NamedRoutes.showId,
                      );
                    } else {
                      showFlushBar(
                        context: context,
                        message: "Kindly Upload Profile Image",
                        success: false,
                      );
                    }
                  },
                  buttonText: "Show my ID",
                ),
              ],
            ),
        ],
      ),
    );
  }

  String userId(UserViewModel userVm) {
    if (userVm.userData?.userEnumType == UserType.worker) return userVm.userData?.workerId ?? "";
    if (userVm.userData?.userEnumType == UserType.employer) return userVm.userData?.employer?.employerId ?? "";
    return "";
  }

  String status(UserViewModel userVm) {
    if (userVm.userData?.userEnumType == UserType.worker) return Utilities.capitalizeWord(userVm.userData?.workerStatus ?? "");
    if (userVm.userData?.userEnumType == UserType.employer) return Utilities.capitalizeWord(userVm.userData?.employer?.status ?? "");
    return "";
  }
}
