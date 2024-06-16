import 'package:flow_sync/architecture/app_parent_widget.dart';
import 'package:flow_sync/constants/enums.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/dashboard/model/dashboard_items_model.dart';
import 'package:flow_sync/global_widgets/skeleton_effect_widget.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/services/state_service.dart';
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
    bool condition = ((viewModel.dashboardItems.length == 1) &&
        (viewModel.dashboardItems.first.type == DashboardItemType.dummy));
    List<DashboardItemsModel> conditionalList =
        condition ? viewModel.dashboardItemsSkeleton : viewModel.dashboardItems;
    return AppParentWidget(
      viewModel: viewModel,
      buildMethod: (context, ref) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 10.h),
            children: conditionalList
                .map<Widget>(
                  (item) => (condition)
                      ? dashboardItemSkeleton(model: item)
                      : dashboardItemCard(model: item),
                )
                .toList(),
          ),
        );
      },
    );
  }

  Widget dashboardItemCard({required DashboardItemsModel model}) {
    return InkWell(
      onTap: () {
        StateService.context
            .read(ProviderService.dashboardProvider)
            .handleDashBoardIconTap(type: model.type);
      },
      child: Container(
        decoration: BoxDecoration(
            color: LightModeColors.grey,
            borderRadius: BorderRadius.all(Radius.circular(10.r))),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                model.label,
                style:
                    AppTextStyles.labelLarge?.copyWith(color: LightModeColors.white),
              ),
              SvgPicture.asset(model.iconPath),
              Text(
                model.length.toPaddedString(),
                style: AppTextStyles.displayLarge
                    ?.copyWith(color: LightModeColors.red),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget dashboardItemSkeleton({required DashboardItemsModel model}) {
    return Container(
      decoration: BoxDecoration(
          color: LightModeColors.grey,
          borderRadius: BorderRadius.all(Radius.circular(10.r))),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SkeletonEffectWidget(
              child: Text(
                model.label,
                style:
                    AppTextStyles.labelLarge?.copyWith(color: LightModeColors.white),
              ),
            ),
            SkeletonEffectWidget(child: SvgPicture.asset(model.iconPath)),
            SkeletonEffectWidget(
              child: Text(
                model.length.toPaddedString(),
                style: AppTextStyles.displayLarge
                    ?.copyWith(color: LightModeColors.red),
              ),
            )
          ],
        ),
      ),
    );
  }
}
