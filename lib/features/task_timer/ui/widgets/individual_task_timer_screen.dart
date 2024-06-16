import 'package:flow_sync/features/home/ui/widgets/custom_app_bar.dart';
import 'package:flow_sync/features/task_timer/ui/widgets/timer_widget.dart';
import 'package:flow_sync/global_widgets/app_buttons.dart';
import 'package:flow_sync/global_widgets/list_spacer.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/styles_and_themes/app_colors.dart';
import 'package:flow_sync/styles_and_themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/timer_task_model.dart';

// Example usage in your UI
class IndividualTaskTimerScreen extends ConsumerWidget {
  static const String id = '/task_timer_details';
  final TimerTaskModel model;

  const IndividualTaskTimerScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(ProviderService.taskTimerProvider);
    final EdgeInsetsGeometry spacerPadding =
        EdgeInsets.symmetric(vertical: 10.h);
    return Container(
      color: LightModeColors.grey,
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar.appBarWithBackButton(title: model.task!.id!),
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 25.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: spacerPadding,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '${LanguageService.getString.tasknumber} ${model.task?.id}',
                        style: AppTextStyles.displayLarge,
                      ),
                    ),
                  ),
                  Padding(
                    padding: spacerPadding,
                    child: Text(
                      'Task Title :',
                      style: AppTextStyles.displayLarge,
                    ),
                  ),
                  Padding(
                    padding: spacerPadding,
                    child: Text(
                      model.task?.content ?? '',
                      style: AppTextStyles.bodyLarge,
                    ),
                  ),
                  Padding(
                    padding: spacerPadding,
                    child: Text(
                      'Task Description :',
                      style: AppTextStyles.displayLarge,
                    ),
                  ),
                  Padding(
                    padding: spacerPadding,
                    child: Text(
                      model.task?.description ?? '',
                      style: AppTextStyles.bodyLarge,
                    ),
                  ),
                  Padding(
                    padding: spacerPadding,
                    child: Text(
                      'Section Id :',
                      style: AppTextStyles.displayLarge,
                    ),
                  ),
                  Padding(
                    padding: spacerPadding,
                    child: Text(
                      model.task?.sectionId ?? '',
                      style: AppTextStyles.bodyLarge,
                    ),
                  ),
                  Padding(
                    padding: spacerPadding,
                    child: Text(
                      'Time Spent',
                      style: AppTextStyles.displayLarge,
                    ),
                  ),
                  TimerWidget(model: model),
                  Wrap(
                    children: [
                      if(model.isPaused ?? false)
                      AppButtons.roundedIconButton(title: "RESUME", iconData: Icons.play_arrow, onTap: ()async{
                        await viewModel.resumeTask(model: model);
                      }),
                      if(model.isResumed ?? false)
                      AppButtons.roundedIconButton(title: "PAUSE", iconData: Icons.pause, onTap: ()async{
                        await viewModel.pauseTask(model: model);
                      }),
                      if(!(model.isEnded ?? false))
                      AppButtons.roundedIconButton(title: "STOP", iconData: Icons.stop, onTap: ()async{
                        await viewModel.stopTask(model: model);
                      }),
                      if(model.isEnded ?? false)
                        AppButtons.roundedIconButton(title: "RESTART", iconData: Icons.refresh, onTap: ()async{
                          await viewModel.stopTask(model: model);
                        }),
                    ],
                  ),
                  const ListSpacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
