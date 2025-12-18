import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_dimension.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/constants/color_path.dart';
import 'package:verifysafe/core/constants/named_routes.dart';
import 'package:verifysafe/core/data/enum/user_type.dart';
import 'package:verifysafe/core/data/view_models/user_view_model.dart';
import 'package:verifysafe/core/utilities/navigator.dart';
import 'package:verifysafe/core/utilities/utilities.dart';
import 'package:verifysafe/ui/pages/profile/edit_user_information.dart';
import 'package:verifysafe/ui/widgets/clickable.dart';
import 'package:verifysafe/ui/widgets/custom_appbar.dart';
import 'package:verifysafe/ui/widgets/custom_divider.dart';
import 'package:verifysafe/ui/widgets/data_tile.dart';
import 'package:verifysafe/ui/widgets/profile/profile_info_card.dart';

class ViewUserInformation extends ConsumerStatefulWidget { 
  const ViewUserInformation({super.key});

  @override
  ConsumerState<ViewUserInformation> createState() =>
      _ViewUserInformationState();
}

class _ViewUserInformationState extends ConsumerState<ViewUserInformation> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final userVm = ref.watch(userViewModel);

    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: '${Utilities.capitalizeWord(userVm.userData?.userType ?? "")} Information',
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 24.w),
            child: Clickable(
              onPressed: () {
                pushNavigation(
                  context: context,
                  widget: EditUserInformation(),
                  routeName: NamedRoutes.editUserInfo,
                );
              },
              child: Text(
                "Edit",
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: ColorPath.meadowGreen,
                ),
              ),
            ),
          ),
        ],
        showBottom: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimension.paddingLeft,
          vertical: 16.h,
        ),
        children: [
          ProfileInfoCard(canCapture: true),
          SizedBox(height: 24.h),
          Text(
            "${Utilities.capitalizeWord(userVm.userData?.userType ?? "")} Information",
            style: textTheme.bodyMedium?.copyWith(color: colorScheme.text4),
          ),
          //todo::: handle data viewed based on user type
          SizedBox(height: 16.h),
          if (userVm.userData?.userEnumType != UserType.worker)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DataTile(title: "Business Type", data: businessType(userVm)),
                CustomDivider(verticalSpace: 14),
              ],
            ),
          DataTile(
            title: "Phone Number",
            data: Utilities.formatPhoneWithCode(
              phoneNumber: userVm.userData?.phone ?? "",
            ),
          ),
          if (userVm.userData?.userEnumType != UserType.worker)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomDivider(verticalSpace: 14),
                DataTile(
                  title: "Phone Number 2",
                  data: Utilities.formatPhoneWithCode(
                    phoneNumber: phone2(userVm),
                  ),
                ),
              ],
            ),
          CustomDivider(verticalSpace: 14),
          DataTile(title: "Email Address", data: userVm.userData?.email ?? ""),
          CustomDivider(verticalSpace: 14),
          DataTile(
            title: "Marital Status",
            data: Utilities.capitalizeWord(
              userVm.userData?.maritalStatus ?? "",
            ),
          ),
          CustomDivider(verticalSpace: 14),
          DataTile(
            title: "Gender",
            data: Utilities.capitalizeWord(userVm.userData?.gender ?? ""),
          ),
          //TODO::: DOB not available
          // CustomDivider(verticalSpace: 14),
          // DataTile(
          //   title: "Date of Birth",
          //   data: Utilities.capitalizeWord(userVm.userData?.dateOfBirth ?? ""),
          // ),
          //AGENCY
          if (userVm.userData?.location != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomDivider(verticalSpace: 14),
                DataTile(
                  title: "Nationality",
                  data: userVm.userData?.location?.country ?? "N/A",
                ),
                CustomDivider(verticalSpace: 14),
                DataTile(
                  title: "State",
                  data: userVm.userData?.location?.state ?? "N/A",
                ),
                CustomDivider(verticalSpace: 14),
                DataTile(
                  title: "Local Government",
                  data: userVm.userData?.location?.city ?? "N/A",
                ),
              ],
            ),
          CustomDivider(verticalSpace: 14),
          DataTile(title: "Address", data: address(userVm)),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  String businessType(UserViewModel userVm) {
    if (userVm.userData?.userEnumType == UserType.agency)
      return userVm.userData?.agency?.businessType ?? "";
    if (userVm.userData?.userEnumType == UserType.employer)
      return userVm.userData?.employer?.businessType ?? "";
    return "";
  }

  String phone2(UserViewModel userVm) {
    if (userVm.userData?.userEnumType == UserType.agency)
      return userVm.userData?.agency?.phone ?? "";
    if (userVm.userData?.userEnumType == UserType.employer)
      return userVm.userData?.employer?.phone ?? "";
    return "";
  }

  String address(UserViewModel userVm) {
    if (userVm.userData?.userEnumType == UserType.agency)
      return userVm.userData?.agency?.address ?? "N/A";
    if (userVm.userData?.userEnumType == UserType.employer)
      return userVm.userData?.employer?.address ?? "N/A";
    if (userVm.userData?.userEnumType == UserType.worker)
      return userVm.userData?.workerInfo?.residentialAddress ?? "N/A";
    return "";
  }
}
