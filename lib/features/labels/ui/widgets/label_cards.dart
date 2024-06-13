import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/dashboard/model/label_model.dart';
import 'package:flow_sync/global_widgets/app_dismissible.dart';
import 'package:flow_sync/global_widgets/skeleton_effect_widget.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/services/state_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../styles_and_themes/app_colors.dart';
import '../../../../styles_and_themes/app_text_styles.dart';

class LabelCard extends StatelessWidget {
  final Label model;
  const LabelCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: AppDismissible(
        onDismiss: (_) {},
        child: Card(
          color: model.color.toColor(),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: model.color.toColor().lighten(0.1),
                child: Text(
                  "#${model.order}",
                  style: AppTextStyles.titleLarge,
                ),
              ),
              title: Text(
                model.name,
                style: AppTextStyles.labelLarge,
              ),
              subtitle: Text(
                "#${model.id}",
                style: AppTextStyles.labelLarge,
              ),
              trailing: IconButton(
                onPressed: () async {
                  StateService.context
                      .read(ProviderService.labelsProvider)
                      .toggleFavouriteUnFavouriteLabel(
                          labelId: model.id, isFavourite: model.isFavorite);
                },
                icon: Icon(
                  (model.isFavorite)
                      ? CupertinoIcons.heart_fill
                      : CupertinoIcons.heart,
                  color: (model.isFavorite)
                      ? AppColors.cherryRed
                      : AppColors.darkGrey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LabelCardSkeleton extends StatelessWidget {
  const LabelCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Card(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          child: ListTile(
            leading: SkeletonEffectWidget(
              child: CircleAvatar(
                child: Text(
                  "...",
                  style: AppTextStyles.titleLarge,
                ),
              ),
            ),
            title: SkeletonEffectWidget(
                child: Text(
              "Loading...",
              style: AppTextStyles.labelLarge,
            )),
            subtitle: SkeletonEffectWidget(
                child: Text(
              "Please wait...",
              style: AppTextStyles.labelLarge,
            )),
            trailing: IconButton(
              onPressed: () {},
              icon: const SkeletonEffectWidget(
                  child: Icon(
                CupertinoIcons.heart_slash,
                color: AppColors.darkGrey,
              )),
            ),
          ),
        ),
      ),
    );
  }
}
