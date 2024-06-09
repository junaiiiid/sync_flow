import 'package:flow_sync/constants/app_assets.dart';
import 'package:flow_sync/services/state_service.dart';
import 'package:flow_sync/styles_and_themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class AppPopups {
  AppPopups._();

  static Future<void> showLoader() async {
    return showDialog<void>(
      context: StateService.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: Container(
             height: 150.h,
              decoration: BoxDecoration(
                color: AppColors.darkGrey,
                borderRadius: BorderRadius.all(Radius.circular(10.r),),
              ),
              child: Lottie.asset(AppAssets.loaderAnimation)),
        );
      },
    );
  }
}
