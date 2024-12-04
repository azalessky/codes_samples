import 'package:get_it/get_it.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:homework_planner/common/common.dart';
import 'package:homework_planner/styles/styles.dart';
import 'package:homework_planner/repositories/repositories.dart';
import 'package:homework_planner/helpers/helpers.dart';

final getIt = GetIt.I;

final remoteRepository = getIt<RemoteRepository>();
final localRepository = getIt<LocalRepository>();

final themes = getIt<Themes>();
final showSnackBar = getIt<MessengerHelper>().showSnackBar;
final logEvent = getIt<AnalyticsHelper>().logEvent;
final authHelper = getIt<AuthHelper>();

class Dependencies {
  static void initialize() {
    getIt.registerSingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance(),
    );
    getIt.registerSingletonAsync<String>(
      () => rootBundle.loadString(ResourceSettings.subjectsAsset),
      instanceName: ResourceSettings.subjectsResource,
    );
    getIt.registerSingletonWithDependencies<LocalRepository>(
      () => LocalRepository(getIt.get<SharedPreferences>()),
      dependsOn: [SharedPreferences],
    );
    getIt.registerSingleton<RemoteRepository>(RemoteRepository());
    getIt.registerSingleton<Themes>(Themes());
    getIt.registerSingleton<AnalyticsHelper>(AnalyticsHelper());
    getIt.registerSingleton<MessengerHelper>(MessengerHelper());
    getIt.registerSingleton<AuthHelper>(AuthHelper());

    getIt.allReady();
  }
}
