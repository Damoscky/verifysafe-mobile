import 'package:get_it/get_it.dart';
import 'package:verifysafe/core/data/data_providers/auth_data_provider/auth_data_provider.dart';
import 'package:verifysafe/core/data/data_providers/general_data_provider/general_data_provider.dart';
import 'package:verifysafe/core/data/data_providers/guarantor_data_provider/guarantor_data_provider.dart';
import 'package:verifysafe/core/data/data_providers/misconducts_data_provider/misconducts_data_provider.dart';
import 'package:verifysafe/core/data/data_providers/onboarding_data_provider/onboarding_data_provider.dart';
import 'package:verifysafe/core/data/data_providers/review_data_provider.dart';
import 'package:verifysafe/core/data/data_providers/users_data_providers/agency_data_provider.dart';
import 'package:verifysafe/core/data/data_providers/users_data_providers/employer_data_provider.dart';
import 'package:verifysafe/core/data/data_providers/users_data_providers/user_data_provider.dart';
import 'package:verifysafe/core/data/data_providers/users_data_providers/worker_data_provider.dart';
import 'core/data/services/geolocator_service.dart';
import 'core/data/services/navigation_service.dart';



GetIt locator = GetIt.instance;

void setupLocator() {
  //register api classes
  //locator.registerLazySingleton<UtilityDataProvider>(() => UtilityDataProvider());
  locator.registerLazySingleton<AuthDataProvider>(() => AuthDataProvider());
  locator.registerLazySingleton<OnboardingDataProvider>(() => OnboardingDataProvider());
  locator.registerLazySingleton<GeneralDataProvider>(() => GeneralDataProvider());
  locator.registerLazySingleton<UserDataProvider>(() => UserDataProvider());
  locator.registerLazySingleton<WorkerDataProvider>(() => WorkerDataProvider());
  locator.registerLazySingleton<EmployerDataProvider>(() => EmployerDataProvider());
  locator.registerLazySingleton<AgencyDataProvider>(() => AgencyDataProvider());
  locator.registerLazySingleton<GuarantorDataProvider>(() => GuarantorDataProvider());
  locator.registerLazySingleton<MisconductsDataProvider>(() => MisconductsDataProvider());
  locator.registerLazySingleton<ReviewDataProvider>(() => ReviewDataProvider());



  ///services
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton<GeoLocatorService>(() => GeoLocatorService());
}
