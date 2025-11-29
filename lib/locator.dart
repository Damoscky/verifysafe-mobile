import 'package:get_it/get_it.dart';
import 'package:verifysafe/core/data/data_providers/auth_data_provider/auth_data_provider.dart';
import 'package:verifysafe/core/data/data_providers/general_data_provider/general_data_provider.dart';
import 'package:verifysafe/core/data/data_providers/onboarding_data_provider/onboarding_data_provider.dart';
import 'core/data/services/geolocator_service.dart';
import 'core/data/services/navigation_service.dart';



GetIt locator = GetIt.instance;

void setupLocator() {
  //register api classes
  //locator.registerLazySingleton<UtilityDataProvider>(() => UtilityDataProvider());
  locator.registerLazySingleton<AuthDataProvider>(() => AuthDataProvider());
  locator.registerLazySingleton<OnboardingDataProvider>(() => OnboardingDataProvider());
  locator.registerLazySingleton<GeneralDataProvider>(() => GeneralDataProvider());





  ///services
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton<GeoLocatorService>(() => GeoLocatorService());
}
