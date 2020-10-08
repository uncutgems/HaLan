import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:halan/base/routes.dart';
import 'package:halan/page/home_page/home_page.dart';
import 'package:halan/page/splash/splash.dart';
import 'package:halan/base/styles.dart';

import 'package:halan/pages/default_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RoutesName.splashPage,
      onGenerateRoute: (RouteSettings settings) => routeSettings(settings),
      debugShowCheckedModeBanner: false,
      theme: themeData,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale('vi', 'VN'), // Viet Nam
      ],
    );
  }
}

MaterialPageRoute<dynamic> routeSettings(
  RouteSettings settings,
) {
  final dynamic data = settings.arguments;
  switch (settings.name) {
    case RoutesName.splashPage:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => SplashPage(),
        settings: const RouteSettings(name: RoutesName.splashPage),
      );
    case RoutesName.homePage:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => HomePage(),
        settings: const RouteSettings(name: RoutesName.homePage),
      );
    default:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => DefaultPage(),
        settings: const RouteSettings(name: RoutesName.defaultPage),
      );
  }
}
