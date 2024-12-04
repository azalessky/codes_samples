import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';

import 'package:homework_planner/common/common.dart';
import 'package:homework_planner/providers/providers.dart';
import 'package:homework_planner/widgets/widgets.dart';

class BackgroundScaffold extends ConsumerWidget {
  final AppBar appBar;
  final Widget body;
  final Widget? floatingActionButton;

  const BackgroundScaffold({
    required this.appBar,
    required this.body,
    this.floatingActionButton,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.read(settingsProvider);
    final ads = ref.watch(adsProvider);
    final adHeight = ads ? AdSettings.maxHeight + AdSettings.bannerPadding.vertical : 0.0;

    final scaffold = AnnotatedRegion<SystemUiOverlayStyle>(
      value: themes.getSystemUiOverlayStyle(settings.themeMode, context),
      child: Padding(
        padding: EdgeInsets.only(top: adHeight),
        child: Scaffold(
          appBar: appBar,
          body: SafeArea(child: body),
          floatingActionButton: floatingActionButton,
        ),
      ),
    );

    bool hasTabsScaffold = context.findAncestorWidgetOfExactType<AutoTabsScaffold>() != null;
    return hasTabsScaffold
        ? scaffold
        : Stack(
            children: [
              BackgroundImage(image: settings.backgroundImage),
              scaffold,
            ],
          );
  }
}
