import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppButtons {
  AppButtons._();

  static Widget customIconButton(
      {required String iconPath,
      required Function() onTap,
      double? scaleFactor}) {
    return InkWell(
      onTap: onTap,
      child: Center(child: Transform.scale(
          scale: scaleFactor??0,
          child: SvgPicture.asset(iconPath))),
    );
  }
}
