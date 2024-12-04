import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:homework_planner/common/common.dart';
import 'package:homework_planner/models/models.dart';
import 'package:homework_planner/providers/terms.dart';
import 'package:homework_planner/helpers/helpers.dart';
import 'package:homework_planner/dialogs/dialogs.dart';
import 'package:homework_planner/widgets/widgets.dart';

@RoutePage()
class TermDetailScreen extends ConsumerStatefulWidget {
  final String? termId;

  const TermDetailScreen({this.termId, super.key});

  @override
  ConsumerState<TermDetailScreen> createState() => _TermDetailScreenState();
}

class _TermDetailScreenState extends ConsumerState<TermDetailScreen> {
  final formKey = GlobalKey<FormState>();
  TermType? termType;
  String? termName;
  DateTime? termStart;
  DateTime? termEnd;

  @override
  void initState() {
    if (widget.termId != null) {
      final term = ref.read(termsProvider.notifier).getItem(widget.termId!);
      termType = term?.type;
      termName = term?.name;
      termStart = term?.start;
      termEnd = term?.end;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('TermDetailScreen.Title'.tr()),
        actions: [
          if (widget.termId != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => showModalBottomSheet(
                context: context,
                builder: (_) => PromptDialog(
                  title: termName!,
                  text: 'TermDetailScreen.DeletePrompt'.tr(),
                ),
              ).then((value) => value != null && value ? _deleteTerm() : 0),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: FormLayout.contentPadding,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              DropdownField<TermType>(
                values: TermType.values,
                initialValue: termType,
                hintText: 'TermDetailScreen.TypeHint'.tr(),
                errorText: 'TermDetailScreen.TypeError'.tr(),
                textBuilder: (value) => 'TermDetailScreen.${value.toString()}'.tr(),
                onSaved: (value) => termType = value,
              ),
              FormLayout.textSpacer,
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: termName,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(FieldConstraints.termNameLength)
                ],
                decoration: InputDecoration(hintText: 'TermDetailScreen.NameHint'.tr()),
                textCapitalization: TextCapitalization.sentences,
                onSaved: (value) => termName = value!,
                validator: RequiredValidator(errorText: 'TermDetailScreen.NameError'.tr()).call,
              ),
              FormLayout.textSpacer,
              DateTimeField(
                initialValue: termStart,
                minValue: DateHelper.minDate,
                maxValue: termEnd ?? DateHelper.maxDate,
                hintText: 'TermDetailScreen.StartHint'.tr(),
                errorText: 'TermDetailScreen.StartError'.tr(),
                onSaved: (value) => setState(() => termStart = value),
              ),
              FormLayout.textSpacer,
              DateTimeField(
                initialValue: termEnd,
                minValue: termStart ?? DateHelper.minDate,
                maxValue: DateHelper.maxDate,
                hintText: 'TermDetailScreen.EndHint'.tr(),
                errorText: 'TermDetailScreen.EndError'.tr(),
                onSaved: (value) => setState(() => termEnd = value),
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

  void _deleteTerm() {
    ref.read(termsProvider.notifier).removeItem(widget.termId!);
    FocusManager.instance.primaryFocus?.unfocus();
    context.maybePop();
    logEvent(AnalyticsEvent.termsDeleteItem);
  }

  void _submitForm() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      context.maybePop();

      final terms = ref.read(termsProvider.notifier);
      if (widget.termId == null) {
        if (terms.canAddTerm(termType!)) {
          terms.addTerm(
            termType!,
            termName!,
            termStart!,
            termEnd!,
          );
          logEvent(AnalyticsEvent.termsAddItem);
        } else {
          showSnackBar(SnackBarStyle.error, 'TermsScreen.TermLimit'.tr());
        }
      } else {
        if (terms.canUpdateTerm(widget.termId!, termType!)) {
          terms.updateTerm(
            widget.termId!,
            termType!,
            termName!,
            termStart!,
            termEnd!,
          );
          logEvent(AnalyticsEvent.termsUpdateItem);
        } else {
          showSnackBar(SnackBarStyle.error, 'TermsScreen.TermLimit'.tr());
        }
      }
    }
  }
}
