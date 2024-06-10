import 'package:flow_sync/constants/app_assets.dart';
import 'package:flow_sync/features/board/model/tabs_model.dart';
import 'package:flow_sync/features/board/view_model/board_view_model.dart';
import 'package:flow_sync/features/dashboard/view_model/dashboard_view_model.dart';
import 'package:flow_sync/styles_and_themes/app_colors.dart';
import 'package:flow_sync/styles_and_themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProjectsTabBar extends StatefulWidget {
  final BoardViewModel viewModel;
  const ProjectsTabBar({super.key, required this.viewModel});

  @override
  State<ProjectsTabBar> createState() => _ProjectsTabBarState();
}

class _ProjectsTabBarState extends State<ProjectsTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: widget.viewModel.listOfSections.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
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
            children: [
              Container(child: Center(child: Text('people'))),
              Text('Person'),
              Text('hello'),
            ],
            controller: _tabController,
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
}
