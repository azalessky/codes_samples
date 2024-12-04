import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:homework_planner/helpers/helpers.dart';
import 'package:homework_planner/common/common.dart';
import 'package:homework_planner/widgets/widgets.dart';

@RoutePage()
class GradesScreen extends StatefulWidget {
  const GradesScreen({super.key});

  @override
  State<GradesScreen> createState() => _GradesScreenState();
}

class _GradesScreenState extends State<GradesScreen> {
  int selectedView = 0;

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          switch (selectedView) {
            0 => 'GradesScreen.TitleBook'.tr(),
            1 => 'GradesScreen.TitleReport'.tr(),
            _ => '',
          },
        ),
        actions: [
          SwitchButton(
            initialValue: selectedView,
            maxValue: 2,
            iconBuilder: (value) => switch (value) {
              0 => Icon(Icons.table_rows_outlined),
              1 => Icon(Icons.table_chart_outlined),
              _ => Icon(Icons.error_outlined),
            },
            onPressed: (value) => _switchView(value),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: switch (selectedView) {
              0 => const GradeBookView(),
              1 => const GradeReportView(),
              _ => const Placeholder(),
            },
          ),
        ],
      ),
    );
  }

  void _switchView(int view) {
    setState(() => selectedView = view);
    logEvent(AnalyticsEvent.gradesSelectView);
  }
}
