import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:halan/page/calendar_page.dart';

void main() {
  runApp(MaterialApp(home: CalendarPage(),
    localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const <Locale>[
      Locale('vi', 'VN'), // Viet Nam
    ],));
}

