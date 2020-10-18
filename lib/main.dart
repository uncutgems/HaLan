import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:halan/base/constant.dart';
import 'package:halan/base/routes.dart';
import 'package:halan/base/styles.dart';
import 'package:halan/page/bus_booking/bus_booking_page.dart';
import 'package:halan/page/home_otp/home_otp.dart';

import 'package:halan/page/home_page/home_page.dart';
import 'package:halan/page/log_in/home_signin.dart';
import 'package:halan/page/splash/splash.dart';
import 'package:halan/pages/default_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:halan/page/promotion_page/promotion_page.dart';
import 'package:halan/page/select_date/calendar_page.dart';
import 'package:halan/page/select_place/select_place_page.dart';
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
      theme: themeData,
      initialRoute: RoutesName.splashPage,
      onGenerateRoute: (RouteSettings settings) => routeSettings(settings),
      debugShowCheckedModeBanner: false,
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
        builder: (
          BuildContext context,
        ) =>
            SplashPage(),
        settings: const RouteSettings(name: RoutesName.splashPage),
      );

    case RoutesName.homePage:
      return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => HomePage(),
          settings: const RouteSettings(name: RoutesName.homePage));

    case RoutesName.calendarPage:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => CalendarPage(),
        settings: const RouteSettings(name: RoutesName.calendarPage),
      );
    case RoutesName.promotionPage:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => PromotionPage(),
        settings: const RouteSettings(name: RoutesName.promotionPage),
      );
    case RoutesName.selectPlacePage:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => SelectPlacePage(),
        settings: const RouteSettings(name: RoutesName.selectPlacePage),
      );
    case RoutesName.busBookingPage:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => BusBookingPage(),
        settings: const RouteSettings(name: RoutesName.busBookingPage),
      );
    case RoutesName.homeSignInPage:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => HomeSignInPage(),
        settings: const RouteSettings(name: RoutesName.homeSignInPage),
      );
    case RoutesName.homeOtpPage:
      return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => HomeOtpPage(
                phoneNumber: data[Constant.phoneNumber] as String,
              ),
          settings: const RouteSettings(name: RoutesName.homeOtpPage));
    default:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => DefaultPage(),
        settings: const RouteSettings(name: RoutesName.defaultPage),
      );
  }
}

class ScaleRoute extends PageRouteBuilder<dynamic> {
  ScaleRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              ScaleTransition(
            scale: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              ),
            ),
            child: child,
          ),
        );
  final Widget page;
}
