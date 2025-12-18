import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verifysafe/core/constants/app_constants.dart';
import 'package:verifysafe/core/data/view_models/general_data_view_model.dart';
import 'package:verifysafe/router.dart' as router;
import 'package:verifysafe/ui/pages/splash.dart';
import 'core/constants/app_config.dart';
import 'core/constants/app_theme/app_theme.dart';
import 'core/data/enum/environment.dart';
import 'core/data/services/navigation_service.dart';
import 'core/data/view_models/theme_selection_view_model.dart';
import 'core/utilities/secure_storage/secure_storage_init.dart';
import 'locator.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.notification != null) {}
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  //await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  AppConfig.setEnvironment(Environment.staging);
  SecureStorageInit.initSecureStorage();
  setupLocator();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    //push notification initial set up
    // FirebaseMessagingUtils.requestPushNotificationPermission();

    //location permission
    // final locationService = locator<GeoLocatorService>();
    // locationService.requestPermission();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(generalDataViewModel)
          .fetchDropdownOptions(); //prefetches platform dropdown data
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final maxHeight = constraints.maxHeight;

          const figmaDesignSize = Size(draftWidth, draftHeight);
          final isFoldOrTablet = maxWidth > phoneWidth;
          final designSize = isFoldOrTablet
              ? Size(maxWidth - 16, maxHeight - 32)
              : figmaDesignSize; // standard phone design
          return ScreenUtilInit(
            splitScreenMode: false,
            minTextAdapt: true,
            designSize: designSize,
            builder: (context, child) => Consumer(
              builder: (context, ref, child) {
                final themeVm = ref.watch(themeSelectionViewModel);
                final themeMode = themeVm.themeMode;
                return MaterialApp(
                  title: 'VerifySafe',
                  debugShowCheckedModeBanner: false,
                  theme: AppTheme.lightTheme,
                  darkTheme: AppTheme.darkTheme,
                  themeMode: themeMode,
                  navigatorKey: locator<NavigationService>().navigationKey,
                  onGenerateRoute: router.generateRoute,
                  //initialRoute: NamedRoutes.bottomNav,
                  home: Splash(),
                  builder: (context, child) {
                    final mq = MediaQuery.of(context);
                    return MediaQuery(
                      data: mq.copyWith(textScaler: TextScaler.noScaling),
                      child: child!,
                    );
                  },
                );
              },
            ),
          );
        }
    );
  }
}
