import 'package:flow_sync/architecture/app_parent_widget.dart';
import 'package:flow_sync/constants/app_assets.dart';
import 'package:flow_sync/constants/enums.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/comments/ui/widgets/bubble.dart';
import 'package:flow_sync/features/comments/view_model/comment_view_model.dart';
import 'package:flow_sync/features/dashboard/model/comment_model.dart';
import 'package:flow_sync/features/home/ui/widgets/custom_app_bar.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/styles_and_themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../styles_and_themes/app_text_styles.dart';

class CommentsScreen extends ConsumerWidget {
  static const String id = "/comments";
  const CommentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(ProviderService.commentProvider);
    return AppParentWidget(
      viewModel: viewModel,
      buildMethod: (context, ref) {
        return Container(
          color: AppColors.darkGrey,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.lightGrey,
              appBar: CustomAppBar.appBarWithBackButton(title: "Comments"),
              body: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                child: viewModel.allComments.isEmpty
                    ? CircularProgressIndicator()
                    : ListView(
                        physics: const BouncingScrollPhysics(),
                        children: viewModel.allComments
                            .map<Widget>((comment) => commentCard(
                                model: comment, viewModel: viewModel))
                            .toList(),

                        /*[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Project Name",
                        style: AppTextStyles.titleSmall,
                      ),
                    ),
                    commentCard(),
                    commentCard()
                  ],*/
                      ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget commentCard(
      {required Comment model, required CommentViewModel viewModel}) {
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
                          /*backgroundColor: viewModel
                              .getProjectById(id: model.id)
                              .color
                              .toColor(),*/
                          radius: 10.r,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          viewModel.getTaskById(id: model.taskId).content,
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
                      child: commentAction(
                          type: CommentActionType.viewAttachment, model: model, viewModel: viewModel)),
                  commentAction(type: CommentActionType.editComment, model: model, viewModel: viewModel),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget commentAction(
      {required CommentActionType type,
      required Comment model,
      required CommentViewModel viewModel}) {
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
        onTap = () {};
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
