import 'package:flow_sync/constants/app_assets.dart';
import 'package:flow_sync/constants/extensions.dart';
import 'package:flow_sync/features/home/view_model/home_view_model.dart';
import 'package:flow_sync/global_widgets/app_buttons.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/services/state_service.dart';
import 'package:flow_sync/styles_and_themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../model/navigation_bar_model.dart';
import 'extras_widget.dart';

class CustomNavigationBar extends ConsumerWidget {
  final HomeViewModel viewModel;
  const CustomNavigationBar({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final themeEngine = ref.watch(ProviderService.themeEngineProvider);
    return Stack(
      children: [
        const ExtraBottomSheet(),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            //height: 200.h,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: NavigationBar(
                    selectedIndex: viewModel.navigationBarItems
                        .indexOf(viewModel.selectedItem),
                    backgroundColor: themeEngine.appBarColor,
                    destinations: viewModel.navigationBarItems
                        .map<Widget>((item) => navigationBarItems(model: item))
                        .toList(),
                  ),
                ),
                /*Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 60.h),
                    child: ExtrasWidget(
                      viewModel: viewModel,
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget navigationBarItems({required NavigationBarModel model}) {
    return InkWell(
      highlightColor: LightModeColors.transparent,
      splashColor: LightModeColors.transparent,
      onTap: () {
        StateService.context.read(ProviderService.homeProvider).selectedItem =
            model;
      },
      child: SvgPicture.asset(
        model.icon,
        color: model.isActive ? LightModeColors.red : LightModeColors.light,
      ),
    );
  }
}
