import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:halan/base/routes.dart';
import 'package:halan/page/promotion_page/promotion_page.dart';
import 'package:halan/page/select_date/calendar_page.dart';
import 'package:halan/pages/default_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences prefs;
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
      initialRoute: RoutesName.promotionPage,
      onGenerateRoute: (RouteSettings settings) => routeSettings(settings),
      debugShowCheckedModeBanner: false,
//      theme: themeData,
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
        builder: (BuildContext context) => DefaultPage(),
        settings: const RouteSettings(name: RoutesName.splashPage),
      );
    case RoutesName.calendarPage:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) =>CalendarPage(),
        settings: const RouteSettings(name: RoutesName.calendarPage),
      );
    case RoutesName.promotionPage:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) =>PromotionPage(),
        settings: const RouteSettings(name: RoutesName.promotionPage),
      );
    default:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) =>  DefaultPage(),
        settings: const RouteSettings(name: RoutesName.defaultPage),
      );
  }
}

