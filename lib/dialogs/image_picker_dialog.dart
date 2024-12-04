import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:homework_planner/common/common.dart';
import 'package:homework_planner/styles/styles.dart';
import 'package:homework_planner/widgets/widgets.dart';

import 'generic_dialog.dart';

class ImagePickerDialog extends StatefulWidget {
  static const imageWidth = 240.0;
  static const imageHeight = 180.0;

  final String title;
  final String initialValue;

  const ImagePickerDialog({
    required this.title,
    required this.initialValue,
    super.key,
  });

  @override
  State<ImagePickerDialog> createState() => _ImagePickerDialogState();
}

class _ImagePickerDialogState extends State<ImagePickerDialog> {
  late List<String> backgrounds;
  late String selection;

  @override
  void initState() {
    selection = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GenericDialog(
      title: widget.title,
      contentPadding: DialogPaddings.pickerContent,
      contentBuilder: _buildContent,
      actions: [
        DialogActionButton(
          title: 'Button.Save'.tr(),
          onPressed: () => context.maybePop(selection),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return FutureBuilder(
      future: Backgrounds.getThumbs(Theme.of(context).brightness),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          backgrounds = snapshot.data!.keys.toList();
          backgrounds.insert(0, '');
          final images = snapshot.data!.values.toList();
          return ImageCarousel(
            initialPage: backgrounds.indexOf(widget.initialValue),
            images: images,
            imageWidth: ImagePickerDialog.imageWidth,
            imageHeight: ImagePickerDialog.imageHeight,
            onPageChanged: (index) => selection = backgrounds[index],
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
