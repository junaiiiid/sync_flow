import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/dashboard/model/project_model.dart';
import 'package:flow_sync/features/task_timer/model/timer_task_model.dart';
import 'package:flow_sync/global_widgets/app_buttons.dart';
import 'package:flow_sync/global_widgets/app_drop_downs.dart';
import 'package:flow_sync/global_widgets/no_data_widget.dart';
import 'package:flow_sync/services/dependency_injection/locator.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/services/state_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../services/language_service.dart';
import '../../../../styles_and_themes/app_colors.dart';
import '../../../../styles_and_themes/app_text_styles.dart';
import '../../../dashboard/model/task_model.dart';

class CreateTaskTimerView extends StatelessWidget {
  const CreateTaskTimerView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel =
        StateService.context.read(ProviderService.taskTimerProvider);
    return ListView(
      children: [
        if (viewModel.listOfProjects.isNotEmpty)
          AppDropDowns.customDropDown<Project>(
              title: LanguageService.getString.selectYourProject,
              items: viewModel.listOfProjects,
              onChanged: (value) {
                viewModel.selectedProject = value;
              },
              hint: LanguageService.getString.egMyProject,
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
                        style: AppTextStyles.displaySmall?.copyWith(
                          color: LightModeColors.grey,
                        ),
                      ),
                    ),
                  ],
                );
              }),
        if (viewModel.listOfTasks.isNotEmpty)
          AppDropDowns.customDropDown<Task>(
              title: LanguageService.getString.selectYourTask,
              items: viewModel.listOfTasks,
              onChanged: (value) {
                viewModel.selectedTask = value;
              },
              hint: LanguageService.getString.egMyProject,
              itemBuilder: (value) {
                return Text(
                  "ID# ${value?.id} (${value?.content})",
                  style: AppTextStyles.displaySmall?.copyWith(
                    color: LightModeColors.grey,
                  ),
                );
              }),
        ((viewModel.listOfTasks.isEmpty) &&
                ((viewModel.listOfProjects.isEmpty)))
            ? NoDataWidget(content: LanguageService.getString.pleaseCreateATask)
            : AppButtons.customButton(
                title: LanguageService.getString.startTimer,
                onTap: () async {
                  await viewModel.startANewTask(
                      model: TimerTaskModel(task: viewModel.selectedTask));
                }),
      ],
    );
  }
}
