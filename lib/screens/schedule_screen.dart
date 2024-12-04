import 'package:intl/intl.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weekly_tab_pager/weekly_tab_pager.dart';

import 'package:homework_planner/common/common.dart';
import 'package:homework_planner/helpers/helpers.dart';
import 'package:homework_planner/providers/providers.dart';
import 'package:homework_planner/widgets/widgets.dart';

@RoutePage()
class ScheduleScreen extends ConsumerStatefulWidget {
  const ScheduleScreen({super.key});

  @override
  ConsumerState<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends ConsumerState<ScheduleScreen> {
  late DateTime today;
  late WeeklyTabController controller;
  late ValueNotifier<ScheduleResetButton> resetButton;
  late ValueNotifier<DateTime> titleDate;

  @override
  void initState() {
    super.initState();

    final weekdays = ref.read(settingsProvider).studyWeek.days;
    today = WeeklyTabNavigator.calcSafeDate(DateTime.now(), weekdays);

    controller = WeeklyTabController(position: today);
    resetButton = ValueNotifier(ScheduleResetButton.hidden);
    titleDate = ValueNotifier(today);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);

    return BackgroundScaffold(
      appBar: AppBar(
        title: ValueListenableBuilder(
          valueListenable: titleDate,
          builder: (_, valueDate, __) => ValueListenableBuilder(
            valueListenable: resetButton,
            builder: (_, valueButton, __) => ScheduleTitle(
              initialDate: today,
              currentDate: valueDate,
              resetButton: valueButton,
              onPressed: () => _resetScrollPosition(today),
            ),
          ),
        ),
      ),
      body: WeeklyTabNavigator(
        controller: controller,
        weekdays: settings.studyWeek.days,
        weekCount: ScheduleSettings.maxWeekCount,
        tabBuilder: (_, date) => _buildTab(date),
        pageBuilder: (_, date) => ScheduleView(date),
        onTabScrolled: (value) => _updateTitle(value),
        onTabChanged: (value) => _updateTitle(value),
      ),
    );
  }

  Widget _buildTab(DateTime date) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          DateFormat('E').format(date).toUpperCase(),
          softWrap: false,
        ),
        const SizedBox(height: 4),
        Text(date.day.toString()),
      ],
    );
  }

  void _updateTitle(DateTime date) {
    titleDate.value = date;
    _updateResetButton(date);
  }

  void _resetScrollPosition(DateTime date) {
    controller.animateTo(date);
    logEvent(AnalyticsEvent.scheduleResetScroll);
  }

  void _updateResetButton(DateTime date) {
    if (date.isSameWeek(today)) {
      resetButton.value = ScheduleResetButton.hidden;
    } else if (date.isBefore(today)) {
      resetButton.value = ScheduleResetButton.right;
    } else if (date.isAfter(today)) {
      resetButton.value = ScheduleResetButton.left;
    }
  }
}
