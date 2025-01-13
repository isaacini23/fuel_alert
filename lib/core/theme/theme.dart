import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
    fontFamily: "Poppins",
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xff333333)),
      titleLarge: TextStyle(color: Color(0xff333333)),
      titleSmall: TextStyle(color: Color(0xff444444)),
      displayLarge: TextStyle(color: Color(0xff444444)),
      titleMedium: TextStyle(color: Color(0xff737373)),
      headlineLarge: TextStyle(color: Color(0xff5D656D)),
      headlineMedium: TextStyle(color: Color(0xff495057)),
      headlineSmall: TextStyle(color: Color(0xff575757)),
      displayMedium: TextStyle(color: Color(0xff1C1C1C),),
    ),
    secondaryHeaderColor: const Color(0xffF6FBF7),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xffFAFAFA),
      hintStyle: const TextStyle(color: Color(0xffCCCCCC), fontSize: 16),
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffD6D6D6), width: 0.76),
          borderRadius: BorderRadius.circular(6.1)),
    ),
    cardColor: Colors.white,
    canvasColor: const Color(0xffF7F7F7),
    dividerTheme: const DividerThemeData(color: Color(0xffD9D9D9)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xffFBFBFB), elevation: 0),
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      elevation: 2,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      surfaceTintColor: Colors.white,
      color: Colors.white,
      elevation: 2,
    ),
    iconTheme: const IconThemeData(color: Color(0xff575757)),
    unselectedWidgetColor: const Color(0xffF9F9F9),
    dialogBackgroundColor: Color(0xffF3F3F3),
    iconButtonTheme: const IconButtonThemeData(
        style:
            ButtonStyle(iconColor: WidgetStatePropertyAll(Color(0xff575757)))),
    hoverColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            disabledBackgroundColor: const Color(0xff4cb870))),
    highlightColor: const Color(0xffF3F3F3),
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff009933)));

final ThemeData darkTheme = ThemeData(
    fontFamily: "Poppins",
    scaffoldBackgroundColor: const Color(0xff1A1D21),
    canvasColor: const Color(0xff1A1D21),
    secondaryHeaderColor: const Color(0xff212529),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xffD3D9DE)),
      titleLarge: TextStyle(color: Color(0xffD3D9DE)),
      titleSmall: TextStyle(color: Color(0xffD3D9DE)),
      displayLarge: TextStyle(color: Color(0xffD3D9DE)),
      titleMedium: TextStyle(color: Color(0xffD3D9DE)),
      headlineLarge: TextStyle(color: Color(0xffD3D9DE)),
      headlineMedium: TextStyle(color: Color(0xffD3D9DE)),
      headlineSmall: TextStyle(color: Color(0xffD3D9DE)),
      displayMedium: TextStyle(color: Color(0xffD3D9DE),),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            disabledBackgroundColor: const Color(0xff4cb870))),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xff212529),
      hintStyle: const TextStyle(color: Color(0xff808C99), fontSize: 16),
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xff3D454C), width: 0.76),
          borderRadius: BorderRadius.circular(6.1)),
    ),
    hoverColor: const Color(0xff1D2024),
    cardColor: const Color(0xff212529),
    dividerTheme: const DividerThemeData(color: Color(0xff3D454C)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xff14171A), elevation: 0),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff14171A),
      surfaceTintColor: Color(0xff14171A),
      elevation: 2,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      surfaceTintColor: Color(0xff14171A),
      color: Color(0xff14171A),
      elevation: 2,
    ),
    iconTheme: const IconThemeData(color: Color(0xffD3D9DE)),
    unselectedWidgetColor: const Color(0xff1A1D21),
    dialogBackgroundColor: const Color(0xff212529),
    iconButtonTheme: const IconButtonThemeData(
        style:
            ButtonStyle(iconColor: WidgetStatePropertyAll(Color(0xffD3D9DE)))),
    highlightColor: const Color(0xff1D2024),
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff009933)));
