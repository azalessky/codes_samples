import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';

class Backgrounds {
  static String getName(String background) {
    return background.isEmpty ? 'Background.none'.tr() : 'Background.$background'.tr();
  }

  static String getPath(Brightness brightness, String background) {
    return 'assets/backgrounds/${background}_${brightness == Brightness.light ? "light" : "dark"}.svg';
  }

  static String getThumbPath(Brightness brightness, String background) {
    return 'assets/backgrounds/${background}_${brightness == Brightness.light ? "light_thumb" : "dark_thumb"}.svg';
  }

  static Future<Map<String, String>> getThumbs(Brightness brightness) async {
    final manifest = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> map = json.decode(manifest);

    final suffix = brightness == Brightness.light ? 'light_thumb' : 'dark_thumb';
    final pattern = RegExp(r'assets/backgrounds/(\w+)_' '$suffix' '.svg');
    final paths = map.keys.where((path) => pattern.hasMatch(path)).toList();

    Map<String, String> thumbs = {};
    for (final path in paths) {
      final match = pattern.firstMatch(path);
      thumbs[match!.group(1)!] = path;
    }

    return thumbs;
  }
}
