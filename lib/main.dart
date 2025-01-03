import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/swipe_action_navigator_observer.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:get_it/get_it.dart';
import 'package:purity_auth/prefs.dart';
import 'package:purity_auth/auth_add_page.dart';
import 'package:purity_auth/auth_from_page.dart';
import 'package:purity_auth/auth_home_page.dart';
import 'package:purity_auth/auth_repository.dart';
import 'package:purity_auth/auth_scan_page.dart';
import 'package:purity_auth/auth_settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  GetIt.I.registerSingleton<SharedPreferences>(await SharedPreferences.getInstance());
  GetIt.I.registerSingleton<Prefs>(Prefs(sp: GetIt.I<SharedPreferences>()));
  GetIt.I.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  if (kDebugMode) {
    // GetIt.I<SharedPreferences>().clear();
    GetIt.I<SharedPreferences>().getKeys().forEach((key) {
      final value = GetIt.I<SharedPreferences>().get(key);
      print('$key:$value::${value.runtimeType}');
    });
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const PageTransitionsTheme pageTransitionsTheme = PageTransitionsTheme(builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.fuchsia: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
      TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
    });

    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MaterialApp(
          title: 'Purity Auth',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          theme: ThemeData(
            brightness: Brightness.light,
            colorScheme: lightDynamic,
            // pageTransitionsTheme: pageTransitionsTheme,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            colorScheme: darkDynamic,
            // pageTransitionsTheme: pageTransitionsTheme,
          ),
          initialRoute: '/',
          routes: <String, WidgetBuilder>{
            '/': (BuildContext context) => const AuthHomePage(),
            '/AuthAddPage': (BuildContext context) => const AuthAddPage(),
            '/AuthScanPage': (BuildContext context) => const AuthScanPage(),
            '/AuthFromPage': (BuildContext context) => const AuthFromPage(),
            '/AuthSettingsPage': (BuildContext context) => const AuthSettingsPage(),
          },
          navigatorObservers: <NavigatorObserver>[
            SwipeActionNavigatorObserver(),
          ],
        );
      },
    );
  }
}
