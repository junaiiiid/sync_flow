import 'package:flow_sync/architecture/app_parent_widget.dart';
import 'package:flow_sync/constants/app_assets.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/projects/model/project_card_model.dart';
import 'package:flow_sync/global_widgets/skeleton_effect_widget.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/styles_and_themes/app_colors.dart';
import 'package:flow_sync/styles_and_themes/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/enums.dart';

class ProjectsScreen extends ConsumerWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(ProviderService.projectProvider);
    return AppParentWidget(
        viewModel: viewModel,
        buildMethod: (context, ref) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: ListView(
              children: (viewModel.listOfProjectCards.isEmpty)
                  ? [
                      projectCardsSkeleton(),
                    ]
                  : viewModel.listOfProjectCards
                      .map<Widget>(
                        (element) => projectCards(model: element),
                      )
                      .toList(),
            ),
          );
        });
  }

  Widget projectCards({required ProjectCardModel model}) {
    return Card(
      color: model.projectData.color.toColor(),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: model.projectData.color.toColor().lighten(0.1),
              child: SvgPicture.asset(AppAssets.projectThumbnail),
            ),
            title: Text(
              model.projectData.name,
              style: AppTextStyles.labelLarge,
            ),
            subtitle: Text(
              "#${model.projectData.id}",
              style: AppTextStyles.labelMedium,
            ),
            trailing: Icon(
              (model.projectData.isFavorite)
                  ? CupertinoIcons.heart_fill
                  : CupertinoIcons.heart,
              color: (model.projectData.isFavorite)
                  ? AppColors.cherryRed
                  : AppColors.darkGrey,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: model.projectData.color.toColor().lighten(0.1),
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10.r),
                  bottomLeft: Radius.circular(10.r)),
            ),
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                projectElements(
                    count: model.projectData.commentCount,
                    type: ProjectCardElementType.comments),
                projectElements(
                    count: model.taskCount, type: ProjectCardElementType.tasks),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget projectElements(
      {required int count, required ProjectCardElementType type}) {
    return Row(
      children: [
        SvgPicture.asset(
          (type == ProjectCardElementType.comments)
              ? AppAssets.comments
              : AppAssets.personalLabels,
          height: 50.h,
        ),
        SizedBox(
          width: 5.w,
        ),
        Text(
          count.toPaddedString(),
          style:
              AppTextStyles.displayLarge,
        ),
      ],
    );
  }

  Widget projectCardsSkeleton() {
    return Card(
      color: AppColors.white,
      child: Column(
        children: [
          ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.darkGrey,
                child: SvgPicture.asset(AppAssets.projectThumbnail),
              ),
              title: SkeletonEffectWidget(
                child: Text(
                  "Loading...",
                  style: AppTextStyles.labelLarge,
                ),
              ),
              subtitle: SkeletonEffectWidget(
                child: Text(
                  "Loading...",
                  style: AppTextStyles.labelMedium,
                ),
              ),
              trailing: const SkeletonEffectWidget(
                  child: Icon(CupertinoIcons.heart_slash))),
          Container(
            decoration: BoxDecoration(
              color: AppColors.darkGrey,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10.r),
                  bottomLeft: Radius.circular(10.r)),
            ),
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SkeletonEffectWidget(
                    child: projectElements(
                        count: 0, type: ProjectCardElementType.comments)),
                SkeletonEffectWidget(
                    child: projectElements(
                        count: 0, type: ProjectCardElementType.tasks)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
