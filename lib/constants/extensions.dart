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
      case ApiType.addANewProject:
      case ApiType.deleteAProject:
      case ApiType.updateProject:
        return '/projects';
      case ApiType.getAllComments:
      case ApiType.updateAComment:
      case ApiType.deleteAComment:
      case ApiType.createANewComment:
        return '/comments';
      case ApiType.getAllPersonalLabels:
      case ApiType.updateAPersonalLabel:
      case ApiType.createNewPersonalLabel:
      case ApiType.deleteAPersonalLabel:
        return '/labels';
      case ApiType.getActiveTasks:
      case ApiType.createANewTask:
        return '/tasks';
      case ApiType.getAllSections:
      case ApiType.createANewSection:
        return '/sections';
      default:
        return '/pp2e';
    }
  }
}

extension StringToDateTime on String {
  DateTime toDateTime() {
    DateFormat inputFormat = DateFormat('EEEE, MMM d, y h:mm a');
    return inputFormat.parse(this);
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

extension StringToColorName on String {
  String toColorName() {
    switch (this) {
      case 'berry_red':
        return 'Berry Red';
      case 'red':
        return 'Red';
      case 'orange':
        return 'Orange';
      case 'yellow':
        return 'Yellow';
      case 'olive_green':
        return 'Olive Green';
      case 'lime_green':
        return 'Lime Green';
      case 'green':
        return 'Green';
      case 'mint_green':
        return 'Mint Green';
      case 'teal':
        return 'Teal';
      case 'sky_blue':
        return 'Sky Blue';
      case 'light_blue':
        return 'Light Blue';
      case 'blue':
        return 'Blue';
      case 'grape':
        return 'Grape';
      case 'violet':
        return 'Violet';
      case 'lavender':
        return 'Lavender';
      case 'magenta':
        return 'Magenta';
      case 'salmon':
        return 'Salmon';
      case 'charcoal':
        return 'Charcoal';
      case 'grey':
        return 'Grey';
      case 'taupe':
        return 'Taupe';
      default:
        return 'Unknown Color';
    }
  }
}

extension LightenColor on Color {
  Color lighten([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1, 'amount should be between 0 and 1');
    final hsl = HSLColor.fromColor(this);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }
}

extension ViewStylesExtension on ViewStyles {
  String toShortString() {
    switch (this) {
      case ViewStyles.list:
        return 'list';
      case ViewStyles.board:
        return 'board';
      default:
        return '';
    }
  }
}

extension DateTimeExtension on DateTime {
  String toIso8601WithMillis() {
    final String year = this.year.toString().padLeft(4, '0');
    final String month = this.month.toString().padLeft(2, '0');
    final String day = this.day.toString().padLeft(2, '0');
    final String hour = this.hour.toString().padLeft(2, '0');
    final String minute = this.minute.toString().padLeft(2, '0');
    final String second = this.second.toString().padLeft(2, '0');
    final String millisecond = this.millisecond.toString().padLeft(3, '0');
    final String microsecond = this.microsecond.toString().padLeft(3, '0');

    return '$year-$month-${day}T$hour:$minute:$second.$millisecond${microsecond}Z';
  }
}
