import 'package:flow_sync/services/route_service.dart';
import 'package:flow_sync/styles_and_themes/app_colors.dart';
import 'package:flow_sync/styles_and_themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    const ProviderScope(
      child: Start(),
    ),
  );
}

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp.router(
            theme: ThemeData(
              brightness: Brightness.light,
              textTheme:
                  GoogleFonts.montserratTextTheme(Theme.of(context).textTheme)
                      .copyWith(
                bodyMedium: const TextStyle(
                  color: AppColors.black,
                ),
              ),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              textTheme:
                  GoogleFonts.montserratTextTheme(Theme.of(context).textTheme)
                      .copyWith(
                displayLarge: AppTextStyles.displayLarge,
                displayMedium: AppTextStyles.displayMedium,
                displaySmall: AppTextStyles.displaySmall,
                headlineLarge: AppTextStyles.headlineLarge,
                headlineMedium: AppTextStyles.headlineMedium,
                headlineSmall: AppTextStyles.headlineSmall,
                titleLarge: AppTextStyles.titleLarge,
                titleMedium: AppTextStyles.titleMedium,
                titleSmall: AppTextStyles.titleSmall,
                bodyLarge: AppTextStyles.bodyLarge,
                bodyMedium: AppTextStyles.bodyMedium,
                bodySmall: AppTextStyles.bodySmall,
                labelLarge: AppTextStyles.labelLarge,
                labelMedium: AppTextStyles.labelMedium,
                labelSmall: AppTextStyles.labelSmall,
              ),
            ),
            routerConfig: RouteService.router,
            debugShowCheckedModeBanner: false,
          );
        });
  }
}
