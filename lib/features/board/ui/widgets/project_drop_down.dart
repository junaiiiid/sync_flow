import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/board/view_model/board_view_model.dart';
import 'package:flow_sync/global_widgets/skeleton_effect_widget.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/services/state_service.dart';
import 'package:flow_sync/styles_and_themes/app_colors.dart';
import 'package:flow_sync/styles_and_themes/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../dashboard/model/project_model.dart';

class ProjectDropDown extends StatefulWidget {
  final BoardViewModel viewModel;
  const ProjectDropDown({super.key, required this.viewModel});

  @override
  State<ProjectDropDown> createState() => _ProjectDropDownState();
}

class _ProjectDropDownState extends State<ProjectDropDown> {
  Project? selectedValue;
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: LightModeColors.red,
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
      ),
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Project>(
          hint: Text(
            LanguageService.getString.selectAProject,
            style:
                AppTextStyles.labelLarge?.copyWith(color: LightModeColors.light),
          ),
          dropdownColor: LightModeColors.red,
          value: selectedValue,
          onChanged: (Project? newValue) async {
            widget.viewModel.selectedProject = newValue!;
            StateService.context
                .read(ProviderService.createTaskProvider)
                .projectId = newValue.id;
            setState(() {
              selectedValue = newValue;
            });
            await widget.viewModel.getSectionsOfSelectedProject();
          },
          icon: const Icon(
            CupertinoIcons.arrowtriangle_down_circle_fill,
            color: LightModeColors.light,
          ),
          items: widget.viewModel.listOfProjects
              .map<DropdownMenuItem<Project>>((Project value) {
            return DropdownMenuItem<Project>(
              value: value,
              child: Text(
                value.name,
                style: AppTextStyles.labelLarge
                    ?.copyWith(color: LightModeColors.light),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ProjectDropDownSkeleton extends StatelessWidget {
  const ProjectDropDownSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: true,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: LightModeColors.red,
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
        ),
        margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            dropdownColor: LightModeColors.red,
            value: LanguageService.getString.loading,
            onChanged: (String? newValue) {},
            icon: const Icon(
              CupertinoIcons.arrowtriangle_down_circle_fill,
              color: LightModeColors.light,
            ),
            items: <String>[
              LanguageService.getString.loading,
              LanguageService.getString.a,
              LanguageService.getString.b
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: SkeletonEffectWidget(
                  child: Text(
                    value,
                    style: AppTextStyles.labelLarge
                        ?.copyWith(color: LightModeColors.light),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
