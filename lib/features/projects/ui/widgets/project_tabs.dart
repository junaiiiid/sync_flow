import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../styles_and_themes/app_colors.dart';
import '../../../../styles_and_themes/app_text_styles.dart';

class ProjectTabs extends StatelessWidget {
  final String assetName,title;
  const ProjectTabs({super.key, required this.assetName, required this.title});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            assetName,
            color: LightModeColors.red,
          ),
          Text(
            title,
            style:
            AppTextStyles.labelSmall?.copyWith(color: LightModeColors.grey),
          )
        ],
      ),
    );
  }
}
