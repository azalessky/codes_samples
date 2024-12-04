import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:homework_planner/providers/providers.dart';

class AssignmentsBadge extends ConsumerWidget {
  final Widget child;

  const AssignmentsBadge({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(periodsProvider);
    final periods = ref.read(periodsProvider.notifier).getAssignments();

    return Badge.count(
      isLabelVisible: periods.isNotEmpty,
      count: periods.length,
      child: child,
    );
  }
}
