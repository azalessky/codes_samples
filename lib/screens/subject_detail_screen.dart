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
class SubjectDetailScreen extends ConsumerStatefulWidget {
  final String? subjectId;

  const SubjectDetailScreen({this.subjectId, super.key});

  @override
  ConsumerState<SubjectDetailScreen> createState() => _SubjectDetailScreenState();
}

class _SubjectDetailScreenState extends ConsumerState<SubjectDetailScreen> {
  final formKey = GlobalKey<FormState>();
  String? subjectName;
  String? subjectRoom;

  @override
  void initState() {
    if (widget.subjectId != null) {
      final subject = ref.read(subjectsProvider.notifier).getItem(widget.subjectId!);
      subjectName = subject?.name;
      subjectRoom = subject?.room;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('SubjectDetailScreen.Title'.tr()),
        actions: [
          if (widget.subjectId != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => showModalBottomSheet(
                context: context,
                builder: (_) => PromptDialog(
                  title: subjectName!,
                  text: 'SubjectDetailScreen.DeletePrompt'.tr(),
                ),
              ).then((value) => value != null && value ? _deleteSubject() : 0),
            ),
        ],
      ),
      body: Padding(
        padding: FormLayout.contentPadding,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                autofocus: true,
                initialValue: subjectName,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(FieldConstraints.subjectNameLength)
                ],
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(hintText: 'SubjectDetailScreen.NameHint'.tr()),
                onSaved: (value) => subjectName = value!,
                validator: RequiredValidator(errorText: 'SubjectDetailScreen.NameError'.tr()).call,
              ),
              FormLayout.textSpacer,
              TextFormField(
                initialValue: subjectRoom,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(FieldConstraints.subjectRoomLength)
                ],
                keyboardType: TextInputType.text,
                decoration: InputDecoration(hintText: 'SubjectDetailScreen.RoomHint'.tr()),
                onSaved: (value) => subjectRoom = value!,
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

  void _deleteSubject() {
    ref.read(subjectsProvider.notifier).removeItem(widget.subjectId!);
    FocusManager.instance.primaryFocus?.unfocus();
    context.maybePop();
    logEvent(AnalyticsEvent.subjectsDeleteItem);
  }

  void _submitForm() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      context.maybePop();

      if (widget.subjectId == null) {
        ref.read(subjectsProvider.notifier).addSubject(subjectName!, subjectRoom!);
        logEvent(AnalyticsEvent.subjectsAddItem);
      } else {
        ref
            .read(subjectsProvider.notifier)
            .updateSubject(widget.subjectId!, subjectName!, subjectRoom!);
        logEvent(AnalyticsEvent.subjectsUpdateItem);
      }
    }
  }
}
