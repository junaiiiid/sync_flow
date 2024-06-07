import 'package:flow_sync/constants/app_assets.dart';
import 'package:flow_sync/constants/numeric_constants.dart';
import 'package:flow_sync/global_widgets/app_buttons.dart';
import 'package:flow_sync/styles_and_themes/app_colors.dart';
import 'package:flow_sync/styles_and_themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar {
  CustomAppBar._();

  static PreferredSize myAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(80.h),
      child: Container(
        color: AppColors.darkGrey,
        padding: NumericConstants.appBarPadding,
        child: Stack(
          children: [
            Align(
                alignment: Alignment.center,
                child: Text(
                  "Hello",
                  style: AppTextStyles.titleLarge
                      ?.copyWith(color: AppColors.lightGrey),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppButtons.customIconButton(
                    iconPath: AppAssets.userIcon,
                    onTap: () {},
                    scaleFactor: 1.5),
                AppButtons.customIconButton(
                    iconPath: AppAssets.notificationEmptyIcon,
                    onTap: () {},
                    scaleFactor: 1.5),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
