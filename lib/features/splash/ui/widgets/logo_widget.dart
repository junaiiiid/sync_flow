import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/services/state_service.dart';
import 'package:flow_sync/styles_and_themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants/app_assets.dart';
import '../../../../styles_and_themes/app_text_styles.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.scale(scale: 2, child: SvgPicture.asset(AppAssets.logo)),
        SizedBox(
          height: 25.h,
        ),
        Text(
          "SyncFlow",
          style: AppTextStyles.titleSmall?.copyWith(
              color: AppColors.white),
        ),
      ],
    );
  }
}
