import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants/app_assets.dart';
import '../../../../styles_and_themes/app_colors.dart';

class ExtrasWidget extends StatefulWidget {
  const ExtrasWidget({super.key});

  @override
  State<ExtrasWidget> createState() => _ExtrasWidgetState();
}

class _ExtrasWidgetState extends State<ExtrasWidget> {
  String assetPath = AppAssets.add;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: AppColors.transparent,
      splashColor: AppColors.transparent,
      onTap: (){
        setState(() {
          assetPath = (assetPath==AppAssets.add)?AppAssets.subtract:AppAssets.add;
        });
      },
      child: Transform.scale(
        scale: 3,
        child: SvgPicture.asset(assetPath),
      ),
    );
  }
}
