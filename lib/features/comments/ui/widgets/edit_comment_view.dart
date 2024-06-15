import 'package:flow_sync/constants/app_assets.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/dashboard/model/comment_model.dart';
import 'package:flow_sync/global_widgets/app_buttons.dart';
import 'package:flow_sync/global_widgets/app_text_fields.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/services/state_service.dart';
import 'package:flow_sync/styles_and_themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditCommentView extends StatelessWidget {
  final Comment model;
  final dynamic viewModel;
  const EditCommentView({super.key, required this.model, this.viewModel});

  @override
  Widget build(BuildContext context) {
    // Get the view insets, which include the keyboard height when visible
    final viewInsets = MediaQuery.of(context).viewInsets;
    final vm =
        viewModel ?? StateService.context.read(ProviderService.commentProvider);
    return Padding(
      padding: EdgeInsets.only(
        left: 25.w,
        right: 25.w,
        top: 50.h,
        bottom: viewInsets.bottom > 0 ? viewInsets.bottom : 50.h,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: vm.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 25.h,
                backgroundColor: AppColors.darkGrey,
                child: SvgPicture.asset(AppAssets.userIcon),
              ),
              AppTextFields.basicTextField(
                  title: "Comment# ${model.id}",
                  hintText: "",
                  controller: vm.commentController,
                  maxLength: 500,
                  maxLines: 5),
              AppButtons.customButton(
                  title: "PUBLISH",
                  onTap: () async {
                    await vm.editComment(id: model.id);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

// Function to show the EditCommentView as a modal bottom sheet
void showEditCommentView(BuildContext context, Comment model) {
  showModalBottomSheet(
    context: context,
    isScrollControlled:
        true, // This allows the bottom sheet to resize with the keyboard
    builder: (BuildContext context) {
      return EditCommentView(model: model);
    },
  );
}
