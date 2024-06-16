import 'package:flow_sync/services/language_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flow_sync/generated/l10n.dart';
import '../../../../constants/app_assets.dart';
import '../../../../styles_and_themes/app_text_styles.dart';

class BrandingLogoWidget extends StatelessWidget {
  const BrandingLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 25.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            LanguageService.getString.poweredBy,
            style: AppTextStyles.labelSmall,
          ),
          Transform.scale(
              scale: 0.7,
              child: SvgPicture.asset(AppAssets.flutterNinjaLogoLight)),
        ],
      ),
    );
  }
}
