import 'package:flow_sync/features/home/model/extras_item_model.dart';
import 'package:flow_sync/features/home/view_model/home_view_model.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/styles_and_themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants/app_assets.dart';
import '../../../../styles_and_themes/app_colors.dart';

class ExtrasWidget extends StatelessWidget {
  final HomeViewModel viewModel;
  const ExtrasWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: LightModeColors.transparent,
      splashColor: LightModeColors.transparent,
      onTap: () {
        viewModel.toggleExtraWidget();
      },
      child: Visibility(
        visible: (viewModel.isExtrasOpened) ? false : true,
        child: Transform.scale(
          scale: 3,
          child: SvgPicture.asset(AppAssets.add),
        ),
      ),
    );
  }
}

class ExtraBottomSheet extends ConsumerWidget {
  const ExtraBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(ProviderService.homeProvider);
    return DraggableScrollableSheet(
      controller: viewModel.draggableScrollableController,
      initialChildSize: 0,
      minChildSize: 0,
      maxChildSize: 0.65,
      snapSizes: const [0, 0.65],
      builder: (BuildContext context, ScrollController scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Stack(
            children: [
              Container(
                color: LightModeColors.transparent,
                child: Padding(
                  padding: EdgeInsets.only(top: 15.h),
                  child: Container(
                    decoration: BoxDecoration(
                      color: LightModeColors.grey,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(40.r)),
                    ),
                    padding: EdgeInsets.only(top: 50.h, bottom: 50.h),
                    child: Column(
                      children: viewModel.extrasMenuItems
                          .map<Widget>((item) => extrasItemCard(model: item))
                          .toList(),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: InkWell(
                  highlightColor: LightModeColors.transparent,
                  splashColor: LightModeColors.transparent,
                  onTap: () {
                    viewModel.toggleExtraWidget();
                  },
                  child: Transform.scale(
                    scale: 3,
                    child: SvgPicture.asset(AppAssets.subtract),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget extrasItemCard({required ExtrasItemModel model}) {
    return Container(
      decoration: BoxDecoration(
          color: LightModeColors.red,
          borderRadius: BorderRadius.all(
            Radius.circular(10.r),
          ),
          border: Border.all(color: LightModeColors.light)),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      margin: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
      child: ListTile(
        leading: SvgPicture.asset(model.iconPath),
        title: Text(
          model.title,
          style: AppTextStyles.labelLarge?.copyWith(color: LightModeColors.light),
        ),
        subtitle: Text(
          model.subtitle,
          style: AppTextStyles.labelSmall?.copyWith(color: LightModeColors.light),
        ),
      ),
    );
  }
}
