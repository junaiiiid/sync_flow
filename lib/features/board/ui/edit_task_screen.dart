import 'package:flow_sync/constants/app_assets.dart';
import 'package:flow_sync/features/board/ui/widgets/task_comments_detailed_view.dart';
import 'package:flow_sync/features/board/ui/widgets/task_detailed_view.dart';
import 'package:flow_sync/features/dashboard/model/task_model.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../architecture/app_parent_widget.dart';
import '../../../styles_and_themes/app_colors.dart';
import '../../home/ui/widgets/custom_app_bar.dart';
import '../../projects/ui/widgets/project_tabs.dart';

class EditTaskScreen extends ConsumerStatefulWidget {
  static const String id = '/edit_task';
  final Task taskModel;
  const EditTaskScreen({super.key, required this.taskModel});

  @override
  ConsumerState<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends ConsumerState<EditTaskScreen> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
        length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(ProviderService.editTaskProvider);
    viewModel.initialize(model: widget.taskModel);
    return AppParentWidget(
      viewModel: viewModel,
      buildMethod: (context, ref) {
        return Container(
          color: AppColors.darkGrey,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.white,
              appBar:
              CustomAppBar.appBarWithBackButton(title: "#${widget.taskModel.id}"),
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
                        ProjectTabs(assetName: AppAssets.taskTab, title: "TASK"),
                        ProjectTabs(assetName: AppAssets.commentsTab, title: "Comments"),
                      ],
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          TaskDetailedView(viewModel: viewModel, taskModel: widget.taskModel),
                          const TaskCommentsDetailedView(),
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
}


