import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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