import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:homework_planner/common/common.dart';
import 'package:homework_planner/helpers/helpers.dart';
import 'package:homework_planner/widgets/widgets.dart';

@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    remoteRepository.subscribe(_handleDataUpdate);
    remoteRepository.sync();
  }

  @override
  void dispose() {
    remoteRepository.unsubscribe();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      key: UniqueKey(),
      routes: const [
        ScheduleRoute(),
        AssignmentsRoute(),
        NotesRoute(),
        BellsRoute(),
        GradesRoute(),
        ProfileRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) => Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Theme.of(context).colorScheme.outlineVariant, width: 1),
          ),
        ),
        child: BottomNavBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
        ),
      ),
    );
  }

  void _handleDataUpdate() {
    showSnackBar(SnackBarStyle.info, 'Message.DataUpdated'.tr());
    logEvent(AnalyticsEvent.cloudSync);
  }
}
