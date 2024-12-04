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
class TeacherDetailScreen extends ConsumerStatefulWidget {
  final String? teacherId;

  const TeacherDetailScreen({this.teacherId, super.key});

  @override
  ConsumerState<TeacherDetailScreen> createState() => _TeacherDetailScreenState();
}

class _TeacherDetailScreenState extends ConsumerState<TeacherDetailScreen> {
  final formKey = GlobalKey<FormState>();
  String? teacherName;
  String? teacherSubject;
  String? teacherNote;
  String? teacherAvatar;

  @override
  void initState() {
    if (widget.teacherId != null) {
      final teacher = ref.read(teachersProvider.notifier).getItem(widget.teacherId!);
      teacherName = teacher?.name;
      teacherSubject = teacher?.subject;
      teacherNote = teacher?.note;
      teacherAvatar = teacher?.avatar;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final subjects = ref.read(subjectsProvider.notifier).names;

    return BackgroundScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('TeacherDetailScreen.Title'.tr()),
        actions: [
          if (widget.teacherId != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => showModalBottomSheet(
                context: context,
                builder: (_) => PromptDialog(
                  title: teacherName!,
                  text: 'TeacherDetailScreen.DeletePrompt'.tr(),
                ),
              ).then((value) => value != null && value ? _deleteTeacher() : 0),
            ),
        ],
      ),
      body: Padding(
        padding: FormLayout.contentPadding,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              AvatarField(
                initialValue: teacherAvatar,
                radius: 32,
                onSaved: (value) => teacherAvatar = value,
              ),
              FormLayout.largeSpacer,
              TextFormField(
                autofocus: true,
                initialValue: teacherName,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(FieldConstraints.teacherNameLength)
                ],
                decoration: InputDecoration(hintText: 'TeacherDetailScreen.NameHint'.tr()),
                textCapitalization: TextCapitalization.sentences,
                onSaved: (value) => teacherName = value,
                validator: RequiredValidator(errorText: 'TeacherDetailScreen.NameError'.tr()).call,
              ),
              FormLayout.textSpacer,
              DropdownField<String>(
                values: subjects,
                initialValue: teacherSubject,
                hintText: 'TeacherDetailScreen.SubjectHint'.tr(),
                errorText: 'TeacherDetailScreen.SubjectError'.tr(),
                textBuilder: (value) => value,
                onSaved: (value) => teacherSubject = value,
              ),
              FormLayout.textSpacer,
              TextFormField(
                initialValue: teacherNote,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(FieldConstraints.teacherNoteLength)
                ],
                decoration: InputDecoration(hintText: 'TeacherDetailScreen.NoteHint'.tr()),
                textCapitalization: TextCapitalization.sentences,
                onSaved: (value) => teacherNote = value,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitForm,
        child: const Icon(Icons.save),
      ),
    );
  }

  void _deleteTeacher() {
    ref.read(teachersProvider.notifier).removeItem(widget.teacherId!);
    FocusManager.instance.primaryFocus?.unfocus();
    context.maybePop();
    logEvent(AnalyticsEvent.teachersDeleteItem);
  }

  void _submitForm() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      context.maybePop();

      if (widget.teacherId == null) {
        ref.read(teachersProvider.notifier).addTeacher(
              teacherName!,
              teacherSubject!,
              teacherNote!,
              teacherAvatar!,
            );
        logEvent(AnalyticsEvent.teachersAddItem);
      } else {
        ref.read(teachersProvider.notifier).updateTeacher(
              widget.teacherId!,
              teacherName!,
              teacherSubject!,
              teacherNote!,
              teacherAvatar!,
            );
        logEvent(AnalyticsEvent.teachersUpdateItem);
      }
    }
  }
}
