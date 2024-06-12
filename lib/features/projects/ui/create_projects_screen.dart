import 'package:flow_sync/features/home/ui/widgets/custom_app_bar.dart';
import 'package:flow_sync/global_widgets/app_text_fields.dart';
import 'package:flow_sync/styles_and_themes/app_colors.dart';
import 'package:flow_sync/styles_and_themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateProjectsScreen extends StatelessWidget {
  static const String id = '/create_project';
  const CreateProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.darkGrey,
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar.appBarWithBackButton(title: "NEW PROJECT"),
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: ListView(
              children: [
                AppTextFields.basicTextField(
                  title: "Enter Project Name:",
                  hintText: "eg My Project",
                  controller: TextEditingController(),
                ),
                AppTextFields.basicTextField(
                  title: "Enter Project Name:",
                  hintText: "eg My Project",
                  controller: TextEditingController(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
