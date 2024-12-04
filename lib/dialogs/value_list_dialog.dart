import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:homework_planner/common/common.dart';

import 'generic_dialog.dart';

class ValueListDialog<T> extends StatelessWidget {
  static const contentFraction = 0.7;

  final String? title;
  final List<T> values;
  final String Function(T) textBuilder;
  final T? initialValue;
  final AlignmentGeometry alignment;
  final bool clearButton;

  const ValueListDialog({
    this.title,
    required this.values,
    required this.textBuilder,
    this.initialValue,
    this.alignment = Alignment.centerLeft,
    this.clearButton = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GenericDialog(
      title: title,
      contentPadding: DialogPaddings.valueContent,
      contentBuilder: _buildContent,
      actions: [
        if (clearButton)
          DialogActionButton(
            title: 'Button.Clear'.tr(),
            onPressed: () => context.maybePop(''),
          ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return LimitedBox(
      maxHeight: MediaQuery.of(context).size.height * contentFraction,
      child: SingleChildScrollView(
        child: Column(
          children: values
              .map((value) => ListTile(
                    contentPadding: DialogPaddings.valueTile,
                    title: Align(
                      alignment: alignment,
                      child: Text(
                        textBuilder(value),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    leading: alignment == Alignment.center ? const Icon(null) : null,
                    trailing: Icon(value == initialValue ? Icons.check : null),
                    onTap: () => context.maybePop(value),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
