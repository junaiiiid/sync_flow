import 'package:flow_sync/features/home/ui/widgets/custom_app_bar.dart';
import 'package:flow_sync/global_widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../services/language_service.dart';
import '../../../styles_and_themes/app_colors.dart';

class NotificationScreen extends StatelessWidget {
  static const String id = '/notification';
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: LightModeColors.grey,
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar.appBarWithBackButton(
              title: LanguageService.getString.notifications),
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Column(
              children: [
                NoDataWidget(
                    content: LanguageService.getString.noNotificationsToShow)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
