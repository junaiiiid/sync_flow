import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles_and_themes/app_colors.dart';
import '../styles_and_themes/app_text_styles.dart';

class AppTextFields {
  AppTextFields._();

  static Widget basicTextField(
      {required String title,
      required String hintText,
      String? Function(String?)? validator,
      required TextEditingController controller,
      EdgeInsetsGeometry? padding,
      int? maxLength,int? maxLines}) {
    return Padding(
      padding:
          padding ?? EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.labelLarge,
          ),
          Container(
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.r),
                ),
              ),
              padding: padding ??
                  EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.h),
              margin: EdgeInsets.symmetric(vertical: 10.h),
              child: TextFormField(
                validator: validator ??
                    (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field can not be empty';
                      }
                      return null;
                    },
                controller: controller,
                style: AppTextStyles.displaySmall,
                decoration: InputDecoration.collapsed(
                  hintStyle: AppTextStyles.displaySmall?.copyWith(
                    color: AppColors.darkGrey.withOpacity(0.5),
                  ),
                  hintText: hintText,
                ),
                maxLength: maxLength ?? 15,
                maxLines: maxLines??1,
              )),
        ],
      ),
    );
  }
}
