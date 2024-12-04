import 'package:flutter/material.dart';

class SwitchButton extends StatefulWidget {
  final int initialValue;
  final int maxValue;
  final Widget Function(int) iconBuilder;
  final Function(int) onPressed;

  const SwitchButton({
    required this.initialValue,
    required this.maxValue,
    required this.iconBuilder,
    required this.onPressed,
    super.key,
  });

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  late int currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => setState(() {
        currentValue = (currentValue + 1) % widget.maxValue;
        widget.onPressed(currentValue);
      }),
      icon: widget.iconBuilder(currentValue),
    );
  }
}
