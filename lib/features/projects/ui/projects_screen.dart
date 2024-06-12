import 'package:flow_sync/architecture/app_parent_widget.dart';
import 'package:flow_sync/constants/app_assets.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/projects/model/project_card_model.dart';
import 'package:flow_sync/features/projects/ui/create_projects_screen.dart';
import 'package:flow_sync/features/projects/ui/widgets/project_cards.dart';
import 'package:flow_sync/global_widgets/skeleton_effect_widget.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/styles_and_themes/app_colors.dart';
import 'package:flow_sync/styles_and_themes/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../global_widgets/app_buttons.dart';
import '../../../global_widgets/list_spacer.dart';
import '../../../services/state_service.dart';

class ProjectsScreen extends ConsumerWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(ProviderService.projectProvider);
    return AppParentWidget(
        viewModel: viewModel,
        buildMethod: (context, ref) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Flex(
              direction: Axis.vertical,
              children: [
                AppButtons.scaffoldIconButton(
                  title: 'CREATE NEW',
                  onTap: () {
                    StateService.pushNamed(routeName: CreateProjectsScreen.id);
                  },
                ),
                Expanded(
                  child: ListView(
                    children: (viewModel.listOfProjectCards.isEmpty)
                        ? [
                            const ProjectCardsSkeleton(),
                          ]
                        : [
                            ...viewModel.listOfProjectCards.map<Widget>(
                              (element) => ProjectCards(model: element),
                            ),
                            const ListSpacer(),
                          ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
