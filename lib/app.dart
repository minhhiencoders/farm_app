import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_farm_application/page/home/navigation_screen.dart';
import 'package:smart_farm_application/utilities/scaffold_messenger_utils.dart';
import 'router/routing_app.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'services/auth_services.dart';
import 'services/navigation_service.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(builder: (context, constraints) {
      return ScreenUtilInit(
        builder: (context, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.light),
              useMaterial3: true,
              // textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp, displayColor: Colors.black)
              textTheme: GoogleFonts.beVietnamProTextTheme(Theme.of(context).textTheme).copyWith(
                bodyMedium: GoogleFonts.beVietnamPro(textStyle: Theme.of(context).textTheme.bodyMedium),
              ),
              buttonTheme: ButtonThemeData(colorScheme: ColorScheme.light(onPrimary: Colors.white))
            ),
            debugShowCheckedModeBanner: false,
            locale: const Locale('en', 'US'),
            // supportedLocales: const [
            //   Locale('vi', 'VN'),
            //   Locale('en', 'US'),
            // ],
            // localizationsDelegates: const [
            //   AppLocalizations.delegate,
            //   GlobalMaterialLocalizations.delegate,
            //   GlobalWidgetsLocalizations.delegate,
            //   GlobalCupertinoLocalizations.delegate,
            // ],
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            initialRoute: AppRouter.onboarding,
            routes: {
              AppRouter.onboarding: (context) => const AuthWidget(),
              AppRouter.navigation: (context) => const NavigationScreen(),
            },
            // home: const SafeArea(child: NavigationScreen()),
            onGenerateRoute: AppRouter.onGenerateRoute,
            navigatorKey: AppRouter.navigatorKey,
            navigatorObservers: [NavigationService().navigatorObserver],
          );
        }
      );
    });
  }
}
