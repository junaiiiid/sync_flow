import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/language_service.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/services/state_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants/app_assets.dart';
import '../../../../constants/enums.dart';
import '../../../../global_widgets/app_dismissible.dart';
import '../../../../styles_and_themes/app_colors.dart';
import '../../../../styles_and_themes/app_text_styles.dart';
import '../../../comments/ui/widgets/bubble.dart';
import '../../../comments/ui/widgets/edit_comment_view.dart';
import '../../../dashboard/model/comment_model.dart';

class TaskProjectCommentCard extends StatelessWidget {
  final Comment model;
  const TaskProjectCommentCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: AppDismissible(
        onDismiss: (_) async {
          await StateService.context.read(ProviderService.editTaskProvider).deleteComment(id: model.id);
        },
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
                                text: model.content,
                                color: AppColors.lightGrey)),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                        visible: (model.attachment != null),
                        child: TaskProjectCommentAction(
                          type: CommentActionType.viewAttachment,
                          model: model,
                        )),
                    TaskProjectCommentAction(
                      type: CommentActionType.editComment,
                      model: model,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TaskProjectCommentAction extends StatelessWidget {
  final CommentActionType type;
  final Comment model;
  const TaskProjectCommentAction(
      {super.key, required this.type, required this.model});

  @override
  Widget build(BuildContext context) {
    final viewModel =
        StateService.context.read(ProviderService.editTaskProvider);
    late IconData iconData;
    late String title;
    late Function() onTap;
    switch (type) {
      case CommentActionType.viewAttachment:
        iconData = Icons.link;
        title = LanguageService.getString.viewAttachment;
        onTap = () {
          viewModel.openAttachment(url: model.attachment?.fileUrl ?? "");
        };
      case CommentActionType.editComment:
        iconData = Icons.edit;
        title = LanguageService.getString.editComment;
        onTap = () {
          viewModel.commentController.text = model.content;
          showModalBottomSheet(
              isScrollControlled: true,
              context: StateService.context,
              builder: (context) {
                return EditCommentView(
                  model: model,
                  viewModel: viewModel,
                );
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
