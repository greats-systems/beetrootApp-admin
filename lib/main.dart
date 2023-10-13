import 'package:core_erp/services/auth_service.dart';
import 'package:core_erp/store_binding.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:core_erp/routes.dart';
import 'package:core_erp/services/localizations/app_localization_delegate.dart';
import 'package:core_erp/services/localizations/language.dart';
import 'package:core_erp/services/navigation_service.dart';
import 'package:core_erp/services/storage/local_storage.dart';
import 'package:core_erp/services/theme/app_notifier.dart';
import 'package:core_erp/services/theme/app_style.dart';
import 'package:core_erp/services/theme/theme_customizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await dotenv.load(fileName: ".env");
  await LocalStorage.init();
  AppStyle.init();
  await ThemeCustomizer.init();
  await AuthService.getAuthUserAccountType();
  // await Translator.clearTrans();
  // Translator.getUnTrans();

  runApp(ChangeNotifierProvider<AppNotifier>(
    create: (context) => AppNotifier(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppNotifier>(
      builder: (_, notifier, ___) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeCustomizer.instance.theme,
          navigatorKey: NavigationService.navigatorKey,
          initialRoute: "/dashboard",
          getPages: getPageRoute(),
          // onGenerateRoute: (_) => generateRoute(context, _),
          builder: (_, child) {
            NavigationService.registerContext(_);
            return Directionality(
                textDirection: AppTheme.textDirection,
                child: child ?? Container());
          },
          localizationsDelegates: [
            AppLocalizationsDelegate(context),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: Language.getLocales(),

          // home: ButtonsPage(),
        );
      },
    );
  }
}
