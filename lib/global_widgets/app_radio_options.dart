import 'package:flow_sync/styles_and_themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles_and_themes/app_text_styles.dart';

class AppRadioOptions<T> extends StatelessWidget {
  final List<T> options;
  final T groupValue;
  final String title;
  final TextStyle? textStyle;
  final ValueChanged<T?> onChanged;
  final Widget Function(T) buildTitle;
  final Color? activeColor, hoverColor;

  const AppRadioOptions({
    super.key,
    required this.options,
    required this.groupValue,
    required this.onChanged,
    required this.buildTitle,
    required this.title,
    this.textStyle,
    this.activeColor,
    this.hoverColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 25.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textStyle ?? AppTextStyles.labelLarge,
          ),
          ...options.map((option) {
            return RadioListTile<T>(
              activeColor: activeColor ?? AppColors.cherryRed,
              hoverColor: hoverColor ?? AppColors.darkGrey,
              value: option,
              groupValue: groupValue,
              onChanged: onChanged,
              title: buildTitle(option),
            );
          }),
        ],
      ),
    );
  }
}
