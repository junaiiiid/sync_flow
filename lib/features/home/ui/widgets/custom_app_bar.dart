import 'package:flow_sync/constants/app_assets.dart';
import 'package:flow_sync/constants/numeric_constants.dart';
import 'package:flow_sync/global_widgets/app_buttons.dart';
import 'package:flow_sync/services/state_service.dart';
import 'package:flow_sync/styles_and_themes/app_colors.dart';
import 'package:flow_sync/styles_and_themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar {
  CustomAppBar._();

  static PreferredSize myAppBar({required String title}) {
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
                  title,
                  style: AppTextStyles.titleMedium
                      ?.copyWith(color: AppColors.lightGrey),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppButtons.customIconButton(
                    iconPath: AppAssets.userIcon,
                    onTap: () {},
                    scaleFactor: NumericConstants.appBarElementsScaleFactor),
                AppButtons.customIconButton(
                    iconPath: AppAssets.notificationEmptyIcon,
                    onTap: () {},
                    scaleFactor: NumericConstants.appBarElementsScaleFactor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static PreferredSize appBarWithBackButton({required String title,Color? color}) {
    return PreferredSize(
      preferredSize: Size.fromHeight(80.h),
      child: Container(
        color: color??AppColors.darkGrey,
        padding: NumericConstants.appBarPadding,
        child: Stack(
          children: [
            Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: AppTextStyles.titleMedium
                      ?.copyWith(color: AppColors.lightGrey),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: IconButton(
                      onPressed: () {
                        StateService.context.pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.lightGrey,
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
