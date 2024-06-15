import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/board/model/section_model.dart';
import 'package:flow_sync/features/board/view_model/edit_task_screen_view_model.dart';
import 'package:flow_sync/features/dashboard/model/task_model.dart';
import 'package:flow_sync/global_widgets/app_drop_downs.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../architecture/app_parent_widget.dart';
import '../../../global_widgets/app_buttons.dart';
import '../../../global_widgets/app_popups.dart';
import '../../../global_widgets/app_text_fields.dart';
import '../../../styles_and_themes/app_colors.dart';
import '../../../styles_and_themes/app_text_styles.dart';
import '../../home/ui/widgets/custom_app_bar.dart';

class EditTaskScreen extends ConsumerWidget {
  static const String id = '/edit_task';
  final Task taskModel;
  const EditTaskScreen({super.key, required this.taskModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(ProviderService.editTaskProvider);
    viewModel.initialize(model: taskModel);
    return AppParentWidget(
      viewModel: viewModel,
      buildMethod: (context, ref) {
        return Container(
          color: AppColors.darkGrey,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.white,
              appBar:
                  CustomAppBar.appBarWithBackButton(title: "#${taskModel.id}"),
              body: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                child: Form(
                  key: viewModel.formKey,
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

  List<Widget> getLabelTextFields(
      {required EditTaskScreenViewModel viewModel}) {
    return [];
  }
}
