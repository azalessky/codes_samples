import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:homework_planner/common/common.dart';
import 'package:homework_planner/helpers/helpers.dart';
import 'package:homework_planner/models/models.dart';
import 'package:homework_planner/providers/providers.dart';
import 'package:homework_planner/dialogs/dialogs.dart';
import 'package:homework_planner/widgets/widgets.dart';

@RoutePage()
class SubjectsScreen extends ConsumerWidget {
  const SubjectsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjects = ref.watch(subjectsProvider);
    logEvent(AnalyticsEvent.subjectsShowList);

    return BackgroundScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('SubjectsScreen.Title').tr(),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (_) => PromptDialog(
                title: 'SubjectsScreen.ResetTitle'.tr(),
                text: 'SubjectsScreen.ResetPrompt'.tr(),
              ),
            ).then((value) => value != null && value ? _resetSubjects(ref) : 0),
          )
        ],
      ),
      body: subjects.isNotEmpty
          ? _buildSubjectList(context, ref, subjects)
          : EmptyPlaceholder(text: 'SubjectsScreen.NoData'.tr()),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => context.pushRoute(SubjectDetailRoute()),
      ),
    );
  }

  Widget _buildSubjectList(BuildContext context, WidgetRef ref, List<Subject> subjects) {
    return ListView.builder(
      itemCount: subjects.length,
      itemBuilder: (_, index) {
        final subject = subjects[index];

        return DismissibleTile(
          style: DismissibleStyle.deleteItem,
          promptTitle: subject.name,
          promptText: 'SubjectsScreen.DeletePrompt'.tr(),
          onDismissed: (_) => _deleteSubject(ref, subject.id),
          child: ListTile(
            key: ValueKey(subject),
            title: Text(subject.name),
            trailing: Text(
              subject.room,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            onTap: () => context.pushRoute(SubjectDetailRoute(subjectId: subject.id)),
          ),
        );
      },
    );
  }

  void _deleteSubject(WidgetRef ref, String subjectId) {
    ref.read(subjectsProvider.notifier).removeItem(subjectId);
    logEvent(AnalyticsEvent.subjectsDeleteItem);
  }

  void _resetSubjects(WidgetRef ref) {
    ref.read(subjectsProvider.notifier).resetData();
    logEvent(AnalyticsEvent.subjectsResetItems);
  }
}
