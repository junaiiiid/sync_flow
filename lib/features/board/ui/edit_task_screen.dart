import 'package:flow_sync/features/dashboard/model/task_model.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../architecture/app_parent_widget.dart';
import '../../../styles_and_themes/app_colors.dart';
import '../../home/ui/widgets/custom_app_bar.dart';

class EditTaskScreen extends ConsumerWidget {
  static const String id = '/edit_task';
  final Task taskModel;
  const EditTaskScreen({super.key, required this.taskModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(ProviderService.editTaskProvider);
    return AppParentWidget(
      viewModel: viewModel,
      buildMethod: (context, ref) {
        return Container(
          color: AppColors.darkGrey,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.white,
              appBar: CustomAppBar.appBarWithBackButton(title: "#${taskModel.id}"),
              body: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                child: Form(
                  key: viewModel.formKey,
                  child: ListView(
                    children: [
                      /*AppTextFields.basicTextField(
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
                          }),*/
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
