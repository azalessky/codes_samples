import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:homework_planner/common/common.dart';
import 'package:homework_planner/models/models.dart';
import 'package:homework_planner/providers/providers.dart';
import 'package:homework_planner/widgets/widgets.dart';
import 'package:homework_planner/helpers/helpers.dart';

class GradeReportView extends ConsumerWidget {
  static const maxColumnCount = 5;

  const GradeReportView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(periodsProvider);
    ref.watch(termsProvider);

    final terms = ref.read(termsProvider.notifier).studyTerms;
    final data = _getData(ref);
    final columnCount = min(data.isEmpty ? 0 : data.values.first.length, maxColumnCount);

    logEvent(AnalyticsEvent.gradesShowReport);

    return data.isNotEmpty
        ? FlexibleTable(
            rowCount: data.length,
            columns: [
              FlexibleColumn(
                title: 'GradeBookView.Subject'.tr(),
                width: 0,
                align: TextAlign.start,
              ),
              ...List<FlexibleColumn>.generate(
                columnCount,
                (index) => FlexibleColumn(
                  title: index < columnCount - 1
                      ? 'GradeReportView.Term${index + 1}'.tr()
                      : 'GradeReportView.Average'.tr(),
                  width: 30,
                  align: TextAlign.center,
                  onTap: (row) => context.pushRoute(
                    GradesHistoryRoute(
                      subject: data.keys.elementAt(row),
                      start: index < columnCount - 1 ? terms[index].start : DateHelper.minDate,
                      end: index < columnCount - 1 ? terms[index].end : DateHelper.maxDate,
                    ),
                  ),
                ),
              )
            ],
            textBuilder: (column, row) => switch (column) {
              0 => data.keys.elementAt(row),
              _ => data[data.keys.elementAt(row)]![column - 1],
            },
          )
        : EmptyPlaceholder(text: 'GradeReportView.NoData'.tr());
  }

  GradeReport _getData(WidgetRef ref) {
    final settings = ref.read(settingsProvider);
    final terms = ref.read(termsProvider.notifier);
    final periods = ref.read(periodsProvider.notifier);

    return periods.getGradeReport(terms.studyTerms, settings.gradingSystem);
  }
}
