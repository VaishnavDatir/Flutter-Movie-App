import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

final ThemeData appTheme = buildAppTheme();

ThemeData buildAppTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: kColorBlack,
    primaryColor: kColorSecondYellow,
    accentColor: kColorBlue,
    appBarTheme: ThemeData.light().appBarTheme.copyWith(
          elevation: 0,
          color: kColorTransparent,
          brightness: Brightness.dark,
        ),
    textTheme: buildAppTextTheme(GoogleFonts.notoSansTextTheme()),
  );
}

TextTheme buildAppTextTheme(TextTheme textTheme) {
  return textTheme.copyWith(
    headline1: textTheme.headline1.copyWith(
        fontSize: 30.0,
        fontWeight: FontWeight.w400,
        color: kColorTextWhite,
        letterSpacing: 1),
    headline2: textTheme.headline2.copyWith(
        fontSize: 24.0,
        fontWeight: FontWeight.w700,
        color: kColorTextWhite,
        letterSpacing: 1),
    headline3: textTheme.headline3.copyWith(
        fontSize: 22.0,
        fontWeight: FontWeight.w600,
        color: kColorTextWhite,
        letterSpacing: 1),
    headline4: textTheme.headline4.copyWith(
        fontSize: 20.0,
        fontWeight: FontWeight.w700,
        color: kColorTextWhite,
        letterSpacing: 1),
    subtitle1: textTheme.subtitle1.copyWith(
        fontSize: 17.0,
        fontWeight: FontWeight.w500,
        color: kColorTextWhite,
        letterSpacing: 1),
    subtitle2: textTheme.subtitle2.copyWith(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: kColorTextWhite,
        letterSpacing: 1),
    bodyText1: textTheme.bodyText1.copyWith(
      fontSize: 17.0,
      fontWeight: FontWeight.w400,
      color: kColorTextWhite,
      letterSpacing: 0.5,
    ),
    bodyText2: textTheme.bodyText2.copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: kColorTextWhite,
        letterSpacing: 1),
    button: textTheme.button.copyWith(
        fontSize: 17.0,
        fontWeight: FontWeight.w700,
        color: kColorTextWhite,
        letterSpacing: 1),
    caption: textTheme.caption.copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
        color: kColorTextWhite,
        letterSpacing: 1),
  );
}
