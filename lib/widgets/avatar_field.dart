import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_avatar/random_avatar.dart';

class AvatarField extends FormField<String> {
  final double radius;

  AvatarField({
    super.initialValue,
    this.radius = 24,
    FormFieldSetter<String>? onSaved,
    super.key,
  }) : super(
          onSaved: (value) => onSaved?.call(value ?? ''),
          builder: (FormFieldState<String> state) {
            return GestureDetector(
              onTap: onSaved == null
                  ? null
                  : () {
                      final random = Random();
                      final value = List.generate(12, (_) => random.nextInt(10)).join();
                      state.didChange(value);
                    },
              child: state.value?.isNotEmpty == true
                  ? RandomAvatar(
                      state.value!,
                      trBackground: true,
                      width: radius * 2,
                      height: radius * 2,
                    )
                  : CircleAvatar(
                      radius: radius,
                      child: Icon(Icons.person, size: radius),
                    ),
            );
          },
        );
}
