import 'package:flow_sync/features/task_timer/model/timer_task_model.dart';
import 'package:flow_sync/features/task_timer/ui/widgets/individual_task_timer_screen.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/services/state_service.dart';
import 'package:flow_sync/styles_and_themes/app_colors.dart';
import 'package:flow_sync/styles_and_themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActiveTaskTimersView extends ConsumerWidget {
  const ActiveTaskTimersView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(ProviderService.taskTimerProvider);
    return ListView(
      children: viewModel.taskTimerHistory
          .map<Widget>((element) => (TaskHistoryCards(
                model: element!,
              )))
          .toList(),
    );
  }
}

class TaskHistoryCards extends StatelessWidget {
  final TimerTaskModel model;
  const TaskHistoryCards({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    late IconData iconData;
    late String status;

    if (model.isEnded ?? false) {
      iconData = Icons.stop;
      status = LanguageService.getString.stopped;
    } else if (model.isPaused ?? false) {
      iconData = Icons.pause;
      status = LanguageService.getString.paused;
    } else if (model.isResumed ?? false) {
      iconData = Icons.play_arrow;
      status = LanguageService.getString.started;
    } else {
      iconData = Icons.play_arrow;
      status = LanguageService.getString.started;
    }

    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  IndividualTaskTimerScreen(model: model,)),
        );
      },
      child: Card(
        color: AppColors.lightGrey,
        child: ListTile(
          leading: Icon(iconData),
          title: Text(
            model.task?.content ?? '',
            style: AppTextStyles.labelLarge,
          ),
          subtitle: Text(
            model.task?.projectId ?? '',
            style: AppTextStyles.labelMedium,
          ),
          trailing: Text(
            status,
            style: AppTextStyles.labelSmall,
          ),
        ),
      ),
    );
  }
}
