import 'dart:io';

import 'package:flutter/material.dart';

import 'package:homework_planner/common/common.dart';

class GenericDialog extends StatelessWidget {
  final String? title;
  final EdgeInsets contentPadding;
  final Widget Function(BuildContext) contentBuilder;
  final List<DialogActionButton>? actions;

  const GenericDialog({
    this.title,
    required this.contentPadding,
    required this.contentBuilder,
    this.actions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Platform.isIOS ? DialogPaddings.iOSDialog : DialogPaddings.androidDialog,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null)
            Padding(
              padding: DialogPaddings.dialogTitle,
              child: Text(title!, style: Theme.of(context).textTheme.titleLarge),
            ),
          Padding(
            padding: contentPadding,
            child: contentBuilder(context),
          ),
          if (actions?.isNotEmpty == true) _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: actions!,
        ),
      ],
    );
  }
}

class DialogActionButton extends StatelessWidget {
  final String title;
  final Function() onPressed;

  const DialogActionButton({
    required this.title,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextButton(
          onPressed: onPressed,
          child: Text(title),
        ),
      ),
    );
  }
}
