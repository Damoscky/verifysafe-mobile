import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiRoutes {
  //auth
  static var resetForgetPassword =
      "${dotenv.env['AUTH']}/forgot-password/reset";
  static var recoverForgetPassword =
      "${dotenv.env['AUTH']}/forgot-password/recover";
  static var signIn = "${dotenv.env['AUTH']}/signin";
  static var resend = "${dotenv.env['AUTH']}/resend";

  //onboarding
  static var createProfile = "${dotenv.env['ONBOARDING']}/create-profile";
  static var verifyOnboardingEmail = "${dotenv.env['ONBOARDING']}/verify-email";
  static var setupPassword = "${dotenv.env['ONBOARDING']}/setup-password";
  static var createAgency = "${dotenv.env['ONBOARDER']}/create-agency";
  static var createEmployer = "${dotenv.env['ONBOARDER']}/create-employer";


  //general
  static var getCountries = "${dotenv.env['GENERAL']}/countries";
  static var getStates = "${dotenv.env['GENERAL']}/states";
  static var getCities = "${dotenv.env['GENERAL']}/cities";
  static var getDropDowns = "${dotenv.env['GENERAL']}/dropdowns";
}
