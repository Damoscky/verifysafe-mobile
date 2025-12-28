import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiRoutes {
  //auth
  static var resetForgetPassword =
      "${dotenv.env['AUTH']}/forgot-password/reset";
  static var recoverForgetPassword =
      "${dotenv.env['AUTH']}/forgot-password/recover";
  static var signIn = "${dotenv.env['AUTH']}/signin";
  static var resend = "${dotenv.env['AUTH']}/resend";
  static var verify = "${dotenv.env['AUTH']}/verify-otp";


  //onboarding
  static var createProfile = "${dotenv.env['ONBOARDING']}/create-profile";
  static var verifyOnboardingEmail = "${dotenv.env['ONBOARDING']}/verify-email";
  static var setupPassword = "${dotenv.env['ONBOARDING']}/setup-password";
  static var createAgency = "${dotenv.env['ONBOARDER']}/create-agency";
  static var createEmployer = "${dotenv.env['ONBOARDER']}/create-employer";
  static var createIdentity = "${dotenv.env['ONBOARDER']}/create-identity-verification";
  static var createEmploymentInfo = "${dotenv.env['ONBOARDER']}/create-employment-information";
  static var createWorkHistory = "${dotenv.env['ONBOARDER']}/create-work-history";
  static var createReference = "${dotenv.env['ONBOARDER']}/create-reference";
  static var createContactPerson = "${dotenv.env['ONBOARDER']}/create-contact-person";
  static var createServices = "${dotenv.env['ONBOARDER']}/create-services";

  //general
  static var getCountries = "${dotenv.env['GENERAL']}/countries";
  static var getStates = "${dotenv.env['GENERAL']}/states";
  static var getCities = "${dotenv.env['GENERAL']}/cities";
  static var getDropDowns = "${dotenv.env['GENERAL']}/dropdowns";
  static var uploadFiles = "${dotenv.env['GENERAL']}/media/upload";

  //profile
  static var getUser = "${dotenv.env['PROFILE']}/me";
  static var profile = "${dotenv.env['PROFILE']}";

  //worker
  static var workHistoriesOverview = "${dotenv.env['V1']}/work-histories";
  static var workers = "${dotenv.env['V1']}/workers";
  static fetchWorkers({required String? keyword}) =>
      "${dotenv.env['V1']}/workers?q=$keyword&paginate=0";


  //employer
  static var employerDashboardStats = "${dotenv.env['V1']}/dashboard/employer-stats";
  static var employers = "${dotenv.env['V1']}/employers";

  static fetchEmployers({required String? keyword}) =>
      "${dotenv.env['V1']}/employers?q=$keyword&paginate=0";

    //agency
  static var agencyDashboardStats = "${dotenv.env['V1']}/dashboard/agency-stats";

  //guarantor
  static fetchGuarantors({required String? filterOptions}) =>
  filterOptions == null ?
      "${dotenv.env['V1']}/worker-references?paginate=1"
        :"${dotenv.env['V1']}/worker-references?paginate=1&$filterOptions";
  static var createGuarantor = "${dotenv.env['V1']}/worker-references";
  static toggleStatus({required String? id}) =>
      "${dotenv.env['V1']}/worker-references/$id";

  //misconducts
  static fetchMisconducts({required String? filterOptions}) =>
      filterOptions == null ?
      "${dotenv.env['V1']}/misconducts?paginate=1"
          :"${dotenv.env['V1']}/misconducts?paginate=1&$filterOptions";
  static var createMisconductReport = "${dotenv.env['V1']}/misconducts";
  static deleteReport({required String? id}) =>
      "${dotenv.env['V1']}/misconducts/$id";

  //billings
  static var billings = "${dotenv.env['V1']}/billings";
}
