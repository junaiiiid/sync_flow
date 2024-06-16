import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/board/model/tabs_model.dart';
import 'package:flow_sync/features/board/ui/create_task_screen.dart';
import 'package:flow_sync/features/board/ui/edit_task_screen.dart';
import 'package:flow_sync/global_widgets/app_buttons.dart';
import 'package:flow_sync/global_widgets/app_dismissible.dart';
import 'package:flow_sync/global_widgets/list_spacer.dart';
import 'package:flow_sync/global_widgets/no_data_widget.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/state_service.dart';
import 'package:flow_sync/styles_and_themes/app_colors.dart';
import 'package:flow_sync/styles_and_themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../dashboard/model/task_model.dart';

class ProjectsTabBar extends StatefulWidget {
  final dynamic viewModel;
  final Color? textColor;
  final Color? itemsColor;
  final Color? unselectedItemColor;
  const ProjectsTabBar({super.key, required this.viewModel, this.textColor, this.itemsColor, this.unselectedItemColor});

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
        ?  NoDataWidget(content: LanguageService.getString.noTasksFound)
        : Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                flex: 0,
                child: TabBar(
                  indicatorColor: LightModeColors.red,
                  isScrollable: true,
                  physics: const BouncingScrollPhysics(),
                  unselectedLabelColor: widget.unselectedItemColor??LightModeColors.light,
                  labelColor: LightModeColors.red,
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
                                  title: LanguageService.getString.createNewTask,
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
            color: LightModeColors.red,
          ),
          Text(
            model.tabName,
            style:
                AppTextStyles.labelSmall?.copyWith(color: widget.textColor??LightModeColors.grey),
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
        ? [ NoDataWidget(content: LanguageService.getString.noTasksFound)]
        : [...tabBarChildren, const ListSpacer()];
  }

  Widget boardCard(
      {required String taskName,
      required String iconPath,
      required String createdAt}) {
    return Container(
      decoration: BoxDecoration(
          color: widget.itemsColor??LightModeColors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10.r),
          ),
          border: Border.all(color: LightModeColors.light)),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      margin: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
      child: ListTile(
        leading: SvgPicture.asset(
          iconPath,
          color: LightModeColors.grey,
        ),
        title: Text(
          taskName,
          style: AppTextStyles.labelLarge?.copyWith(color: widget.textColor),
        ),
        subtitle: Text(
          createdAt,
          style: AppTextStyles.labelSmall?.copyWith(color: widget.textColor),
        ),
      ),
    );
  }
}
