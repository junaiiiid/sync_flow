import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/services/language_service.dart';
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
              title: LanguageService.getString.editTaskTitle,
              hintText: LanguageService.getString.egTaskTitle,
              controller: viewModel.taskTitleController),
          AppTextFields.basicTextField(
              title: LanguageService.getString.editTaskDescription,
              hintText: LanguageService.getString.egTaskDescription,
              maxLines: 5,
              maxLength: 250,
              controller: viewModel.taskDescriptionController),
          ...viewModel.labelControllers.map<Widget>((element) =>
              AppTextFields.basicTextField(
                  title:
                  "Edit Label ${viewModel.labelControllers.indexOf(element) + 1}",
                  hintText: LanguageService.getString.egMyLabel,
                  controller: element)),
          AppDropDowns.customDropDown<Section>(
              title: LanguageService.getString.moveTo,
              items: viewModel.sectionsList,
              onChanged: (value) {
                viewModel.selectedSection = value;
              },
              hint: LanguageService.getString.egChooseWhereToMove,
              selectedItem: viewModel.selectedSection,
              itemBuilder: (value) {
                return Text(
                  value?.name ?? "",
                  style: AppTextStyles.displaySmall?.copyWith(
                    color: LightModeColors.grey,
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
                  title: LanguageService.getString.selectDueDate,
                  hintText: LanguageService.getString.tapToSelectADueDate,
                  maxLines: 1,
                  maxLength: 40,
                  controller: viewModel.dueDateController),
            ),
          ),
          AppButtons.customButton(
              title: LanguageService.getString.saveChanges,
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