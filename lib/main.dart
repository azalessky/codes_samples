import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

import 'package:homework_planner/providers/providers.dart';
import 'package:homework_planner/common/common.dart';
import 'package:homework_planner/widgets/widgets.dart';
import 'package:homework_planner/helpers/helpers.dart';

import 'firebase_options.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    GoogleFonts.config.allowRuntimeFetching = false;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    EasyLocalization.logger.enableBuildModes = [];
    await EasyLocalization.ensureInitialized();

    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(kReleaseMode);
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(kReleaseMode);

    MobileAds.setUserConsent(true);
    MobileAds.setLocationConsent(true);
    MobileAds.setAgeRestrictedUser(true);
    MobileAds.initialize();

    Dependencies.initialize();

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    runApp(
      EasyLocalization(
        ignorePluralRules: false,
        supportedLocales: const [
          Locale('en'),
          Locale('ru'),
          Locale('uk'),
          Locale('kk'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: MainApp(routes: Routes()),
      ),
    );
  }, (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  });
}

class MainApp extends ConsumerWidget {
  final Routes routes;

  const MainApp({required this.routes, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      child: Consumer(
        builder: (context, ref, _) => _buildApp(context, ref),
      ),
    );
  }

  Widget _buildApp(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final ads = ref.watch(adsProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      onGenerateTitle: (_) => 'App.Title'.tr(),
      themeMode: settings.themeMode,
      theme: themes.lightTheme(settings.colorTheme, settings.backgroundImage.isNotEmpty),
      darkTheme: themes.darkTheme(settings.colorTheme, settings.backgroundImage.isNotEmpty),
      scaffoldMessengerKey: getIt<MessengerHelper>().messengerKey,
      routerConfig: routes.config(
        navigatorObservers: () => [
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
        ],
      ),
      builder: (context, child) => Stack(
        children: [
          BackgroundImage(image: settings.backgroundImage),
          child!,
          if (ads)
            AdBanner(
              unitId: kDebugMode ? AdSettings.demoUnitId : AdSettings.adUnitId,
              maxHeight: AdSettings.maxHeight,
              padding: AdSettings.bannerPadding,
              onAdLoaded: () => ref.read(adsProvider.notifier).status = true,
              onAdFailed: () => ref.read(adsProvider.notifier).status = false,
            ),
        ],
      ),
    );
  }
}
