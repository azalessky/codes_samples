import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:homework_planner/styles/styles.dart';

class BackgroundImage extends StatelessWidget {
  final String image;

  const BackgroundImage({
    required this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return image.isEmpty
        ? Container()
        : ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: SvgPicture.asset(
              Backgrounds.getPath(Theme.of(context).brightness, image),
              fit: BoxFit.cover,
              alignment: Alignment.bottomRight,
            ),
          );
  }
}
