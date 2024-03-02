import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.grey[100],
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xff0074A6),
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 15),
  ),
  brightness: Brightness.light,
  useMaterial3: true,
  textTheme: TextTheme(
    labelMedium: TextStyle(fontSize: 15, color: Colors.white),
    labelSmall: TextStyle(fontSize: 12, color: Colors.white),
    displayMedium: TextStyle(
        fontSize: 13, color: Color(0xff0074A6), fontWeight: FontWeight.bold),
  ),
  colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xff0074A6),
      primary: const Color(0xff0074A6),
      secondary: Color(0xffE3EBEF)),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStatePropertyAll(
          TextStyle(color: Colors.white, fontSize: 14)),
      iconColor: MaterialStatePropertyAll(Colors.white),
      backgroundColor: MaterialStatePropertyAll(const Color(0xff0074A6)),
      shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
      enabledBorder: InputBorder.none,
      focusedBorder: OutlineInputBorder(),
      errorBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: const Color(0xff0074a6)))),
  tabBarTheme: TabBarTheme(
    unselectedLabelColor: Colors.white,
    unselectedLabelStyle: TextStyle(
      fontWeight: FontWeight.w100
    ),
    labelColor: Colors.white,
    labelStyle: TextStyle(
      fontWeight: FontWeight.w500
    )
  ),
  cardColor: Colors.white,
  cardTheme: CardTheme(
    color: Colors.white
  )
);



// DarkTheme
ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color.fromARGB(115, 36, 36, 36),
    inputDecorationTheme:
        InputDecorationTheme(filled: false, fillColor: Colors.transparent));
