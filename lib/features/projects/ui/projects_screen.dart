import 'package:flow_sync/architecture/app_parent_widget.dart';
import 'package:flow_sync/features/projects/ui/create_projects_screen.dart';
import 'package:flow_sync/features/projects/ui/widgets/project_cards.dart';
import 'package:flow_sync/global_widgets/no_data_widget.dart';
import 'package:flow_sync/services/provider_service.dart';
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
                if(!(viewModel.listOfProjectCards.length==1 && viewModel.listOfProjectCards.first.projectData.id=="id"))
                AppButtons.scaffoldIconButton(
                  title: 'CREATE NEW',
                  onTap: () {
                    StateService.pushNamed(routeName: CreateProjectsScreen.id);
                  },
                ),
                Expanded(
                  child: ListView(
                    children: (viewModel.listOfProjectCards.length==1 && viewModel.listOfProjectCards.first.projectData.id=="id")
                        ? [
                            const ProjectCardsSkeleton(),
                          ]
                        :(viewModel.listOfProjectCards.isEmpty)?[
                          const NoDataWidget(content: "NO PROJECTS FOUND"),
                    ]: [
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
