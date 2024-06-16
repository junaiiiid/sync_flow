import 'package:flow_sync/architecture/app_parent_widget.dart';
import 'package:flow_sync/features/comments/ui/add_comment_screen.dart';
import 'package:flow_sync/features/comments/ui/widgets/comment_card.dart';
import 'package:flow_sync/features/home/ui/widgets/custom_app_bar.dart';
import 'package:flow_sync/global_widgets/app_buttons.dart';
import 'package:flow_sync/global_widgets/no_data_widget.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/services/state_service.dart';
import 'package:flow_sync/styles_and_themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../services/language_service.dart';

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
          color: LightModeColors.grey,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: LightModeColors.light,
              appBar: CustomAppBar.appBarWithBackButton(
                  title: LanguageService.getString.totalComments),
              body: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    if (!(viewModel.allComments.length == 1 &&
                        viewModel.allComments.first.id ==
                            LanguageService.getString.id))
                      AppButtons.scaffoldIconButton(
                          title: LanguageService.getString.addAComment,
                          onTap: () {
                            StateService.pushNamed(
                                routeName: AddCommentScreen.id);
                          }),
                    Expanded(
                      flex: 3,
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: (viewModel.allComments.length == 1 &&
                                viewModel.allComments.first.id ==
                                    LanguageService.getString.id)
                            ? [const CommentCardSkeleton()]
                            : (viewModel.allComments.isEmpty)
                                ? [
                                    NoDataWidget(
                                        content: LanguageService
                                            .getString.noCommentsFound),
                                  ]
                                : viewModel.allComments
                                    .map<Widget>((comment) => CommentCard(
                                        model: comment, viewModel: viewModel))
                                    .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
