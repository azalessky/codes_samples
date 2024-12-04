import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:homework_planner/dialogs/dialogs.dart';

enum DismissibleStyle { deleteItem, markDone }

class DismissibleTile extends StatelessWidget {
  final DismissibleStyle style;
  final double verticalMargin;
  final String? promptTitle;
  final String? promptText;
  final DismissDirectionCallback? onDismissed;
  final Widget child;

  const DismissibleTile({
    required this.style,
    this.verticalMargin = 4,
    this.promptTitle,
    this.promptText,
    this.onDismissed,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: _buildBackground(context, Alignment.centerLeft),
      secondaryBackground: _buildBackground(context, Alignment.centerRight),
      direction: DismissDirection.horizontal,
      confirmDismiss: promptTitle != null && promptText != null
          ? (_) => showModalBottomSheet(
                context: context,
                builder: (_) => PromptDialog(
                  title: promptTitle!,
                  text: promptText!,
                ),
              )
          : null,
      onDismissed: onDismissed,
      child: child,
    );
  }

  Widget _buildBackground(BuildContext context, AlignmentGeometry alignment) {
    final style = _widgetStyle(context);

    return Container(
      color: style.$1,
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: verticalMargin),
      child: FaIcon(style.$3, color: style.$2, size: 20),
    );
  }

  (Color, Color, IconData) _widgetStyle(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return switch (style) {
      DismissibleStyle.deleteItem => (
          colorScheme.error,
          colorScheme.onError,
          FontAwesomeIcons.trashCan,
        ),
      DismissibleStyle.markDone => (
          colorScheme.primary,
          colorScheme.onPrimary,
          FontAwesomeIcons.check,
        ),
    };
  }
}
