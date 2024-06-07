import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../styles_and_themes/app_colors.dart';

class AppButtons {
  AppButtons._();

  static Widget customIconButton(
      {required String iconPath,
      required Function() onTap,
      double? scaleFactor}) {
    return InkWell(
      highlightColor: AppColors.transparent,
      splashColor: AppColors.transparent,
      onTap: onTap,
      child: Center(child: Transform.scale(
          scale: scaleFactor??1,
          child: SvgPicture.asset(iconPath))),
    );
  }
}
