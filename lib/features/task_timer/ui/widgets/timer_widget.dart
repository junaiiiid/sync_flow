import 'dart:async';
import 'package:flow_sync/styles_and_themes/app_colors.dart';
import 'package:flow_sync/styles_and_themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/timer_task_model.dart';

class TimerWidget extends StatefulWidget {
  final TimerTaskModel model;

  TimerWidget({required this.model});

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (widget.model.isPaused! || widget.model.endTime != null) {
        timer.cancel();
      } else {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    final elapsedTime = widget.model.elapsedTime;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 25.h),
      child: Center(
          child: CircleAvatar(
            backgroundColor: AppColors.cherryRed,
            radius: 160.r,
            child: CircleAvatar(
              backgroundColor: AppColors.white,
              radius: 150.r,
              child: Text(
                    _formatDuration(elapsedTime),
                    style: AppTextStyles.displayLarge?.copyWith(color: AppColors.cherryRed,fontSize: 40.sp),
                  ),
            ),
          )),
    );
  }
}
