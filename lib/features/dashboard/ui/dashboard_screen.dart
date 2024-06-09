import 'package:flow_sync/architecture/app_parent_widget.dart';
import 'package:flow_sync/constants/app_assets.dart';
import 'package:flow_sync/constants/enums.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/dashboard/model/dashboard_items_model.dart';
import 'package:flow_sync/features/dashboard/model/project_model.dart';
import 'package:flow_sync/services/dependency_injection/locator.dart';
import 'package:flow_sync/services/dependency_injection/locator_service.dart';
import 'package:flow_sync/services/network_service.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/styles_and_themes/app_colors.dart';
import 'package:flow_sync/styles_and_themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(ProviderService.dashboardProvider);
    return AppParentWidget(
      viewModel: viewModel,
      buildMethod: (context, ref) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 10.w, mainAxisSpacing: 10.h),
            children: viewModel.dashboardItems
                .map<Widget>((item) => dashboardItemCard(model: item))
                .toList(),
          ),
        );
      },
    );
  }

  Widget dashboardItemCard({required DashboardItemsModel model}) {
    return InkWell(
      onTap: () async{
        List<Project> projects = await locator<NetworkService>().getAllProjects();
        for(Project element in projects){
          print(element.name);
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.darkGrey,
            borderRadius: BorderRadius.all(Radius.circular(10.r))),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                model.label,
                style: AppTextStyles.labelLarge?.copyWith(color: AppColors.white),
              ),
              SvgPicture.asset(model.iconPath),
              Text(
                model.length.toPaddedString(),
                style: AppTextStyles.displayLarge
                    ?.copyWith(color: AppColors.cherryRed),
              )
            ],
          ),
        ),
      ),
    );
  }
}
