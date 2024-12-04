import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Themes {
  final Map<Color, String> colors = {
    Colors.red.shade500: 'red',
    Colors.pink.shade500: 'pink',
    Colors.purple.shade500: 'purple',
    Colors.deepPurple.shade500: 'deepPurple',
    Colors.indigo.shade500: 'indigo',
    Colors.blue.shade500: 'blue',
    Colors.lightBlue.shade500: 'lightBlue',
    Colors.cyan.shade500: 'cyan',
    Colors.teal.shade500: 'teal',
    Colors.green.shade500: 'green',
    Colors.lightGreen.shade500: 'lightGreen',
    Colors.lime.shade500: 'lime',
    Colors.yellow.shade500: 'yellow',
    Colors.amber.shade500: 'amber',
    Colors.orange.shade500: 'orange',
    Colors.blueGrey.shade500: 'blueGrey',
  };

  ThemeData lightTheme(Color color, bool hasBackground) =>
      _buildTheme(Brightness.light, color, hasBackground);
  ThemeData darkTheme(Color color, bool hasBackground) =>
      _buildTheme(Brightness.dark, color, hasBackground);

  String getColorName(Color color) {
    return colors.containsKey(color) ? 'Color.${colors[color]}'.tr() : 'undefined';
  }

  SystemUiOverlayStyle getSystemUiOverlayStyle(
    ThemeMode themeMode,
    BuildContext context,
  ) {
    final brightness = switch (themeMode) {
      ThemeMode.light => Brightness.light,
      ThemeMode.dark => Brightness.dark,
      ThemeMode.system => MediaQuery.of(context).platformBrightness,
    };
    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: brightness == Brightness.light ? Brightness.dark : Brightness.light,
    );
  }

  ThemeData _buildTheme(Brightness brightness, Color color, bool hasBackground) {
    final themeData = ThemeData(
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(brightness: brightness, seedColor: color),
    );
    final colorScheme = themeData.colorScheme;

    InputBorder inputEnabledBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: colorScheme.outline, width: 0.5),
    );

    InputBorder errorInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: colorScheme.error),
    );

    return themeData.copyWith(
      scaffoldBackgroundColor:
          hasBackground ? Colors.transparent : themeData.scaffoldBackgroundColor,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        isDense: true,
        border: InputBorder.none,
        errorStyle: const TextStyle(height: 0),
        enabledBorder: inputEnabledBorder,
        focusedBorder: inputEnabledBorder,
        errorBorder: errorInputBorder,
        focusedErrorBorder: errorInputBorder,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      tabBarTheme: const TabBarTheme(
        dividerColor: Colors.transparent,
      ),
      navigationBarTheme: const NavigationBarThemeData(
        elevation: 0,
        backgroundColor: Colors.transparent,
        indicatorColor: Colors.transparent,
      ),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: colorScheme.outline, // Цвет рамки
          ),
        ),
      ),
    );
  }
}
