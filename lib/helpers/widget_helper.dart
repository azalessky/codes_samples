import 'package:flutter/material.dart';

enum SnackBarStyle { info, error }

class MessengerHelper {
  final messengerKey = GlobalKey<ScaffoldMessengerState>();

  void showSnackBar(SnackBarStyle style, String text) {
    final delay = switch (style) {
      SnackBarStyle.info => 1000,
      SnackBarStyle.error => 2000,
    };
    messengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(text),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.zero,
        duration: Duration(milliseconds: delay),
      ),
    );
  }
}

extension BuildContextExtension on BuildContext {
  Text textCentered(String text) => Text(
        text,
        textAlign: TextAlign.center,
      );

  Text textError(String text) => Text(
        text,
        style: TextStyle(color: Theme.of(this).colorScheme.error),
        textAlign: TextAlign.center,
      );

  Text textSmall(String text) => Text(
        text,
        style: Theme.of(this).textTheme.bodySmall,
      );

  Text textMedium(String text) => Text(
        text,
        style: Theme.of(this).textTheme.bodyMedium,
      );
  Text textLarge(String text) => Text(
        text,
        style: Theme.of(this).textTheme.bodyLarge,
      );
}
