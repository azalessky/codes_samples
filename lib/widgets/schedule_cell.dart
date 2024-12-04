import 'package:flutter/material.dart';

class ScheduleCell extends StatelessWidget {
  final String? text;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final AlignmentGeometry alignment;
  final Icon? icon;
  final Function()? onTap;

  const ScheduleCell({
    required this.text,
    this.textStyle,
    this.padding,
    this.alignment = Alignment.center,
    this.icon,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Align(
                alignment: alignment,
                child: Text(
                  text ?? '',
                  maxLines: 3,
                  style: textStyle,
                ),
              ),
            ),
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: icon!,
              )
          ],
        ),
      ),
    );
  }
}
