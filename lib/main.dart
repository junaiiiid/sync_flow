import 'package:flow_sync/constants/numeric_constants.dart';
import 'package:flow_sync/features/splash/ui/splash_screen.dart';
import 'package:flow_sync/services/dependency_injection/locator.dart';
import 'package:flow_sync/services/route_service.dart';
import 'package:flow_sync/services/state_service.dart';
import 'package:flow_sync/styles_and_themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
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
        designSize: NumericConstants.artBoardSize,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            theme: ThemeData(
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
            localizationsDelegates: StateService.localizationDelegates,
            supportedLocales: StateService.supportedLocales,
            initialRoute: SplashScreen.id,
            routes: RouteService.routeNames,
            navigatorKey: StateService.navigatorKey,
            debugShowCheckedModeBanner: false,
          );
        });
  }
}
