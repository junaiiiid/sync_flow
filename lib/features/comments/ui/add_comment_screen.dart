import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/dashboard/model/project_model.dart';
import 'package:flow_sync/global_widgets/app_buttons.dart';
import 'package:flow_sync/global_widgets/app_drop_downs.dart';
import 'package:flow_sync/global_widgets/app_text_fields.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../architecture/app_parent_widget.dart';
import '../../../styles_and_themes/app_colors.dart';
import '../../../styles_and_themes/app_text_styles.dart';
import '../../dashboard/model/task_model.dart';
import '../../home/ui/widgets/custom_app_bar.dart';

class AddCommentScreen extends ConsumerWidget {
  static const String id = "/add_comment";
  const AddCommentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(ProviderService.addCommentProvider);
    return AppParentWidget(
        viewModel: viewModel,
        buildMethod: (context, ref) {
          return Container(
            color: AppColors.darkGrey,
            child: SafeArea(
              child: Scaffold(
                appBar:
                    CustomAppBar.appBarWithBackButton(title: "ADD A COMMENT"),
                body: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  child: Form(
                    key: viewModel.formKey,
                    child: ListView(
                      children: [
                        if (viewModel.listOfProjects.isNotEmpty)
                          AppDropDowns.customDropDown<Project>(
                              title: "Select Your Project",
                              items: viewModel.listOfProjects,
                              onChanged: (value) {
                                viewModel.selectedProject = value;
                              },
                              hint: "eg My Project",
                              itemBuilder: (value) {
                                return Row(
                                  children: [
                                    Container(
                                      height: 20.h,
                                      width: 20.w,
                                      color: value?.color.toColor(),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.w),
                                      child: Text(
                                        "ID# ${value?.id} (${value?.name})",
                                        style: AppTextStyles.displaySmall
                                            ?.copyWith(
                                          color: AppColors.darkGrey,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        if (viewModel.listOfTasks.isNotEmpty)
                          AppDropDowns.customDropDown<Task>(
                              title: "Select Your Task",
                              items: viewModel.listOfTasks,
                              onChanged: (value) {
                                viewModel.selectedTask = value;
                              },
                              hint: "eg My Project",
                              itemBuilder: (value) {
                                return Text(
                                  "ID# ${value?.id} (${value?.content})",
                                  style: AppTextStyles.displaySmall?.copyWith(
                                    color: AppColors.darkGrey,
                                  ),
                                );
                              }),
                        AppTextFields.basicTextField(
                            title: "Add Your Comment",
                            hintText: "eg This is a comment.",
                            controller: viewModel.commentController,
                            maxLength: 500,
                            maxLines: 5),
                        AppButtons.customButton(
                            title: "PUBLISH",
                            onTap: () async {
                              await viewModel.addAComment();
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
