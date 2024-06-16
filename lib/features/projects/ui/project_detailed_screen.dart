import 'package:flow_sync/features/board/ui/widgets/task_comments_detailed_view.dart';
import 'package:flow_sync/features/dashboard/model/project_model.dart';
import 'package:flow_sync/features/projects/ui/widgets/project_tabs.dart';
import 'package:flow_sync/features/projects/view_model/project_details_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../architecture/app_parent_widget.dart';
import '../../../constants/app_assets.dart';
import '../../../global_widgets/loader_widget.dart';
import '../../../services/provider_service.dart';
import '../../../styles_and_themes/app_colors.dart';
import '../../board/ui/widgets/projects_tab_bar.dart';
import '../../home/ui/widgets/custom_app_bar.dart';

class ProjectDetailedScreen extends ConsumerStatefulWidget {
  static const String id = '/project_details';
  final Project model;
  const ProjectDetailedScreen({super.key, required this.model});

  @override
  ConsumerState<ProjectDetailedScreen> createState() =>
      _ProjectDetailedScreenState();
}

class _ProjectDetailedScreenState extends ConsumerState<ProjectDetailedScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(ProviderService.projectDetailsProvider);
    viewModel.initialize(project: widget.model);
    return AppParentWidget(
      viewModel: viewModel,
      buildMethod: (context, ref) {
        return Container(
          color: AppColors.darkGrey,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.lightGrey,
              appBar:
                  CustomAppBar.appBarWithBackButton(title: widget.model.name),
              body: Flex(
                direction: Axis.vertical,
                children: [
                  Expanded(
                    flex: 0,
                    child: TabBar(
                      indicatorColor: AppColors.cherryRed,
                      physics: const BouncingScrollPhysics(),
                      unselectedLabelColor: AppColors.lightGrey,
                      labelColor: AppColors.cherryRed,
                      tabs: const [
                        ProjectTabs(
                            assetName: AppAssets.projectTab, title: "Board"),
                        ProjectTabs(
                            assetName: AppAssets.commentsTab,
                            title: "Comments"),
                      ],
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 10.w),
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          getBoard(vm: viewModel),
                          TaskCommentsDetailedView(vm: viewModel,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getBoard({required ProjectDetailsViewModel vm}) {
    if ((vm.selectedProject.id != 'id')) {
      return ((vm.listOfSections.length == 1) &&
              (vm.listOfSections.first.id == "id"))
          ? const LoaderWidget()
          : Expanded(
              flex: 3,
              child: ProjectsTabBar(
                viewModel: vm,
              ));
    } else {
      return Container();
    }
  }
}
