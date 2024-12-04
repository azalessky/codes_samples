import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeField extends StatefulWidget {
  final DateTime? initialValue;
  final DateTime minValue;
  final DateTime maxValue;
  final String hintText;
  final String errorText;
  final Function(DateTime?) onSaved;

  const DateTimeField({
    required this.initialValue,
    required this.minValue,
    required this.maxValue,
    required this.hintText,
    required this.errorText,
    required this.onSaved,
    super.key,
  });

  @override
  State<DateTimeField> createState() => _DateTimeFieldState();
}

class _DateTimeFieldState extends State<DateTimeField> {
  late DateTime? selectedValue;

  @override
  void initState() {
    selectedValue = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: ValueKey(selectedValue),
      initialValue: selectedValue != null ? DateFormat.yMMMMd().format(selectedValue!) : null,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIconConstraints: const BoxConstraints(maxWidth: 32, maxHeight: 32),
        suffixIcon: const Padding(
          padding: EdgeInsetsDirectional.only(end: 12.0),
          child: Icon(Icons.arrow_drop_down, size: 24),
        ),
      ),
      readOnly: true,
      onSaved: (value) => widget.onSaved(selectedValue),
      validator: (value) => value?.isNotEmpty == true ? null : widget.errorText,
      onTap: () => showDatePicker(
        context: context,
        initialDate: selectedValue ?? calcInitialDate(widget.minValue, widget.maxValue),
        firstDate: widget.minValue,
        lastDate: widget.maxValue,
      ).then((value) => value != null ? setState(() => widget.onSaved(selectedValue = value)) : 0),
    );
  }

  DateTime calcInitialDate(DateTime min, DateTime max) {
    final today = DateUtils.dateOnly(DateTime.now());
    return today.isBefore(min)
        ? min
        : today.isAfter(max)
            ? max
            : today;
  }
}
