import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:halan/base/routes.dart';
import 'package:halan/base/styles.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/page/bus_booking/bus_booking_page.dart';
import 'package:halan/page/buses_list/buses_list_home_view.dart';
import 'package:halan/page/default_page.dart';
import 'package:halan/page/history_home/history_home_view.dart';
import 'package:halan/page/history_ticket_detail/history_ticket_detail_view.dart';
import 'package:halan/page/home_otp/home_otp.dart';
import 'package:halan/page/home_page/home_page.dart';
import 'package:halan/page/log_in/home_signin.dart';
import 'package:halan/page/payment/payment_atm/payment_atm_view.dart';
import 'package:halan/page/payment/payment_home/payment_home_view.dart';
import 'package:halan/page/payment/payment_home/payment_success_view.dart';
import 'package:halan/page/payment/payment_qr/payment_qr_home.dart';
import 'package:halan/page/payment/payment_transfer/payment_transfer_view.dart';
import 'package:halan/page/promotion_page/promotion_page.dart';
import 'package:halan/page/select_date/calendar_page.dart';
import 'package:halan/page/select_place/select_place_page.dart';
import 'package:halan/page/splash/splash.dart';
import 'package:halan/page/ticket_confirm/ticket_confirm_view.dart';
import 'package:halan/page/ticket_detail/ticket_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base/constant.dart';

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
        builder: (BuildContext context) => CalendarPage(
          chosenDate: data[Constant.dateTime] as DateTime,
        ),
        settings: const RouteSettings(name: RoutesName.calendarPage),
      );
    case RoutesName.promotionPage:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => PromotionPage(),
        settings: const RouteSettings(name: RoutesName.promotionPage),
      );
    case RoutesName.selectPlacePage:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => SelectPlacePage(
          scenario: data[Constant.scenario] as int,
        ),
        settings: const RouteSettings(name: RoutesName.selectPlacePage),
      );
    case RoutesName.busBookingPage:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => BusBookingPage(),
        settings: const RouteSettings(name: RoutesName.busBookingPage),
      );
    case RoutesName.busesListPage:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => BusesListPage(
          startPoint: data[Constant.startPoint] as Point,
          endPoint:  data[Constant.endPoint] as Point,
          date: data[Constant.dateTime] as DateTime,
        ),
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
    case RoutesName.ticketConfirmPage:
      return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => TicketConfirmPage(
                trip: data[Constant.trip] as Trip,
            startPoint: data[Constant.startPoint] as Point,
            endPoint: data[Constant.endPoint] as Point,
              ),
          settings: const RouteSettings(name: RoutesName.paymentTransferPage));
    case RoutesName.historyHomePage:
      return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => HistoryHomePage(),
          settings: const RouteSettings(name: RoutesName.historyHomePage));
    case RoutesName.historyTicketDetailPage:
      return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => HistoryTicketDetailPage(
                ticket: data[Constant.ticket] as Ticket,
              ),
          settings:
              const RouteSettings(name: RoutesName.historyTicketDetailPage));
    case RoutesName.ticketDetailPage:
      return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => TicketDetailPage(),
          settings: const RouteSettings(name: RoutesName.ticketDetailPage));
    default:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => DefaultPage(),
        settings: const RouteSettings(name: RoutesName.defaultPage),
      );
  }
}

class SwipeRoute extends PageRouteBuilder<dynamic> {
  SwipeRoute({this.page})
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
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset.zero,
                  end: const Offset(1.0, 0.0),
                ).animate(secondaryAnimation),
                child: child,
              ),
            ),
          ),
        );
  final Widget page;
}

class BotToTopRoute extends PageRouteBuilder<dynamic> {
  BotToTopRoute({this.page})
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
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(animation),
            child: FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset.zero,
                  end: const Offset(0, 1),
                ).animate(secondaryAnimation),
                child: child,
              ),
            ),
          ),
        );
  final Widget page;
}
