import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class ColorConverter implements JsonConverter<Color, String?> {
  const ColorConverter();

  @override
  Color fromJson(String? json) {
    try {
      return Color(int.parse(json!));
    } catch (e) {
      return Colors.blue.shade500;
    }
  }

  @override
  String? toJson(Color value) => value.value.toString().toUpperCase();
}
