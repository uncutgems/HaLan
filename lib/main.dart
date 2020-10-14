import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:halan/base/routes.dart';
import 'package:halan/base/styles.dart';
import 'package:halan/page/bus_booking/bus_booking_page.dart';
import 'package:halan/page/buses_list/buses_list_home_view.dart';
import 'package:halan/page/home_otp/home_otp.dart';

import 'package:halan/page/home_page/home_page.dart';
import 'package:halan/page/log_in/home_signin.dart';
import 'package:halan/page/payment/payment_atm/payment_atm_view.dart';
import 'package:halan/page/payment/payment_home/payment_home_view.dart';
import 'package:halan/page/payment/payment_home/payment_success_view.dart';
import 'package:halan/page/payment/payment_qr/payment_qr_home.dart';
import 'package:halan/page/payment/payment_transfer/payment_transfer_view.dart';
import 'package:halan/page/splash/splash.dart';
import 'package:halan/page/default_page.dart';
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
  prefs = await SharedPreferences.getInstance();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      initialRoute: RoutesName.paymentHomePage,
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
        builder: (BuildContext context) => SplashPage(),
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
        builder: (BuildContext context) =>SelectPlacePage(),
        settings: const RouteSettings(name: RoutesName.selectPlacePage),);
    case RoutesName.busBookingPage:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => BusBookingPage(),
        settings: const RouteSettings(name: RoutesName.busBookingPage),
      );
    case RoutesName.busesListPage:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => BusesListPage(),
        settings: const RouteSettings(name: RoutesName.busesListPage),
      );
    case RoutesName.homeSignInPage:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => HomeSignInPage(),
        settings: const RouteSettings(name: RoutesName.homeSignInPage),
      );
    case RoutesName.homeOtpPage:
      return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => HomeOtpPage(),
          settings: const RouteSettings(name: RoutesName.homeOtpPage));
      case RoutesName.paymentHomePage:
      return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => PaymentHomePage(),
          settings: const RouteSettings(name: RoutesName.paymentHomePage));
      case RoutesName.paymentSuccessPage:
      return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => PaymentSuccessPage(),
          settings: const RouteSettings(name: RoutesName.paymentSuccessPage));
      case RoutesName.paymentQRPage:
      return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => PaymentQRHomePage(),
          settings: const RouteSettings(name: RoutesName.paymentQRPage));
      case RoutesName.paymentATMPage:
      return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => PaymentATMPage(),
          settings: const RouteSettings(name: RoutesName.paymentATMPage));
      case RoutesName.paymentTransferPage:
      return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => PaymentTransferPage(),
          settings: const RouteSettings(name: RoutesName.paymentTransferPage));
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