import 'package:flutter/material.dart';

import 'package:homework_planner/helpers/helpers.dart';

class EmptyPlaceholder extends StatelessWidget {
  final String text;

  const EmptyPlaceholder({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: context.textLarge(text),
    );
  }
}
