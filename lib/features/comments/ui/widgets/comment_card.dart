import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/comments/ui/widgets/edit_comment_view.dart';
import 'package:flow_sync/features/comments/view_model/comment_view_model.dart';
import 'package:flow_sync/features/dashboard/model/comment_model.dart';
import 'package:flow_sync/global_widgets/skeleton_effect_widget.dart';
import 'package:flow_sync/services/state_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants/app_assets.dart';
import '../../../../constants/enums.dart';
import '../../../../styles_and_themes/app_colors.dart';
import '../../../../styles_and_themes/app_text_styles.dart';
import 'bubble.dart';

class CommentCard extends StatelessWidget {
  final Comment model;
  final CommentViewModel viewModel;
  const CommentCard({super.key, required this.model, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Card(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 25.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Comment# ${model.id}",
                      style: AppTextStyles.labelSmall,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: (viewModel.listOfTasks.isNotEmpty)
                              ? viewModel
                                  .getProjectByTaskId(id: model.taskId)
                                  .color
                                  .toColor()
                              : viewModel
                                  .getProjectById(id: model.projectId ?? "")
                                  .color
                                  .toColor(),
                          radius: 10.r,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          (viewModel.listOfTasks.isNotEmpty)
                              ? viewModel.getTaskById(id: model.taskId).content
                              : viewModel
                                  .getProjectById(id: model.projectId ?? '')
                                  .name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: true,
                          style: AppTextStyles.labelSmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    model.postedAt.toString().toFormattedDate(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: true,
                    style: AppTextStyles.labelSmall,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        flex: 0,
                        child: CircleAvatar(
                          backgroundColor: AppColors.darkGrey,
                          child: SvgPicture.asset(AppAssets.userIcon),
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: Bubble(
                              text: model.content, color: AppColors.lightGrey)),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                      visible: (model.attachment != null),
                      child: CommentAction(
                          type: CommentActionType.viewAttachment,
                          model: model,
                          viewModel: viewModel)),
                  CommentAction(
                      type: CommentActionType.editComment,
                      model: model,
                      viewModel: viewModel),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommentCardSkeleton extends StatelessWidget {
  const CommentCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Card(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 25.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: SkeletonEffectWidget(
                      child: Text(
                        "Loading...",
                        style: AppTextStyles.labelSmall,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        SkeletonEffectWidget(
                          child: CircleAvatar(
                            radius: 10.r,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        SkeletonEffectWidget(
                          child: Text(
                            "Loading...",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: true,
                            style: AppTextStyles.labelSmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: SkeletonEffectWidget(
                    child: Text(
                      "Please Wait...",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: true,
                      style: AppTextStyles.labelSmall,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        flex: 0,
                        child: CircleAvatar(
                          backgroundColor: AppColors.darkGrey,
                          child: SvgPicture.asset(AppAssets.userIcon),
                        ),
                      ),
                      const Expanded(
                          flex: 3,
                          child: SkeletonEffectWidget(
                            child: Bubble(
                                text: "Please Wait...",
                                color: AppColors.lightGrey),
                          )),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const SkeletonEffectWidget(child: Icon(Icons.link)),
                      SizedBox(
                        width: 5.w,
                      ),
                      SkeletonEffectWidget(
                        child: Text(
                          "Loading...",
                          style: AppTextStyles.labelSmall,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const SkeletonEffectWidget(child: Icon(Icons.edit)),
                      SizedBox(
                        width: 5.w,
                      ),
                      SkeletonEffectWidget(
                        child: Text(
                          "Loading...",
                          style: AppTextStyles.labelSmall,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommentAction extends StatelessWidget {
  final CommentActionType type;
  final Comment model;
  final CommentViewModel viewModel;
  const CommentAction({super.key, required this.type, required this.model, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    late IconData iconData;
    late String title;
    late Function() onTap;
    switch (type) {
      case CommentActionType.viewAttachment:
        iconData = Icons.link;
        title = "View Attachment";
        onTap = () {
          viewModel.openAttachment(url: model.attachment?.fileUrl ?? "");
        };
      case CommentActionType.editComment:
        iconData = Icons.edit;
        title = "Edit Comment";
        onTap = () {
          viewModel.commentController.text = model.content;
          showModalBottomSheet(isScrollControlled:true,context: StateService.context, builder: (context){
            return EditCommentView(model: model);
          });
        };
    }
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(iconData),
          SizedBox(
            width: 5.w,
          ),
          Text(
            title,
            style: AppTextStyles.labelSmall,
          )
        ],
      ),
    );
  }
}
