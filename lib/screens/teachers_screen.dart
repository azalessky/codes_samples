import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:homework_planner/common/common.dart';
import 'package:homework_planner/helpers/helpers.dart';
import 'package:homework_planner/models/models.dart';
import 'package:homework_planner/providers/providers.dart';
import 'package:homework_planner/widgets/widgets.dart';

@RoutePage()
class TeachersScreen extends ConsumerWidget {
  const TeachersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teachers = ref.watch(teachersProvider);
    logEvent(AnalyticsEvent.teachersShowList);

    return BackgroundScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('TeachersScreen.Title'.tr()),
      ),
      body: teachers.isNotEmpty
          ? _buildTeacherList(context, ref, teachers)
          : EmptyPlaceholder(text: 'TeachersScreen.NoData'.tr()),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => context.pushRoute(TeacherDetailRoute()),
      ),
    );
  }

  Widget _buildTeacherList(BuildContext context, WidgetRef ref, List<Teacher> teachers) {
    return ListView.builder(
      itemCount: teachers.length,
      itemBuilder: (context, index) {
        final teacher = teachers[index];

        return DismissibleTile(
          style: DismissibleStyle.deleteItem,
          promptTitle: teacher.name,
          promptText: 'TeachersScreen.DeletePrompt'.tr(),
          onDismissed: (_) => _deleteTeacher(ref, teacher.id),
          child: ListTile(
            key: ValueKey(teacher),
            leading: AvatarField(initialValue: teacher.avatar),
            title: Text(teacher.name),
            subtitle: Text(teacher.subject),
            onTap: () => context.pushRoute(TeacherDetailRoute(teacherId: teacher.id)),
          ),
        );
      },
    );
  }

  void _deleteTeacher(WidgetRef ref, String teacherId) {
    ref.read(teachersProvider.notifier).removeItem(teacherId);
    logEvent(AnalyticsEvent.teachersDeleteItem);
  }
}
