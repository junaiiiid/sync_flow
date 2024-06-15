import 'package:flow_sync/constants/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants/app_assets.dart';
import '../../../../constants/enums.dart';
import '../../../../global_widgets/app_dismissible.dart';
import '../../../../styles_and_themes/app_colors.dart';
import '../../../../styles_and_themes/app_text_styles.dart';
import '../../../comments/ui/widgets/bubble.dart';
import '../../../comments/ui/widgets/comment_card.dart';
import '../../../dashboard/model/comment_model.dart';

class TaskProjectCommentCard extends StatelessWidget {
  final Comment model;
  const TaskProjectCommentCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: AppDismissible(
        onDismiss: (_)async{
          //await viewModel.deleteComment(id: model.id);
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
                        child: TaskProjectCommentAction(
                            type: CommentActionType.viewAttachment,
                            model: model,)),
                    TaskProjectCommentAction(
                        type: CommentActionType.editComment,
                        model: model,),
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
  const TaskProjectCommentAction({super.key, required this.type, required this.model});

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
          //viewModel.openAttachment(url: model.attachment?.fileUrl ?? "");
        };
      case CommentActionType.editComment:
        iconData = Icons.edit;
        title = "Edit Comment";
        onTap = () {
          /*viewModel.commentController.text = model.content;
          showModalBottomSheet(isScrollControlled:true,context: StateService.context, builder: (context){
            return EditCommentView(model: model);
          });*/
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