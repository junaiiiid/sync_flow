import 'package:flow_sync/architecture/app_parent_widget.dart';
import 'package:flow_sync/constants/app_assets.dart';
import 'package:flow_sync/constants/enums.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/comments/ui/widgets/bubble.dart';
import 'package:flow_sync/features/comments/ui/widgets/comment_card.dart';
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
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: (viewModel.allComments.isEmpty)
                      ? [const CommentCardSkeleton()]
                      : viewModel.allComments
                          .map<Widget>((comment) =>
                              CommentCard(model: comment, viewModel: viewModel))
                          .toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
