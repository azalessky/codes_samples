import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:homework_planner/common/common.dart';
import 'package:homework_planner/helpers/helpers.dart';
import 'package:homework_planner/models/models.dart';
import 'package:homework_planner/providers/providers.dart';
import 'package:homework_planner/widgets/widgets.dart';

@RoutePage()
class AssignmentsScreen extends ConsumerStatefulWidget {
  const AssignmentsScreen({super.key});

  @override
  ConsumerState<AssignmentsScreen> createState() => _AssignmentsScreenState();
}

class _AssignmentsScreenState extends ConsumerState<AssignmentsScreen> {
  late AppLifecycleListener listener;

  @override
  void initState() {
    super.initState();
    listener = AppLifecycleListener(onStateChange: _appStateHandler);
  }

  @override
  void dispose() {
    listener.dispose();
    super.dispose();
  }

  void _appStateHandler(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(periodsProvider);
    final periods = ref.read(periodsProvider.notifier).getAssignments();

    logEvent(AnalyticsEvent.assignmentsShowList);

    return BackgroundScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('AssignmentsScreen.Title').tr(),
      ),
      body: periods.isNotEmpty
          ? _buildAssignmentList(context, ref, periods)
          : EmptyPlaceholder(text: 'AssignmentsScreen.NoData'.tr()),
    );
  }

  Widget _buildAssignmentList(BuildContext context, WidgetRef ref, List<Period> periods) {
    return ListView.builder(
      itemCount: periods.length,
      itemBuilder: (_, index) {
        final period = periods[index];

        return DismissibleTile(
          style: DismissibleStyle.markDone,
          onDismissed: (_) => _completeAssignment(context, ref, period),
          child: ListTile(
            title: Text(period.subject),
            subtitle: Text(
              period.homework.text,
              maxLines: 3,
            ),
            trailing: Text(DateHelper.formatDaysAhead(period.date)),
            leadingAndTrailingTextStyle: Theme.of(context).textTheme.bodyMedium,
            onTap: () => context.pushRoute(HomeworkRoute(period: period)),
          ),
        );
      },
    );
  }

  void _completeAssignment(BuildContext context, WidgetRef ref, Period period) {
    final item = period.copyWith.homework(done: true);
    ref.read(periodsProvider.notifier).updatePeriod(item);

    showSnackBar(SnackBarStyle.info, 'AssignmentsScreen.DoneMessage'.tr());
    logEvent(AnalyticsEvent.assignmentsMarkDone);
  }
}
