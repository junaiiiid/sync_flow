import 'package:flow_sync/constants/extensions.dart';
import 'package:flutter/material.dart';

import '../../../../global_widgets/app_buttons.dart';
import '../../../../global_widgets/app_drop_downs.dart';
import '../../../../global_widgets/app_popups.dart';
import '../../../../global_widgets/app_text_fields.dart';
import '../../../../global_widgets/list_spacer.dart';
import '../../../../styles_and_themes/app_colors.dart';
import '../../../../styles_and_themes/app_text_styles.dart';
import '../../../dashboard/model/task_model.dart';
import '../../model/section_model.dart';
import '../../view_model/edit_task_screen_view_model.dart';

class TaskDetailedView extends StatelessWidget {
  const TaskDetailedView({
    super.key,
    required this.viewModel,
    required this.taskModel,
  });

  final EditTaskScreenViewModel viewModel;
  final Task taskModel;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: viewModel.taskFormKey,
      child: ListView(
        children: [
          AppTextFields.basicTextField(
              title: "Edit Task Title",
              hintText: "eg Task title",
              controller: viewModel.taskTitleController),
          AppTextFields.basicTextField(
              title: "Edit Task Description",
              hintText: "eg Task Description",
              maxLines: 5,
              maxLength: 250,
              controller: viewModel.taskDescriptionController),
          ...viewModel.labelControllers.map<Widget>((element) =>
              AppTextFields.basicTextField(
                  title:
                  "Edit Label ${viewModel.labelControllers.indexOf(element) + 1}",
                  hintText: "eg My Label",
                  controller: element)),
          AppDropDowns.customDropDown<Section>(
              title: "Move To",
              items: viewModel.sectionsList,
              onChanged: (value) {
                viewModel.selectedSection = value;
              },
              hint: "eg Choose where to move",
              selectedItem: viewModel.selectedSection,
              itemBuilder: (value) {
                return Text(
                  value?.name ?? "",
                  style: AppTextStyles.displaySmall?.copyWith(
                    color: AppColors.darkGrey,
                  ),
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
              title: "SAVE CHANGES",
              onTap: () async {
                await viewModel.modifyTask(
                    taskId: taskModel.id ?? "");
              }),
          const ListSpacer(),
        ],
      ),
    );
  }
}