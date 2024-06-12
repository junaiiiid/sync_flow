import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles_and_themes/app_colors.dart';
import '../styles_and_themes/app_text_styles.dart';

class AppDropDowns {
  AppDropDowns._();

  static Widget customDropDown<T>({
    required String title,
    required List<T> items,
    T? selectedItem,
    required Function(T?) onChanged,
    required String hint,
    required Widget Function(T?) itemBuilder,
    String? Function(T?)? validator,
    Color? color,
    Color? iconColor,
    TextStyle? textStyle,
    TextStyle? titleTextStyle,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 25.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleTextStyle ?? AppTextStyles.labelLarge,
          ),
          SizedBox(
            width: double.infinity,
            child: DynamicDropDown<T>(
                validator: validator,
                items: items,
                selectedValue: selectedItem,
                onChanged: onChanged,
                hint: hint,
                color: color ?? AppColors.lightGrey,
                iconColor: iconColor ?? AppColors.darkGrey,
                hintStyle: textStyle ??
                    AppTextStyles.displaySmall?.copyWith(
                      color: AppColors.darkGrey.withOpacity(0.5),
                    ),
                itemBuilder: itemBuilder),
          ),
        ],
      ),
    );
  }
}

class DynamicDropDown<T> extends StatefulWidget {
  final T? selectedValue;
  final List<T> items;
  final ValueChanged<T?>? onChanged;
  final String hint;
  final Color? color;
  final Color? iconColor;
  final TextStyle? hintStyle;
  final String? Function(T?)? validator;
  final Widget Function(T) itemBuilder;

  const DynamicDropDown({
    super.key,
    this.selectedValue,
    required this.items,
    required this.onChanged,
    required this.hint,
    this.color,
    this.hintStyle,
    required this.itemBuilder,
    this.iconColor,
    this.validator,
  });

  @override
  _DynamicDropDownState<T> createState() => _DynamicDropDownState<T>();
}

class _DynamicDropDownState<T> extends State<DynamicDropDown<T>> {
  T? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.color ?? AppColors.cherryRed,
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
      ),
      margin: EdgeInsets.symmetric(
        vertical: 10.h,
      ),
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<T>(
          decoration: const InputDecoration(
            border: InputBorder.none,
            errorBorder: InputBorder.none,
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: widget.validator ??
              (value) {
                if (selectedValue == null) {
                  return 'Please select an option';
                }
                return null;
              },
          hint: Text(
            widget.hint,
            style: widget.hintStyle ??
                AppTextStyles.labelLarge?.copyWith(color: AppColors.lightGrey),
          ),
          dropdownColor: widget.color ?? AppColors.cherryRed,
          value: selectedValue,
          onChanged: (T? newValue) {
            if (widget.onChanged != null) {
              widget.onChanged!(newValue);
            }
            setState(() {
              selectedValue = newValue;
            });
          },
          icon: Icon(
            CupertinoIcons.arrowtriangle_down_circle_fill,
            color: widget.iconColor ?? AppColors.lightGrey,
          ),
          items: widget.items.map<DropdownMenuItem<T>>((T value) {
            return DropdownMenuItem<T>(
              value: value,
              child: widget.itemBuilder(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
