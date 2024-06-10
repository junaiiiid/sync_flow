import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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