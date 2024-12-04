import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:homework_planner/common/common.dart';
import 'package:homework_planner/helpers/helpers.dart';
import 'package:homework_planner/models/models.dart';
import 'package:homework_planner/providers/providers.dart';
import 'package:homework_planner/widgets/widgets.dart';

@RoutePage()
class GradesHistoryScreen extends ConsumerWidget {
  final String subject;
  final DateTime start;
  final DateTime end;

  const GradesHistoryScreen({
    required this.subject,
    required this.start,
    required this.end,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = _getData(ref);
    logEvent(AnalyticsEvent.gradesShowHistory);

    return BackgroundScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(subject),
      ),
      body: data.isNotEmpty
          ? FlexibleTable(
              rowCount: data.length,
              columns: [
                FlexibleColumn(
                  title: 'GradesHistoryScreen.Grade'.tr(),
                  width: 0,
                  align: TextAlign.center,
                ),
                FlexibleColumn(
                  title: 'GradesHistoryScreen.Date'.tr(),
                  width: 0,
                  align: TextAlign.center,
                ),
              ],
              textBuilder: (column, row) => switch (column) {
                0 => data[row].$1,
                1 => _formatDate(data[row].$2),
                _ => '',
              },
            )
          : EmptyPlaceholder(text: 'GradesHistoryScreen.NoData'.tr()),
    );
  }

  GradesHistory _getData(WidgetRef ref) {
    return ref.read(periodsProvider.notifier).getGradesHistory(subject, start, end);
  }

  String _formatDate(DateTime date) {
    return DateFormat.yMd().format(date);
  }
}
