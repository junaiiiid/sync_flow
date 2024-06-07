import 'package:flow_sync/architecture/app_parent_widget.dart';
import 'package:flow_sync/constants/app_assets.dart';
import 'package:flow_sync/features/splash/ui/widgets/branding_logo_widget.dart';
import 'package:flow_sync/features/splash/ui/widgets/logo_widget.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/styles_and_themes/app_colors.dart';
import 'package:flow_sync/styles_and_themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends ConsumerWidget {
  static const String id = "/";
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(ProviderService.splashProvider);
    return AppParentWidget(
        viewModel: viewModel,
        buildMethod: (context, ref) {
          return const Scaffold(
            backgroundColor: AppColors.lightGrey,
            body: Stack(
              children: [
                Align(
                    alignment: Alignment.center,
                    child: LogoWidget()),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: BrandingLogoWidget()),
              ],
            ),
          );
        });
  }
}
