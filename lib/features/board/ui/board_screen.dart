import 'package:flow_sync/architecture/app_parent_widget.dart';
import 'package:flow_sync/features/board/ui/widgets/project_drop_down.dart';
import 'package:flow_sync/features/board/ui/widgets/projects_tab_bar.dart';
import 'package:flow_sync/global_widgets/loader_widget.dart';
import 'package:flow_sync/global_widgets/skeleton_effect_widget.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/styles_and_themes/app_colors.dart';
import 'package:flow_sync/styles_and_themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoardScreen extends ConsumerWidget {
  const BoardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(ProviderService.boardProvider);
    final dashboardViewModel = ref.watch(ProviderService.dashboardProvider);
    return AppParentWidget(
        viewModel: viewModel,
        buildMethod: (context, ref) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Scaffold(
              backgroundColor: AppColors.lightGrey,
              body: Flex(
                direction: Axis.vertical,
                children: (dashboardViewModel.listOfProjects.isEmpty)
                    ? skeletonBoard()
                    : [
                        Expanded(
                          flex: 0,
                          child: Flex(
                            direction: Axis.vertical,
                            children: [
                              Center(
                                child: Text(
                                  (viewModel.selectedProject.id == "id")
                                      ? "Please Select Your Project"
                                      : 'Selected Project "${viewModel.selectedProject.name}"',
                                  style: AppTextStyles.titleSmall,
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: ProjectDropDown(
                                  viewModel: viewModel,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (viewModel.selectedProject.id != "id")
                          (viewModel.listOfSections.isEmpty)
                              ? const LoaderWidget()
                              : Expanded(
                                  flex: 3,
                                  child: ProjectsTabBar(
                                    viewModel: viewModel,
                                  ),
                                ),
                      ],
              ),
            ),
          );
        });
  }

  List<Widget> skeletonBoard() {
    return [
      Center(
          child: SkeletonEffectWidget(
              child: Text(
        "Loading...",
        style: AppTextStyles.titleSmall,
      ))),
      const ProjectDropDownSkeleton(),
    ];
  }
}
