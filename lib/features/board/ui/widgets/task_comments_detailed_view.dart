import 'package:flow_sync/features/board/ui/widgets/task_project_comment_card.dart';
import 'package:flow_sync/global_widgets/app_text_fields.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../architecture/app_parent_widget.dart';
import '../../../../global_widgets/no_data_widget.dart';
import '../../../../styles_and_themes/app_colors.dart';
import '../../../comments/ui/widgets/comment_card.dart';

class TaskCommentsDetailedView extends ConsumerWidget {
  const TaskCommentsDetailedView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(ProviderService.editTaskProvider);
    return Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
          flex: 3,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: (viewModel.allComments.length == 1 &&
                    viewModel.allComments.first.id == "id")
                ? [const CommentCardSkeleton()]
                : (viewModel.allComments.isEmpty)
                    ? [
                        const NoDataWidget(content: "NO COMMENTS FOUND"),
                      ]
                    : viewModel.allComments
                        .map<Widget>(
                            (comment) => TaskProjectCommentCard(model: comment))
                        .toList(),
          ),
        ),
        Expanded(
          flex: 0,
          child: Form(
            key: viewModel.formKey,
            child: AppTextFields.chatTextField(
                hintText: "write something...",
                controller: viewModel.commentController,
                onSend: () async{
                  await viewModel.addAComment();
                }),
          ),
        ),
      ],
    );
  }
}
