import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homework_planner/providers/providers.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image_picker/image_picker.dart';

import 'package:homework_planner/common/common.dart';
import 'package:homework_planner/helpers/helpers.dart';
import 'package:homework_planner/models/models.dart';
import 'package:homework_planner/widgets/widgets.dart';
import 'package:homework_planner/dialogs/dialogs.dart';

@RoutePage()
class HomeworkScreen extends ConsumerStatefulWidget {
  final Period period;

  const HomeworkScreen(this.period, {super.key});

  @override
  ConsumerState<HomeworkScreen> createState() => _HomeworkScreenState();
}

class _HomeworkScreenState extends ConsumerState<HomeworkScreen> {
  final formKey = GlobalKey<FormState>();
  final textNode = FocusNode();
  late String textValue;
  late Period state;
  late bool editMode;

  @override
  void initState() {
    state = widget.period;
    textValue = state.homework.text;
    editMode = textValue.isEmpty;

    logEvent(AnalyticsEvent.homeworkShow);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          state.subject.isEmpty ? 'HomeworkScreen.Title'.tr() : state.subject,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _shareButtonHandler(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: FormLayout.contentPadding,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Text(
                DateHelper.formatDayMonth(state.date),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              FormLayout.textSpacer,
              TextFormField(
                focusNode: textNode,
                autofocus: editMode,
                maxLines: 5,
                initialValue: state.homework.text,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(FieldConstraints.homeworkTexLength)
                ],
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: 'HomeworkScreen.Hint'.tr(),
                  suffixIconConstraints: const BoxConstraints(maxWidth: 40, maxHeight: 32),
                  suffixIcon: editMode
                      ? IconButton(
                          padding: const EdgeInsets.all(8),
                          icon: const Icon(Icons.photo_camera),
                          onPressed: () => _selectImageHandler(context),
                        )
                      : IconButton(
                          padding: const EdgeInsets.all(8),
                          icon: Icon(
                            state.homework.done ? Icons.check_circle : Icons.circle_outlined,
                          ),
                          onPressed: () => _markDoneHandler(context),
                        ),
                ),
                onChanged: (value) => textValue = value,
                onSaved: (value) =>
                    state = state.copyWith(homework: state.homework.copyWith(text: value!)),
                onTap: () => setState(() => editMode = true),
              ),
              ImageGallery(
                images: state.homework.images,
                onDelete: (value) => _deleteImage(value),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        child: Icon(editMode ? Icons.save : Icons.edit),
        onPressed: () => _actionButtonHandler(context),
      ),
    );
  }

  void _shareButtonHandler(BuildContext context) {
    if (state.homework.images.isNotEmpty) {
      showModalBottomSheet(
        context: context,
        builder: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
          return ValueListDialog(
            values: const [0, 1],
            textBuilder: (value) => switch (value) {
              0 => 'HomeworkScreen.ShareText'.tr(),
              1 => 'HomeworkScreen.ShareImages'.tr(),
              _ => '',
            },
          );
        },
      ).then((value) => value != null ? _shareHomework(value == 0) : 0);
    } else {
      _shareHomework(true);
    }
  }

  void _shareHomework(bool text) {
    if (text) {
      Share.share('${state.subject.isEmpty ? 'HomeworkScreen.Title'.tr() : state.subject}\n'
          '${DateHelper.formatDayMonth(state.date)}\n'
          '$textValue');
      logEvent(AnalyticsEvent.homeworkShareText);
    } else {
      Share.shareXFiles(
        state.homework.images.map((image) => XFile(image)).toList(),
        text: '${state.subject.isEmpty ? 'HomeworkScreen.Title'.tr() : state.subject}\n'
            '${DateHelper.formatDayMonth(state.date)}',
      );
      logEvent(AnalyticsEvent.homeworkShareImages);
    }
  }

  void _actionButtonHandler(BuildContext context) {
    if (editMode) {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();

        ref.read(periodsProvider.notifier).updatePeriod(state);
        logEvent(AnalyticsEvent.homeworkUpdate);

        context.maybePop();
      }
    } else {
      setState(() {
        editMode = true;
        textNode.requestFocus();
      });
    }
  }

  void _selectImageHandler(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        FocusManager.instance.primaryFocus?.unfocus();
        return ValueListDialog<ImageSource>(
          values: const [ImageSource.camera, ImageSource.gallery],
          textBuilder: (value) => switch (value) {
            ImageSource.camera => 'HomeworkScreen.TakePhoto'.tr(),
            ImageSource.gallery => 'HomeworkScreen.ChooseImage'.tr(),
          },
        );
      },
    ).then((value) => value != null ? _pickImage(value) : 0);
  }

  void _pickImage(ImageSource source) async {
    final imageFile = await ImagePicker().pickImage(source: source);
    if (imageFile != null) {
      setState(() {
        state = state.copyWith.homework(
          images: [...state.homework.images, imageFile.path],
        );
        logEvent(AnalyticsEvent.homeworkPickImage);
      });
    }
  }

  void _deleteImage(int index) async {
    setState(() {
      final images = state.homework.images.excludeAt(index);
      state = state.copyWith.homework(images: images);

      ref.read(periodsProvider.notifier).updatePeriod(state);
      logEvent(AnalyticsEvent.homeworkDeleteImage);
    });
  }

  void _markDoneHandler(BuildContext context) {
    state = state.copyWith.homework(done: !state.homework.done);
    ref.read(periodsProvider.notifier).updatePeriod(state);
    context.maybePop(state);

    if (state.homework.done) {
      showSnackBar(SnackBarStyle.info, 'HomeworkScreen.DoneMessage'.tr());
      logEvent(AnalyticsEvent.homeworkMarkDone);
    }
  }
}
