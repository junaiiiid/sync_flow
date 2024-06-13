import 'package:flow_sync/architecture/app_parent_widget.dart';
import 'package:flow_sync/features/labels/ui/create_new_label_screen.dart';
import 'package:flow_sync/features/labels/ui/widgets/label_cards.dart';
import 'package:flow_sync/global_widgets/no_data_widget.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/services/state_service.dart';
import 'package:flow_sync/styles_and_themes/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../global_widgets/app_buttons.dart';
import '../../../global_widgets/list_spacer.dart';
import '../../../styles_and_themes/app_colors.dart';
import '../../home/ui/widgets/custom_app_bar.dart';

class LabelsScreen extends ConsumerWidget {
  static const String id = "/label";
  const LabelsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(ProviderService.labelsProvider);
    return AppParentWidget(
      viewModel: viewModel,
      buildMethod: (context, ref) {
        return Container(
          color: AppColors.darkGrey,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.lightGrey,
              appBar: CustomAppBar.appBarWithBackButton(title: "Labels"),
              body: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    if (!(viewModel.listOfLabels.length == 1 &&
                        viewModel.listOfLabels.first.id == "id"))
                      AppButtons.scaffoldIconButton(
                        title: 'CREATE NEW',
                        onTap: () {
                          StateService.pushNamed(
                              routeName: CreateNewLabelScreen.id);
                        },
                      ),
                    Expanded(
                      child: ListView(
                        children: (viewModel.listOfLabels.length == 1 &&
                                viewModel.listOfLabels.first.id == "id")
                            ? [const LabelCardSkeleton()]
                            : (viewModel.listOfLabels.isEmpty)
                                ? [
                                    const NoDataWidget(
                                        content: "NO LABELS FOUND"),
                                  ]
                                : [
                                    ...viewModel.listOfLabels.map<Widget>(
                                        (label) => LabelCard(model: label)),
                                    const ListSpacer(),
                                  ],
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
