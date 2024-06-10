import 'package:flow_sync/constants/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants/app_assets.dart';
import '../../../../constants/enums.dart';
import '../../../../global_widgets/skeleton_effect_widget.dart';
import '../../../../styles_and_themes/app_colors.dart';
import '../../../../styles_and_themes/app_text_styles.dart';
import '../../model/project_card_model.dart';

class ProjectCards extends StatelessWidget {
  final ProjectCardModel model;
  const ProjectCards({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
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
                ProjectElements(
                    count: model.projectData.commentCount,
                    type: ProjectCardElementType.comments),
                ProjectElements(
                    count: model.taskCount, type: ProjectCardElementType.tasks),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectElements extends StatelessWidget {
  final int count;
  final ProjectCardElementType type;
  const ProjectElements({super.key, required this.count, required this.type});

  @override
  Widget build(BuildContext context) {
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
}

class ProjectCardsSkeleton extends StatelessWidget {
  const ProjectCardsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SkeletonEffectWidget(
                    child: ProjectElements(
                        count: 0, type: ProjectCardElementType.comments)),
                SkeletonEffectWidget(
                    child: ProjectElements(
                        count: 0, type: ProjectCardElementType.tasks)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}