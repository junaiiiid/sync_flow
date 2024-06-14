import 'package:flow_sync/styles_and_themes/app_colors.dart';
import 'package:flutter/material.dart';

import '../../home/ui/widgets/custom_app_bar.dart';

class CreateTaskScreen extends StatelessWidget {
  static const String id = '/create_task';
  const CreateTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.darkGrey,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.lightGrey,
          appBar: CustomAppBar.appBarWithBackButton(title: "title"),
        ),
      ),
    );
  }
}
