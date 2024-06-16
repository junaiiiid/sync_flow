import 'package:flow_sync/features/home/ui/widgets/custom_app_bar.dart';
import 'package:flow_sync/features/task_timer/ui/widgets/active_task_timers_view.dart';
import 'package:flow_sync/features/task_timer/ui/widgets/create_task_timer_view.dart';
import 'package:flow_sync/global_widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../architecture/app_parent_widget.dart';
import '../../../constants/app_assets.dart';
import '../../../services/language_service.dart';
import '../../../services/provider_service.dart';
import '../../../styles_and_themes/app_colors.dart';
import '../../projects/ui/widgets/project_tabs.dart';

class TaskTimerScreen extends ConsumerStatefulWidget {
  static const String id = '/edit_task';
  const TaskTimerScreen({super.key});

  @override
  ConsumerState<TaskTimerScreen> createState() => _TaskTimerScreenState();
}

class _TaskTimerScreenState extends ConsumerState<TaskTimerScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(ProviderService.taskTimerProvider);
    return AppParentWidget(
      viewModel: viewModel,
      buildMethod: (context, ref) {
        return Container(
          color: LightModeColors.grey,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: LightModeColors.white,
              appBar: CustomAppBar.appBarWithBackButton(
                  title: LanguageService.getString.taskTimer),
              body: Flex(
                direction: Axis.vertical,
                children: [
                  Expanded(
                    flex: 0,
                    child: TabBar(
                      indicatorColor: LightModeColors.red,
                      physics: const BouncingScrollPhysics(),
                      unselectedLabelColor: LightModeColors.light,
                      labelColor: LightModeColors.red,
                      tabs: [
                        ProjectTabs(
                            assetName: AppAssets.startTimer,
                            title: LanguageService.getString.create),
                        ProjectTabs(
                            assetName: AppAssets.activeTimer,
                            title: LanguageService.getString.active),
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
                        children: const [
                          CreateTaskTimerView(),
                          ActiveTaskTimersView(),
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
