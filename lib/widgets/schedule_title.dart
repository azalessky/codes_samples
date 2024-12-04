import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:homework_planner/helpers/helpers.dart';

enum ScheduleResetButton { hidden, left, right }

class ScheduleTitle extends StatelessWidget {
  final DateTime initialDate;
  final DateTime currentDate;
  final ScheduleResetButton resetButton;
  final Function() onPressed;

  const ScheduleTitle({
    required this.initialDate,
    required this.currentDate,
    required this.resetButton,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildResetButton(
          Icons.arrow_back,
          resetButton == ScheduleResetButton.left,
        ),
        Expanded(
          child: Text(
            _formatDate(),
            textAlign: TextAlign.center,
          ),
        ),
        _buildResetButton(
          Icons.arrow_forward,
          resetButton == ScheduleResetButton.right,
        )
      ],
    );
  }

  String _formatDate() {
    return currentDate.year == initialDate.year
        ? DateFormat.MMMM().format(currentDate).capitalized
        : DateFormat.yMMMM().format(currentDate).capitalized;
  }

  Widget _buildResetButton(IconData icon, bool showButton) {
    return LayoutBuilder(
      builder: (context, constraints) => Visibility(
        visible: showButton,
        replacement: SizedBox.fromSize(
          size: Size(
            AppBar().preferredSize.height,
            AppBar().preferredSize.height,
          ),
        ),
        child: IconButton(
          icon: Icon(icon),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
