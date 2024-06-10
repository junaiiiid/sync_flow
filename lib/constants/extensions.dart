import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'enums.dart';

extension Context on BuildContext {
  T read<T>(ProviderBase<T> provider) {
    return ProviderScope.containerOf(this, listen: false).read(provider);
  }
}

extension PaddedInt on int {
  String toPaddedString() {
    // If the integer is less than 10, pad it with a leading zero
    return this < 10 ? '0$this' : '$this';
  }
}

extension APITypeExtension on ApiType {
  String getUrl() {
    switch (this) {
      case ApiType.getAUsersProject:
        return '/projects';
      case ApiType.getAllComments:
        return '/comments';
      case ApiType.getAllPersonalLabels:
        return '/labels';
      case ApiType.getActiveTasks:
        return '/tasks';
      case ApiType.getAllSections:
        return '/sections';
      default:
        return '/pp2e';
    }
  }
}


extension DateTimeFormatting on String {
  String toFormattedDate() {
    // Parse the date string into a DateTime object
    DateTime dateTime = DateTime.parse(this);

    // Define the desired format
    DateFormat formatter = DateFormat('EEEE, MMM d, yyyy h:mm a');

    // Format the DateTime object into the desired format
    return formatter.format(dateTime.toLocal());
  }
}

extension StringToColor on String {
  Color toColor() {
    switch (this) {
      case 'berry_red':
        return const Color(0xFFB8256F);
      case 'red':
        return const Color(0xFFDB4035);
      case 'orange':
        return const Color(0xFFFF9933);
      case 'yellow':
        return const Color(0xFFFAD000);
      case 'olive_green':
        return const Color(0xFFAFB83B);
      case 'lime_green':
        return const Color(0xFF7ECC49);
      case 'green':
        return const Color(0xFF299438);
      case 'mint_green':
        return const Color(0xFF6ACCBC);
      case 'teal':
        return const Color(0xFF158FAD);
      case 'sky_blue':
        return const Color(0xFF14AAF5);
      case 'light_blue':
        return const Color(0xFF96C3EB);
      case 'blue':
        return const Color(0xFF4073FF);
      case 'grape':
        return const Color(0xFF884DFF);
      case 'violet':
        return const Color(0xFFAF38EB);
      case 'lavender':
        return const Color(0xFFEB96EB);
      case 'magenta':
        return const Color(0xFFE05194);
      case 'salmon':
        return const Color(0xFFFF8D85);
      case 'charcoal':
        return const Color(0xFF808080);
      case 'grey':
        return const Color(0xFFB8B8B8);
      case 'taupe':
        return const Color(0xFFCCAC93);
      default:
        return Colors.white;
    }
  }
}

extension LightenColor on Color {
  Color lighten([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1, 'amount should be between 0 and 1');
    final hsl = HSLColor.fromColor(this);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }
}