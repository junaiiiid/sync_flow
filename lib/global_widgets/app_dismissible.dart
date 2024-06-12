import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles_and_themes/app_colors.dart';

class AppDismissible extends StatelessWidget {
  final String id;
  final Widget child;
  final Function(DismissDirection)? onDismiss;
  const AppDismissible({super.key, required this.id, required this.child, this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        decoration: BoxDecoration(
          color: AppColors.error,
          borderRadius: BorderRadius.all(
            Radius.circular(10.r),
          ),
        ),
        child: Icon(
          Icons.delete_forever,
          size: 50.h,
        ),
      ),
      onDismissed: onDismiss,
      child: child,
    );
  }
}
