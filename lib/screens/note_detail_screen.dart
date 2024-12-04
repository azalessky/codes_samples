import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:homework_planner/common/common.dart';
import 'package:homework_planner/helpers/helpers.dart';
import 'package:homework_planner/providers/providers.dart';
import 'package:homework_planner/dialogs/dialogs.dart';
import 'package:homework_planner/widgets/widgets.dart';

@RoutePage()
class NoteDetailScreen extends ConsumerStatefulWidget {
  final String? noteId;

  const NoteDetailScreen({this.noteId, super.key});

  @override
  ConsumerState<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends ConsumerState<NoteDetailScreen> {
  final formKey = GlobalKey<FormState>();
  final textNode = FocusNode();
  String? noteText;
  late bool editMode;

  @override
  void initState() {
    if (widget.noteId != null) {
      final note = ref.read(notesProvider.notifier).getItem(widget.noteId!);
      noteText = note?.text;
    }
    editMode = widget.noteId == null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('NoteDetailScreen.Title'.tr()),
        actions: [
          if (widget.noteId != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => showModalBottomSheet(
                context: context,
                builder: (_) => PromptDialog(
                  title: 'NoteDetailScreen.DeleteTitle'.tr(),
                  text: 'NoteDetailScreen.DeletePrompt'.tr(),
                ),
              ).then((value) => value != null && value ? _deleteNote() : 0),
            ),
        ],
      ),
      body: Padding(
        padding: FormLayout.contentPadding,
        child: Form(
          key: formKey,
          child: TextFormField(
            focusNode: textNode,
            autofocus: editMode,
            maxLines: 8,
            initialValue: noteText,
            inputFormatters: [LengthLimitingTextInputFormatter(FieldConstraints.noteTextLength)],
            decoration: InputDecoration(hintText: 'NoteDetailScreen.TextHint'.tr()),
            textCapitalization: TextCapitalization.sentences,
            onSaved: (value) => noteText = value,
            onTap: () => setState(() => editMode = true),
            validator: RequiredValidator(errorText: 'NoteDetailScreen.TextError'.tr()).call,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: _submitForm,
        child: Icon(editMode ? Icons.save : Icons.edit),
      ),
    );
  }

  void _deleteNote() {
    ref.read(notesProvider.notifier).removeItem(widget.noteId!);
    FocusManager.instance.primaryFocus?.unfocus();
    context.maybePop();
    logEvent(AnalyticsEvent.notesDeleteItem);
  }

  void _submitForm() {
    if (editMode) {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        context.maybePop();

        if (widget.noteId == null) {
          ref.read(notesProvider.notifier).addNote(noteText!);
          logEvent(AnalyticsEvent.notesAddItem);
        } else {
          ref.read(notesProvider.notifier).updateNote(widget.noteId!, noteText!);
          logEvent(AnalyticsEvent.notesUpdateItem);
        }
      }
    } else {
      setState(() {
        editMode = true;
        textNode.requestFocus();
      });
    }
  }
}
