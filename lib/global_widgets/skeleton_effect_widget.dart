import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../styles_and_themes/app_colors.dart';

class SkeletonEffectWidget extends StatelessWidget {
  final Widget child;
  const SkeletonEffectWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: LightModeColors.red,
      highlightColor: LightModeColors.grey,
      child: child,
    );
  }
}
