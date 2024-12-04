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
class NotesScreen extends ConsumerWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(notesProvider);
    logEvent(AnalyticsEvent.notesShowList);

    return BackgroundScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('NotesScreen.Title').tr(),
      ),
      body: notes.isNotEmpty
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: _buildNoteList(context, ref, notes),
            )
          : EmptyPlaceholder(text: 'NotesScreen.NoData'.tr()),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => context.pushRoute(NoteDetailRoute()),
      ),
    );
  }

  Widget _buildNoteList(BuildContext context, WidgetRef ref, List<Note> notes) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (_, index) {
        final note = notes[index];

        return DismissibleTile(
          style: DismissibleStyle.deleteItem,
          verticalMargin: 8,
          promptTitle: 'NotesScreen.DeleteTitle'.tr(),
          promptText: 'NotesScreen.DeletePrompt'.tr(),
          onDismissed: (_) => _deleteNote(ref, note.id),
          child: NoteCard(
            note: note,
            onTap: () => context.pushRoute(NoteDetailRoute(noteId: note.id)),
          ),
        );
      },
    );
  }

  void _deleteNote(WidgetRef ref, String noteId) {
    ref.read(notesProvider.notifier).removeItem(noteId);
    logEvent(AnalyticsEvent.notesDeleteItem);
  }
}
