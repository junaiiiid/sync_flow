import 'package:flow_sync/features/home/ui/widgets/custom_app_bar.dart';
import 'package:flow_sync/styles_and_themes/app_colors.dart';
import 'package:flutter/material.dart';

class CommentsScreen extends StatelessWidget {
  static const String id = "/comments";
  const CommentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.darkGrey,
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar.appBarWithBackButton(title: "Comments"),
          body: Column(),
        ),
      ),
    );
  }
}
