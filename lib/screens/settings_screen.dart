import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homework_planner/common/depedencies.dart';

import 'package:homework_planner/styles/styles.dart';
import 'package:homework_planner/helpers/helpers.dart';
import 'package:homework_planner/models/models.dart';
import 'package:homework_planner/providers/providers.dart';
import 'package:homework_planner/dialogs/dialogs.dart';
import 'package:homework_planner/widgets/widgets.dart';

@RoutePage()
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final config = ref.watch(settingsProvider);

    return BackgroundScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('SettingsScreen.Title'.tr()),
      ),
      body: ListView(
        children: [
          _buildThemeMode(context, config),
          _buildColorTheme(context, config),
          _buildBackgroundImage(context, config),
          _buildStudyWeek(context, config),
          _buildPeriodCount(context, config),
          _buildRepeatSchedule(context, config),
          _buildGradingSystem(context, config),
        ],
      ),
    );
  }

  Widget _buildThemeMode(BuildContext context, Config config) {
    return ListTile(
      leading: const Icon(Icons.dark_mode_outlined),
      title: Text('SettingsScreen.ThemeMode'.tr()),
      subtitle: Text('${config.themeMode}'.tr()),
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => ValueListDialog(
          title: 'SettingsScreen.ThemeMode'.tr(),
          values: ThemeMode.values,
          initialValue: config.themeMode,
          textBuilder: (value) => '$value'.tr(),
        ),
      ).then((value) => value == null ? 0 : _updateThemeMode(value)),
    );
  }

  Widget _buildColorTheme(BuildContext context, Config config) {
    final oldColor = config.colorTheme;

    return ListTile(
      leading: const Icon(Icons.palette_outlined),
      title: Text('SettingsScreen.ColorTheme'.tr()),
      subtitle: Text(themes.getColorName(config.colorTheme)),
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) => ColorPickerDialog(
          title: 'SettingsScreen.ColorTheme'.tr(),
          values: themes.colors.keys.toList(),
          initialValue: config.colorTheme,
          onChanged: (color) => _updateColorTheme(color),
        ),
      ).then((value) => value == null ? _updateColorTheme(oldColor) : null),
    );
  }

  Widget _buildBackgroundImage(BuildContext context, Config config) {
    return ListTile(
      leading: const Icon(Icons.image_outlined),
      title: Text('SettingsScreen.BackgroundImage'.tr()),
      subtitle: Text(Backgrounds.getName(config.backgroundImage)),
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) => ImagePickerDialog(
          title: 'SettingsScreen.BackgroundImage'.tr(),
          initialValue: config.backgroundImage,
        ),
      ).then((value) => value == null ? 0 : _updateBackgroundImage(value)),
    );
  }

  Widget _buildStudyWeek(BuildContext context, Config config) {
    return ListTile(
      leading: const Icon(Icons.date_range_outlined),
      title: Text('SettingsScreen.StudyWeek'.tr()),
      subtitle: Text(config.studyWeek.displayText()),
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => CheckboxListDialog(
          title: 'SettingsScreen.StudyWeek'.tr(),
          items: DateHelper.getNamesOfWeekDays(),
          values: config.studyWeek.week,
          onValidate: (values) => values.contains(true),
        ),
      ).then((value) => value == null ? 0 : _updateStudyWeek(StudyWeek(week: value))),
    );
  }

  Widget _buildPeriodCount(BuildContext context, Config config) {
    return ListTile(
      leading: const Icon(Icons.notifications_outlined),
      title: Text('SettingsScreen.PeriodCount'.tr()),
      subtitle: const Text('SettingsScreen.PeriodCountText').tr(
        args: [config.periodCount.toString()],
      ),
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => ValueListDialog(
          title: 'SettingsScreen.PeriodCount'.tr(),
          values: const [4, 5, 6, 7, 8, 9, 10],
          initialValue: config.periodCount,
          textBuilder: (value) => value.toString(),
          alignment: Alignment.center,
        ),
      ).then((value) => value == null ? 0 : _updatePeriodCount(value)),
    );
  }

  Widget _buildRepeatSchedule(BuildContext context, Config config) {
    return ListTile(
      leading: const Icon(Icons.event_repeat_outlined),
      title: Text('SettingsScreen.RepeatSchedule'.tr()),
      subtitle: Text(config.repeatSchedule.toString().tr()),
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => ValueListDialog(
          title: 'SettingsScreen.RepeatSchedule'.tr(),
          values: RepeatSchedule.values,
          initialValue: config.repeatSchedule,
          textBuilder: (value) => value.toString().tr(),
        ),
      ).then((value) => value == null ? 0 : _updateRepeatSchedule(value as RepeatSchedule)),
    );
  }

  Widget _buildGradingSystem(BuildContext context, Config config) {
    return ListTile(
      leading: const Icon(Icons.grade_outlined),
      title: Text('SettingsScreen.GradingScale'.tr()),
      subtitle: Text(config.gradingSystem.scale.toString().tr()),
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) => ValueListDialog(
          title: 'SettingsScreen.GradingScale'.tr(),
          values: GradingScale.values,
          initialValue: config.gradingSystem.scale,
          textBuilder: (value) => value.toString().tr(),
        ),
      ).then((value) => value == null ? 0 : _updateGradingScale(GradingSystem(scale: value))),
    );
  }

  void _updateThemeMode(ThemeMode value) {
    ref.read(settingsProvider.notifier).themeMode = value;
    logEvent(AnalyticsEvent.settingsUpdate);
  }

  void _updateColorTheme(Color value) {
    ref.read(settingsProvider.notifier).colorTheme = value;
    logEvent(AnalyticsEvent.settingsUpdate);
  }

  void _updateBackgroundImage(String value) {
    ref.read(settingsProvider.notifier).backgroundImage = value;
    logEvent(AnalyticsEvent.settingsUpdate);
  }

  void _updateStudyWeek(StudyWeek value) {
    ref.read(settingsProvider.notifier).studyWeek = value;
    logEvent(AnalyticsEvent.settingsUpdate);
  }

  void _updatePeriodCount(int value) {
    ref.read(settingsProvider.notifier).periodCount = value;
    logEvent(AnalyticsEvent.settingsUpdate);
  }

  void _updateGradingScale(GradingSystem value) {
    ref.read(settingsProvider.notifier).gradingSystem = value;
    logEvent(AnalyticsEvent.settingsUpdate);
  }

  void _updateRepeatSchedule(RepeatSchedule value) {
    ref.read(settingsProvider.notifier).repeatSchedule = value;
    ref.read(periodsProvider.notifier).repeatPeriods(value);
    logEvent(AnalyticsEvent.settingsUpdate);
  }
}
