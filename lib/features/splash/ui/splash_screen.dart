import 'package:flow_sync/architecture/app_parent_widget.dart';
import 'package:flow_sync/features/splash/ui/widgets/branding_logo_widget.dart';
import 'package:flow_sync/features/splash/ui/widgets/logo_widget.dart';
import 'package:flow_sync/services/dependency_injection/locator.dart';
import 'package:flow_sync/services/local_storage_service.dart';
import 'package:flow_sync/services/provider_service.dart';
import 'package:flow_sync/styles_and_themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerWidget {
  static const String id = "/";
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(ProviderService.splashProvider);
    final themeEngine = ref.watch(ProviderService.themeEngineProvider);
    themeEngine.initialize();
    return AppParentWidget(
        viewModel: viewModel,
        buildMethod: (context, ref) {
          return Scaffold(
            backgroundColor: themeEngine.backgroundColor,
            body: Stack(
              children: [
                const Align(alignment: Alignment.center, child: LogoWidget()),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: BrandingLogoWidget(
                    isDarkModeEnabled: themeEngine.isDarkModeEnabled,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
