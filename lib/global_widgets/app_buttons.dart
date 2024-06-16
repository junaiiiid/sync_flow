
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../styles_and_themes/app_colors.dart';
import '../styles_and_themes/app_text_styles.dart';

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
      child: Center(
          child: Transform.scale(
              scale: scaleFactor ?? 1, child: SvgPicture.asset(iconPath))),
    );
  }

  static Widget scaffoldIconButton(
      {IconData? iconData, required String title, required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cherryRed,
          borderRadius: BorderRadius.all(
            Radius.circular(10.r),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData ?? Icons.add,
              size: 30.h,
            ),
            Text(
              title,
              style: AppTextStyles.displayMedium,
            )
          ],
        ),
      ),
    );
  }

  static Widget customButton(
      {required String title,
      required Function() onTap,
      Color? buttonColor,
      TextStyle? textStyle}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: buttonColor ?? AppColors.cherryRed,
          borderRadius: BorderRadius.all(
            Radius.circular(20.r),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Center(
          child: Text(
            title,
            style: textStyle ?? AppTextStyles.displayLarge,
          ),
        ),
      ),
    );
  }

    static Widget roundedIconButton({required String title,required IconData iconData,required Function() onTap}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cherryRed,
          borderRadius: BorderRadius.all(
            Radius.circular(50.r),
          ),
        ),
        margin: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
        padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 30.w),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(onPressed: onTap, icon: Icon(iconData,color: AppColors.lightGrey,)),
              Text(
                title,
                style: AppTextStyles.labelLarge?.copyWith(color: AppColors.lightGrey),
              )
            ],
          ),
        ),
      ),
    );
    }
}
