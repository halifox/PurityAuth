import 'repository.dart';
import 'ui/add_screen.dart';
import 'ui/from_screen.dart';
import 'ui/home_screen.dart';
import 'ui/scan_screen.dart';
import 'ui/settings_screen.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/swipe_action_navigator_observer.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  await initDatabase();
  runApp(const AuthApp());
}

class AuthApp extends StatelessWidget {
  const AuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    const pageTransitionsTheme = PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.fuchsia: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
        TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
      },
    );
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) => MaterialApp(
          title: 'Purity Auth',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          theme: ThemeData(brightness: Brightness.light, colorScheme: lightDynamic, pageTransitionsTheme: pageTransitionsTheme),
          darkTheme: ThemeData(brightness: Brightness.dark, colorScheme: darkDynamic, pageTransitionsTheme: pageTransitionsTheme),
          initialRoute: '/',
          routes: {
            '/': (BuildContext context) => const HomeScreen(),
            '/add': (BuildContext context) => AddScreen(),
            '/scan': (BuildContext context) => const ScanScreen(),
            '/from': (BuildContext context) => const FromScreen(),
            '/settings': (BuildContext context) => const SettingsScreen(),
            '/icons': (BuildContext context) => const IconsChooseScreen(),
          },
          navigatorObservers: [SwipeActionNavigatorObserver()],
        ),
    );
  }
}
