
import 'dart:ui';

import 'package:flutter/material.dart';

class ColorPath {

  //brand colors
  static const gulfBlue = Color(0xff06184D);


  //other colors
  static const paleGrey = Color(0xff667085);
  static const porcelainGrey = Color(0xffF6F7F8);
  static const mysticGrey = Color(0xffD9DFE9);
  static const slateGrey = Color(0xff71808E);
  static const mirageBlack = Color(0xff141B2B);
  static const troutGrey = Color(0xff4F5862);
  static const redOrange = Color(0xffFF2F31);
  static const oxfordBlue = Color(0xff344054);
  static const meadowGreen = Color(0xff15B79E);
  static const stormGrey = Color(0xff6E7191);
  static const whisperGrey = Color(0xffEFF0F6);
  static const athensGrey = Color(0xffFCFCFD);
  static const athensGrey2 = Color(0xffF2F4F7);
  static const athensGrey3 = Color(0xffEAECF0);
  static const athensGrey4 = Color(0xffE6E8ED);
  static const clearGreen = Color(0xffEBFFFA);
  static const shamrockGreen = Color(0xff30B895);
  static const mintGreen = Color(0xffD7FEF4);
  static const indigoBlue = Color(0xff5F79C3);
  static const funGreen = Color(0xff008A47);
  static const jaffaOrange = Color(0xffEA7E30);
  static const milanoRed = Color(0xffCA1902);
  static const foamGreen = Color(0xffECFDF3);
  static const dawnYellow = Color(0xffFFFAEB);
  static const vesuBrown = Color(0xffB54708);
  static const gloryGreen = Color(0xff9FE1D7);
  static const aquaGreen = Color(0xffE8F8F5);
  static const provincialPink = Color(0xffFEF3F2);
  static const thunderbirdRed = Color(0xffB42318);
  static const creamYellow = Color(0xffFFE49A);
  static const mischkaGrey = Color(0xffD0D5DD);
  static const gullGrey = Color(0xff98A2B3);




























  static Color dynamicColor(String? hexString) {
    // Return default color if hexString is null or empty
    if (hexString == null || hexString.isEmpty) {
      return gulfBlue;
    }
    try {
      // Remove the '#' character if it exists
      final hexCode = hexString.replaceAll('#', '');

      // Parse the hexadecimal string to an integer
      return Color(int.parse('FF$hexCode', radix: 16));
    } catch (e) {
      debugPrint('Error parsing color: $e');
      return gulfBlue;
    }
  }







































}