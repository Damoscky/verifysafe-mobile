import 'package:flutter/material.dart';
import 'package:verifysafe/core/utilities/extensions/color_extensions.dart';
import '../color_path.dart';



extension CustomColorScheme on ColorScheme {
  // Custom text color variants

  //brand
  Color get brandColor => ColorPath.gulfBlue;


  //texts//

  //default
  Color get blackText => brightness == Brightness.light ? Colors.black : Colors.white;
  Color get whiteText => brightness == Brightness.light ? Colors.white : Colors.black;

  //text
  Color get textPrimary => brightness == Brightness.light ? ColorPath.mirageBlack : Colors.white;
  Color get textSecondary => brightness == Brightness.light ? ColorPath.slateGrey : Colors.white;
  Color get textTertiary => brightness == Brightness.light ? ColorPath.mysticGrey : Colors.white;
  Color get text4 => brightness == Brightness.light ? ColorPath.troutGrey : Colors.white;
  Color get text5 => brightness == Brightness.light ? ColorPath.paleGrey : Colors.white;




  //widgets
  //text-field
  Color get textFieldFillColor => brightness == Brightness.light ?  Colors.white : Colors.black;
  Color get textFieldLabel => brightness == Brightness.light ? ColorPath.oxfordBlue: Colors.white;
  Color get textFieldBorder => brightness == Brightness.light ? ColorPath.athensGrey2 : Colors.white;
  Color get textFieldFocusedBorder => ColorPath.indigoBlue;
  Color get textFieldHint => brightness == Brightness.light ? ColorPath.paleGrey : Colors.white;
  Color get textFieldSuffixIcon => textPrimary;

  //container
  Color get containerBg => brightness == Brightness.light ?  Colors.white : Colors.black;
  Color get onboardingContainerBg => brightness == Brightness.light ?  ColorPath.athensGrey : Colors.black;
  Color get onboardingContainerBorder => brightness == Brightness.light ?  ColorPath.athensGrey3 : Colors.black;
  Color get assetBg => brightness == Brightness.light ?  ColorPath.athensGrey2 : Colors.black;

  //appbar
  Color get appbarTitle => textPrimary;
  Color get appbarDivider => brightness == Brightness.light ? ColorPath.athensGrey : Colors.white;

  //password requirement widget
  Color get pwdInactive => textSecondary;

  //pin code field
  Color get pinCodeInactiveFillColor => ColorPath.whisperGrey;
  Color get pinCodeInactiveBorderColor => Colors.transparent;
  Color get pinCodeActiveBorderColor => textPrimary;
  Color get pinCodeActiveFillColor => ColorPath.whisperGrey;



}