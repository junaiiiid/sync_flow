import 'package:flow_sync/architecture/app_parent_widget.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/dashboard/model/label_model.dart';
import 'package:flow_sync/global_widgets/app_buttons.dart';
import 'package:flow_sync/global_widgets/app_drop_downs.dart';
import 'package:flow_sync/global_widgets/app_popups.dart';
import 'package:flow_sync/global_widgets/app_text_fields.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/styles_and_themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../styles_and_themes/app_text_styles.dart';
import '../../home/ui/widgets/custom_app_bar.dart';

class CreateTaskScreen extends ConsumerWidget {
  static const String id = '/create_task';
  final String sectionId;
  const CreateTaskScreen({super.key, required this.sectionId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(ProviderService.createTaskProvider);
    viewModel.sectionId = sectionId;
    return AppParentWidget(
      viewModel: viewModel,
      buildMethod: (context, ref) {
        return Container(
          color: AppColors.darkGrey,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.white,
              appBar:
                  CustomAppBar.appBarWithBackButton(title: "Create New Task"),
              body: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                child: Form(
                  key: viewModel.formKey,
                  child: ListView(
                    children: [
                      AppTextFields.basicTextField(
                          title: "Enter Task Title",
                          hintText: "eg Task title",
                          controller: viewModel.taskTitleController),
                      AppTextFields.basicTextField(
                          title: "Enter Task Description",
                          hintText: "eg Task Description",
                          maxLines: 5,
                          maxLength: 250,
                          controller: viewModel.taskDescriptionController),
                      (viewModel.listOfLabels.isEmpty)
                          ? AppTextFields.basicTextField(
                              title: "Enter A Label",
                              hintText: "eg Label Name",
                              controller: viewModel.labelController)
                          : AppDropDowns.customDropDown<Label>(
                              title: "Select A Label",
                              items: viewModel.listOfLabels,
                              onChanged: (value) {
                                viewModel.labelController.text = value!.name;
                              },
                              hint: "eg My label",
                              itemBuilder: (value) {
                                return Row(
                                  children: [
                                    Container(
                                      height: 20.h,
                                      width: 20.w,
                                      color: value?.color.toColor(),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 25.w),
                                      child: Text(
                                        value?.name ?? "",
                                        style: AppTextStyles.displaySmall
                                            ?.copyWith(
                                          color: AppColors.darkGrey,
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              }),
                      GestureDetector(
                        onTap: () async {
                          final DateTime? dateTime =
                              await AppPopups.dateTimeDialog();
                          viewModel.dueDateController.text =
                              dateTime!.toString().toFormattedDate();
                        },
                        child: AbsorbPointer(
                          absorbing: true,
                          child: AppTextFields.basicTextField(
                              title: "Select Due Date",
                              hintText: "Tap to select a due date",
                              maxLines: 1,
                              maxLength: 40,
                              controller: viewModel.dueDateController),
                        ),
                      ),
                      AppButtons.customButton(
                          title: "CREATE TASK",
                          onTap: () async {
                            await viewModel.createNewTask();
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
