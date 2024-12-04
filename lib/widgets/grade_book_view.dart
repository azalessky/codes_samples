import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';

import 'package:homework_planner/common/common.dart';
import 'package:homework_planner/models/models.dart';
import 'package:homework_planner/providers/providers.dart';
import 'package:homework_planner/widgets/widgets.dart';
import 'package:homework_planner/helpers/helpers.dart';

class GradeBookView extends ConsumerWidget {
  const GradeBookView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(periodsProvider);
    final data = _getData(ref);

    logEvent(AnalyticsEvent.gradesShowBook);

    return data.isNotEmpty
        ? FlexibleTable(
            rowCount: data.length,
            columns: [
              FlexibleColumn(
                title: 'GradeBookView.Subject'.tr(),
                width: 0,
                align: TextAlign.start,
              ),
              FlexibleColumn(
                title: 'GradeBookView.Grades'.tr(),
                width: 100,
                align: TextAlign.end,
                onTap: (row) => context.pushRoute(
                  GradesHistoryRoute(
                    subject: data.keys.elementAt(row),
                    start: DateHelper.minDate,
                    end: DateHelper.maxDate,
                  ),
                ),
              ),
            ],
            textBuilder: (column, row) => switch (column) {
              0 => data.keys.elementAt(row),
              1 => _formatGrades(data, data.keys.elementAt(row)),
              _ => ''
            },
          )
        : EmptyPlaceholder(text: 'GradeBookView.NoData'.tr());
  }

  String _formatGrades(GradeBook book, String subject) {
    return book[subject]!.fold('', (prev, e) => '$prev $e');
  }

  GradeBook _getData(WidgetRef ref) {
    final periods = ref.read(periodsProvider.notifier);
    return periods.getGradeBook(DateHelper.minDate, DateHelper.maxDate);
  }
}
