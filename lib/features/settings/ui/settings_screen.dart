import 'package:flow_sync/architecture/app_parent_widget.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/styles_and_themes/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(ProviderService.settingsProvider);
    return AppParentWidget(
        viewModel: viewModel, buildMethod: (context, ref) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Card(
                  margin: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
                    child: ListTile(
                      leading: Text("Dark Theme",style: AppTextStyles.titleMedium,),
                      trailing: CupertinoSwitch(value: true, onChanged: (_){}),
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
                    child: ListTile(
                      leading: Text("Dark Theme",style: AppTextStyles.titleMedium,),
                      trailing: CupertinoSwitch(value: true, onChanged: (_){}),
                    ),
                  ),
                ),
              ],
            ),
          );
    });
  }
}
