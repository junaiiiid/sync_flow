import 'package:flow_sync/features/task_timer/model/timer_task_model.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/styles_and_themes/app_colors.dart';
import 'package:flow_sync/styles_and_themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class ActiveTaskTimersView extends StatelessWidget {
  const ActiveTaskTimersView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [

      ],
    );
  }
}

class TaskHistoryCards extends StatelessWidget {
  final TimerTaskModel model;
  const TaskHistoryCards({
    super.key, required this.model,
  });

  @override
  Widget build(BuildContext context) {
    late IconData iconData;
    late String status;
    
    if(model.isEnded ?? false){
      iconData = Icons.stop;
      status = LanguageService.getString.stopped;
    }
    else if(model.isPaused ?? false){
      iconData = Icons.pause;
      status = LanguageService.getString.paused;
    }
    else if(model.isResumed ?? false){
      iconData = Icons.play_arrow;
      status = LanguageService.getString.started;
    }
    else{
      iconData = Icons.play_arrow;
      status = LanguageService.getString.started;
    }
    
    return Card(
      color: LightModeColors.light,
      child: ListTile(
        leading: Icon(iconData),
        title: Text(model.task?.content??'',style: AppTextStyles.labelLarge,),
        subtitle: Text(model.task?.projectId??'',style: AppTextStyles.labelMedium,),
        trailing: Text(status,style: AppTextStyles.labelSmall,),
      ),
    );
  }
}
