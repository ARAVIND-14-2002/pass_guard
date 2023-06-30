import 'package:flutter/material.dart';

class ColorsArvi {
  static const Color primary = Color(0xff4e31aa);
  static const Color background = Color(0xffFFFFFF);
  static const Color backgroundTextField = Color(0xffF5F5F5);
  static const Color grey = Color(0xffe5e5e5);
  static const Color backgrondGrey = Color(0xffF7F8F9);
  static const Color redLogOut = Color(0xffBC4841);
  static const Color subtitle = Color(0xffd7d7d7);

  static const List<Color> primaryGradientColors = [
    Colors.red,
    Colors.purple,
  ];

  static Gradient get primaryGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: primaryGradientColors,
  );

  static const LinearGradient bottomAppBarGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.red,
      Colors.purple,
    ],
  );
}

class ThemesArvi {
  static ThemeData appTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: ColorsArvi.background,
    primaryColor: Colors.black87,
    colorScheme: const ColorScheme.light(),
    cardColor: Colors.white,
    cardTheme: const CardTheme(color: Color(0xffF8F9FA)),
    iconTheme: const IconThemeData(color: Colors.black),
    primaryColorDark: Colors.black,
    dialogBackgroundColor: ColorsArvi.background,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: ColorsArvi.background,
      iconTheme: IconThemeData(color: Colors.black),
    ),
  );

  static ThemeData appThemeDark = ThemeData(
    primaryColorDark: Color(4294309367),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF07001C),
    colorScheme: const ColorScheme.dark(),
    cardTheme: const CardTheme(color: Colors.white10),
    iconTheme: const IconThemeData(color: Color(4294309367)),
    primaryColor: Color(4294309367),
    cardColor: const Color(0xff28383d),
    dialogBackgroundColor: const Color(0xFF4F4F4F),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Color(0xFF07001C),
      iconTheme: IconThemeData(color: Color(4294309367)),
      toolbarTextStyle: TextStyle(color: Color(4294309367)),
    ),
  );
}
