import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homework_planner/common/common.dart';
import 'package:auto_route/auto_route.dart';

import 'package:homework_planner/helpers/helpers.dart';
import 'package:homework_planner/models/models.dart';
import 'package:homework_planner/providers/providers.dart';
import 'package:homework_planner/dialogs/dialogs.dart';
import 'package:homework_planner/widgets/widgets.dart';

class ScheduleView extends ConsumerStatefulWidget {
  final DateTime date;

  const ScheduleView(this.date, {super.key});

  @override
  ConsumerState<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends ConsumerState<ScheduleView> {
  @override
  Widget build(BuildContext context) {
    ref.watch(periodsProvider);
    ref.watch(termsProvider);

    final periodCount = ref.read(settingsProvider).periodCount;
    final periods = ref.read(periodsProvider.notifier);
    final terms = ref.read(termsProvider.notifier);

    return SingleChildScrollView(
      child: Column(
        children: [
          FormLayout.largeSpacer,
          terms.isStudy(widget.date) || !terms.isHoliday(widget.date)
              ? _buildSchedule(context, periods.getPeriods(widget.date, periodCount))
              : _buildHoliday(context, terms.findTerm(widget.date, TermType.holiday)!.name)
        ],
      ),
    );
  }

  Widget _buildHoliday(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }

  Widget _buildSchedule(BuildContext context, List<Period> periods) {
    return Table(
      border: TableBorder.all(
        color: Theme.of(context).colorScheme.outline,
        width: 1,
      ),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: FixedColumnWidth(35),
        1: FlexColumnWidth(45),
        2: FlexColumnWidth(55),
        3: FixedColumnWidth(45),
      },
      children: List<TableRow>.generate(
        periods.length + 1,
        (index) =>
            index == 0 ? _buildTableHeader(context) : _buildTableRow(context, periods[index - 1]),
      ),
    );
  }

  TableRow _buildTableHeader(BuildContext context) {
    return TableRow(
      children: [
        _buildHeaderCell(context, 'ScheduleView.PeriodHeader'.tr()),
        _buildHeaderCell(context, 'ScheduleView.SubjectHeader'.tr()),
        _buildHeaderCell(context, 'ScheduleView.AssignmentHeader'.tr()),
        if (ref.read(settingsProvider).gradingSystem.scale != GradingScale.none)
          _buildHeaderCell(context, 'ScheduleView.GradeHeader'.tr()),
      ],
    );
  }

  Widget _buildHeaderCell(BuildContext context, String text) {
    return ScheduleCell(
      text: text,
      textStyle: Theme.of(context).textTheme.titleSmall,
      padding: EdgeInsets.all(10 + (Platform.isIOS ? 2 : 0)),
    );
  }

  TableRow _buildTableRow(BuildContext context, Period period) {
    final padding = EdgeInsets.symmetric(horizontal: 8, vertical: 12 + (Platform.isIOS ? 4 : 0));
    final settings = ref.read(settingsProvider);

    return TableRow(
      children: [
        ScheduleCell(
          text: period.slot.toString(),
          padding: padding,
          alignment: Alignment.center,
        ),
        ScheduleCell(
          text: period.subject,
          padding: padding,
          alignment: Alignment.centerLeft,
          onTap: () => _selectSubject(context, period),
        ),
        ScheduleCell(
          text: period.homework.text,
          padding: padding,
          alignment: Alignment.centerLeft,
          onTap: () => context.pushRoute(HomeworkRoute(period: period)),
          icon: period.homework.done
              ? const Icon(Icons.check, size: 16)
              : (period.homework.images.isNotEmpty
                  ? const Icon(Icons.image_outlined, size: 16)
                  : null),
        ),
        if (settings.gradingSystem.scale != GradingScale.none)
          ScheduleCell(
            text: period.grade,
            padding: padding,
            alignment: Alignment.center,
            textStyle: GoogleFonts.playball(
              textStyle: Theme.of(context).textTheme.bodyLarge,
              color: settings.gradingSystem.gradeColor(period.grade),
              fontWeight: FontWeight.bold,
            ),
            onTap: () => _selectGrade(context, period),
          ),
      ],
    );
  }

  void _selectSubject(BuildContext context, Period period) async {
    final subjects = ref.read(subjectsProvider.notifier).names;

    final subject = await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return ValueListDialog<String>(
          values: subjects,
          initialValue: period.subject,
          textBuilder: (value) => value,
          clearButton: period.subject.isNotEmpty,
        );
      },
    );

    if (subject != null) {
      period = period.copyWith(subject: subject);
      _updatePeriod(ref, period);
      logEvent(AnalyticsEvent.scheduleSelectSubject);
    }
  }

  void _selectGrade(BuildContext context, Period period) async {
    final grades = ref.read(settingsProvider).gradingSystem.values.reversed.toList();

    final grade = await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return ValueListDialog<String>(
          values: grades,
          initialValue: period.grade,
          textBuilder: (value) => value,
          alignment: Alignment.center,
          clearButton: period.grade.isNotEmpty,
        );
      },
    );

    if (grade != null) {
      period = period.copyWith(grade: grade);
      _updatePeriod(ref, period);
      logEvent(AnalyticsEvent.scheduleSelectGrade);
    }
  }

  void _updatePeriod(WidgetRef ref, Period period) {
    final repeat = ref.read(settingsProvider).repeatSchedule;
    ref.read(periodsProvider.notifier).updatePeriod(period, repeat);
  }
}
