import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halan/base/color.dart';

class AppPadding {
  static const EdgeInsets normalPadding = EdgeInsets.all(16);
}

final ThemeData themeData = ThemeData(
    primaryColor: AppColor.primaryColor,
    primaryColorBrightness: Brightness.dark,
    accentColorBrightness: Brightness.light,
    primaryColorLight: AppColor.primaryLightColor,
    backgroundColor: AppColor.backgroundColor,
    iconTheme: iconThemeData,
    appBarTheme: appBarTheme,
    buttonTheme: buttonThemeData,
    buttonColor: AppColor.primaryColor,
    disabledColor: AppColor.disableColor,
    scaffoldBackgroundColor: AppColor.backgroundColor,
    dialogTheme: dialogTheme,
    textTheme: textTheme
//  primarySwatch: MaterialColor(AppColor.primaryColor.value, AppColor.colorCodes),
    );

final DialogTheme dialogTheme = DialogTheme(
  backgroundColor: AppColor.white,
  titleTextStyle: textTheme.headline6,
  contentTextStyle: textTheme.bodyText1,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
);
const ButtonThemeData buttonThemeData = ButtonThemeData(
  disabledColor: AppColor.disableColor,
  buttonColor: AppColor.primaryColor,
  textTheme: ButtonTextTheme.primary,
);

final AppBarTheme appBarTheme = AppBarTheme(
  elevation: 0,
  iconTheme: iconThemeData.copyWith(color: AppColor.textColor),
  color: AppColor.backgroundColor,
  brightness: Brightness.light,
  actionsIconTheme: iconThemeData,
  textTheme: textTheme.copyWith(
      headline6: textTheme.headline6),
);

const IconThemeData iconThemeData = IconThemeData(
  color: AppColor.iconColor,
);

final TextTheme textTheme = TextTheme(
  headline1: GoogleFonts.montserrat(
      fontSize: 97, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: GoogleFonts.montserrat(
      fontSize: 61, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3: GoogleFonts.montserrat(fontSize: 48, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.montserrat(
      fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w400),
  headline6: GoogleFonts.montserrat(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      color: AppColor.textColor),
  subtitle1: GoogleFonts.montserrat(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
      color: AppColor.textColor),
  subtitle2: GoogleFonts.montserrat(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      color: AppColor.textColor),
  bodyText1: GoogleFonts.openSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    color: AppColor.textColor,
  ),
  bodyText2: GoogleFonts.openSans(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: AppColor.textColor),
  button: GoogleFonts.openSans(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
      color: AppColor.textColor),
  caption: GoogleFonts.openSans(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      color: AppColor.textColor),
  overline: GoogleFonts.openSans(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
      color: AppColor.textColor),
);
