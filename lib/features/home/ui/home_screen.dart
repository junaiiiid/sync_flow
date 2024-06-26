import 'package:flow_sync/architecture/app_parent_widget.dart';
import 'package:flow_sync/features/board/ui/board_screen.dart';
import 'package:flow_sync/features/dashboard/ui/dashboard_screen.dart';
import 'package:flow_sync/features/home/ui/widgets/custom_app_bar.dart';
import 'package:flow_sync/features/home/ui/widgets/custom_navigation_bar.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/styles_and_themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../projects/ui/projects_screen.dart';
import '../../settings/ui/settings_screen.dart';

class HomeScreen extends ConsumerWidget {
  static const String id = "/home";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(ProviderService.homeProvider);
    return PopScope(
      canPop: false,
      child: AppParentWidget(
          viewModel: viewModel,
          buildMethod: (context, ref) {
            return Container(
              color: AppColors.darkGrey,
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: AppColors.lightGrey,
                  body: Stack(
                    children: [
                      IndexedStack(
                        index: viewModel.navigationBarItems
                            .indexOf(viewModel.selectedItem),
                        children: const [
                          DashboardScreen(),
                          BoardScreen(),
                          ProjectsScreen(),
                          SettingsScreen(),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: CustomNavigationBar(
                          viewModel: viewModel,
                        ),
                      )
                    ],
                  ),
                  appBar:
                      CustomAppBar.myAppBar(title: viewModel.selectedItem.label),
                ),
              ),
            );
          }),
    );
  }
}
