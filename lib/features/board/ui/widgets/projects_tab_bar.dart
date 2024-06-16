import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/board/model/tabs_model.dart';
import 'package:flow_sync/features/board/ui/create_task_screen.dart';
import 'package:flow_sync/features/board/ui/edit_task_screen.dart';
import 'package:flow_sync/global_widgets/app_buttons.dart';
import 'package:flow_sync/global_widgets/app_dismissible.dart';
import 'package:flow_sync/global_widgets/list_spacer.dart';
import 'package:flow_sync/global_widgets/no_data_widget.dart';
import 'package:flow_sync/services/state_service.dart';
import 'package:flow_sync/styles_and_themes/app_colors.dart';
import 'package:flow_sync/styles_and_themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../dashboard/model/task_model.dart';

class ProjectsTabBar extends StatefulWidget {
  final dynamic viewModel;
  const ProjectsTabBar({super.key, required this.viewModel});

  @override
  State<ProjectsTabBar> createState() => _ProjectsTabBarState();
}

class _ProjectsTabBarState extends State<ProjectsTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
        length: widget.viewModel.listOfSections.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return (widget.viewModel.listOfSections.isEmpty)
        ? const NoDataWidget(content: "NO TASKS FOUND")
        : Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                flex: 0,
                child: TabBar(
                  indicatorColor: AppColors.cherryRed,
                  isScrollable: true,
                  physics: const BouncingScrollPhysics(),
                  unselectedLabelColor: AppColors.lightGrey,
                  labelColor: AppColors.cherryRed,
                  tabs: widget.viewModel
                      .getTabModel()
                      .map<Widget>((item) => getTab(model: item))
                      .toList(),
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                ),
              ),
              Expanded(
                flex: 3,
                child: TabBarView(
                  controller: _tabController,
                  children: widget.viewModel
                      .getTabModel()
                      .map<Widget>(
                        (item) => Flex(
                          direction: Axis.vertical,
                          children: [
                            Expanded(
                              flex: 0,
                              child: AppButtons.scaffoldIconButton(
                                  title: "CREATE NEW TASK",
                                  onTap: () {
                                    StateService.pushNamedWithArguments<String>(
                                        routeName: CreateTaskScreen.id,
                                        argument: item.sectionId);
                                  }),
                            ),
                            Expanded(
                              flex: 3,
                              child: ListView(
                                physics: const BouncingScrollPhysics(),
                                children: getTabBarView(model: item),
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          );
  }

  Widget getTab({required TabsModel model}) {
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            model.iconPath,
            color: AppColors.cherryRed,
          ),
          Text(
            model.tabName,
            style:
                AppTextStyles.labelSmall?.copyWith(color: AppColors.darkGrey),
          )
        ],
      ),
    );
  }

  List<Widget> getTabBarView({required TabsModel model}) {
    List<Widget> tabBarChildren = [];
    final List<Task> filteredTasks =
        widget.viewModel.filterTasksBySectionId(sectionId: model.sectionId);
    for (Task task in filteredTasks) {
      tabBarChildren.add(
        AppDismissible(
          onDismiss: (_) {
            widget.viewModel.deleteTasks(taskId: task.id!);
          },
          child: InkWell(
            onTap: () {
              StateService.pushNamedWithArguments<Task>(
                  routeName: EditTaskScreen.id, argument: task.copyWith());
            },
            child: boardCard(
              taskName: task.content,
              iconPath: model.iconPath,
              createdAt: task.createdAt.toString().toFormattedDate(),
            ),
          ),
        ),
      );
    }
    return (tabBarChildren.isEmpty)
        ? [const NoDataWidget(content: "NO TASKS FOUND")]
        : [...tabBarChildren, const ListSpacer()];
  }

  Widget boardCard(
      {required String taskName,
      required String iconPath,
      required String createdAt}) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10.r),
          ),
          border: Border.all(color: AppColors.lightGrey)),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      margin: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
      child: ListTile(
        leading: SvgPicture.asset(
          iconPath,
          color: AppColors.darkGrey,
        ),
        title: Text(
          taskName,
          style: AppTextStyles.labelLarge,
        ),
        subtitle: Text(
          createdAt,
          style: AppTextStyles.labelSmall,
        ),
      ),
    );
  }
}
