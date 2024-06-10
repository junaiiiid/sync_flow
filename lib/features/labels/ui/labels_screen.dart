import 'package:flutter/material.dart';

import '../../../styles_and_themes/app_colors.dart';
import '../../home/ui/widgets/custom_app_bar.dart';

class LabelsScreen extends StatelessWidget {
  static const String id = "/label";
  const LabelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.darkGrey,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.lightGrey,
          appBar: CustomAppBar.appBarWithBackButton(title: "Labels"),
        ),
      ),
    );
  }
}
