import 'package:flow_sync/architecture/app_parent_widget.dart';
import 'package:flow_sync/constants/enums.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/dashboard/model/label_model.dart';
import 'package:flow_sync/features/home/ui/widgets/custom_app_bar.dart';
import 'package:flow_sync/global_widgets/app_buttons.dart';
import 'package:flow_sync/global_widgets/app_radio_options.dart';
import 'package:flow_sync/global_widgets/app_text_fields.dart';
import 'package:flow_sync/global_widgets/app_drop_downs.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/styles_and_themes/app_colors.dart';
import 'package:flow_sync/styles_and_themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/project_section_model.dart';

class CreateProjectsScreen extends ConsumerWidget {
  static const String id = '/create_project';
  const CreateProjectsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(ProviderService.createNewProjectProvider);
    final dashBoardViewModel = ref.watch(ProviderService.dashboardProvider);
    return AppParentWidget(
        viewModel: viewModel,
        buildMethod: (context, ref) {
          return Container(
            color: AppColors.darkGrey,
            child: SafeArea(
              child: Scaffold(
                appBar: CustomAppBar.appBarWithBackButton(title: LanguageService.getString.newProject),
                body: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  child: Form(
                    key: viewModel.formKey,
                    child: ListView(
                      children: [
                        AppTextFields.basicTextField(
                          title: LanguageService.getString.enterProjectName,
                          hintText: LanguageService.getString.egMyProject,
                          maxLength: 30,
                          controller: viewModel.projectNameController,
                        ),
                        AppDropDowns.customDropDown<String>(
                            title: LanguageService.getString.selectProjectColor,
                            items: viewModel.colorNames,
                            onChanged: (value) {
                              viewModel.selectedColor = value;
                            },
                            hint: LanguageService.getString.egRed,
                            itemBuilder: (value) {
                              return Row(
                                children: [
                                  Container(
                                    height: 20.h,
                                    width: 20.w,
                                    color: value?.toColor(),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 25.w),
                                    child: Text(
                                      value?.toColorName() ?? "",
                                      style:
                                          AppTextStyles.displaySmall?.copyWith(
                                        color: AppColors.darkGrey,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }),
                        AppRadioOptions<ProjectSectionModel>(
                            options: (dashBoardViewModel.listOfLabels.isEmpty)
                                ? [viewModel.listOfProjectSections.first]
                                : viewModel.listOfProjectSections,
                            groupValue: viewModel.selectedSection,
                            onChanged: (value) {
                              viewModel.selectedSection = value!;
                            },
                            buildTitle: (value) => Text(
                                  value.sectionTitle,
                                  style: AppTextStyles.labelMedium,
                                ),
                            title: LanguageService.getString.chooseKanbanSections),
                        if (viewModel.selectedSection.sectionType !=
                            SectionType.defaultSections) ...[
                          AppDropDowns.customDropDown<Label>(
                              title: LanguageService.getString.select1stSection,
                              items: dashBoardViewModel.listOfLabels,
                              onChanged: (value) {
                                if (viewModel.selectedLabels.isEmpty) {
                                  viewModel.selectedLabels.add(value!);
                                } else {
                                  viewModel.selectedLabels.first = value!;
                                }
                              },
                              hint: LanguageService.getString.egFirstLabel,
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
                          AppDropDowns.customDropDown<Label>(
                              title: LanguageService.getString.select2ndSection,
                              items: dashBoardViewModel.listOfLabels,
                              onChanged: (value) {
                                if (viewModel.selectedLabels.length < 2) {
                                  viewModel.selectedLabels.add(value!);
                                } else {
                                  viewModel.selectedLabels[1] = value!;
                                }
                              },
                              hint: LanguageService.getString.egSecondLabel,
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
                          AppDropDowns.customDropDown<Label>(
                              title: LanguageService.getString.select3rdSection,
                              items: dashBoardViewModel.listOfLabels,
                              onChanged: (value) {
                                if (viewModel.selectedLabels.length < 3) {
                                  viewModel.selectedLabels.add(value!);
                                } else {
                                  viewModel.selectedLabels[2] = value!;
                                }
                              },
                              hint: LanguageService.getString.egThirdLabel,
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
                        ],
                        AppButtons.customButton(
                            title: LanguageService.getString.create,
                            onTap: () async {
                              await viewModel.createNewProject();
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
