import 'package:flow_sync/styles_and_themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {

  AppTextStyles._();

  static TextStyle? displayLarge = GoogleFonts.montserrat(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: LightModeColors.black,
  );

  static TextStyle? displayMedium = GoogleFonts.montserrat(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: LightModeColors.black,
  );

  static TextStyle? displaySmall = GoogleFonts.montserrat(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: LightModeColors.black,
  );

  static TextStyle? headlineLarge = GoogleFonts.montserrat(
    fontSize: 22.sp,
    fontWeight: FontWeight.bold,
    color: LightModeColors.black,
  );

  static TextStyle? headlineMedium = GoogleFonts.montserrat(
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    color: LightModeColors.black,
  );

  static TextStyle? headlineSmall = GoogleFonts.montserrat(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: LightModeColors.black,
  );

  static TextStyle? titleLarge = GoogleFonts.montserrat(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: LightModeColors.black,
  );

  static TextStyle? titleMedium = GoogleFonts.montserrat(
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    color: LightModeColors.black,
  );

  static TextStyle? titleSmall = GoogleFonts.montserrat(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: LightModeColors.black,
  );

  static TextStyle? bodyLarge = GoogleFonts.montserrat(
    fontSize: 18.sp,
    color: LightModeColors.black,
  );

  static TextStyle? bodyMedium = GoogleFonts.montserrat(
    fontSize: 16.sp,
    color: LightModeColors.black,
  );

  static TextStyle? bodySmall = GoogleFonts.montserrat(
    fontSize: 14.sp,
    color: LightModeColors.black,
  );

  static TextStyle? labelLarge = GoogleFonts.montserrat(
    fontSize: 16.sp,
    color: LightModeColors.black,
  );

  static TextStyle? labelMedium = GoogleFonts.montserrat(
    fontSize: 14.sp,
    color: LightModeColors.black,
  );

  static TextStyle? labelSmall = GoogleFonts.montserrat(
    fontSize: 12.sp,
    color: LightModeColors.black,
  );
}