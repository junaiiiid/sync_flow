import 'package:flutter/material.dart';

class LightModeColors{
  LightModeColors._();

  static const blue = Color(0xff08D9D6);
  static const grey = Color(0xff252A34);
  static const red = Color(0xffFF2E63);
  static const light = Color(0xffEAEAEA);
  static const black = Color(0xff000000);
  static const white = Color(0xffffffff);
  static const error = Color(0xffDB4035);
  static const success = Color(0xff6ACCBC);
  static const transparent = Colors.transparent;
}

class DarkModeColors {
  DarkModeColors._();

  static const blue = Color(0xff006C74); // Darker shade of light blue
  static const grey = Color(0xffEAEAEA); // Same as light mode, good for text on dark backgrounds
  static const red = Color(0xffFF5C77); // Slightly brighter red for dark mode
  static const light = Color(0xff1C1F26); // Darker grey for background elements
  static const white = Color(0xffffffff); // White for text and icons
  static const black = Color(0xff000000);
  static const coolBlack = Color(0xff111111);// Black for the darkest elements
  static const error = Color(0xffFF6F61); // Brightened error color
  static const success = Color(0xff1BBF97); // Brighter success color
  static const transparent = Colors.transparent; // Transparent color remains the same
}
