import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:homework_planner/helpers/analytics_helper.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:homework_planner/common/common.dart';
import 'package:homework_planner/helpers/helpers.dart';
import 'package:homework_planner/dialogs/dialogs.dart';

class ImageGallery extends StatelessWidget {
  final List<String> images;
  final Function(int) onDelete;

  const ImageGallery({
    required this.images,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      height: 400,
      child: GridView.builder(
        itemCount: images.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (_, index) => GridTile(
          child: GestureDetector(
            child: Image.file(File(images[index]), fit: BoxFit.cover),
            onTap: () => _viewImage(context, images[index]),
            onLongPress: () => showModalBottomSheet(
              context: context,
              builder: (_) => PromptDialog(
                title: _getImageDate(index),
                text: 'HomeworkScreen.DeletePrompt'.tr(),
              ),
            ).then((value) => value != null && value ? _deleteImage(index) : 0),
          ),
        ),
      ),
    );
  }

  void _viewImage(BuildContext context, String image) {
    context.pushRoute(ImageRoute(image: image));
    logEvent(AnalyticsEvent.homeworkViewImage);
  }

  void _deleteImage(int index) {
    onDelete(index);
    logEvent(AnalyticsEvent.homeworkDeleteImage);
  }

  String _getImageDate(int index) {
    DateTime date = File(images[index]).lastModifiedSync();
    return DateFormat.yMd().add_jm().format(date);
  }
}
