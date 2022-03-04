import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData themeDark = ThemeData(
  primarySwatch: Colors.teal,
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: const AppBarTheme(
    color: Colors.black12,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 30,
    selectedItemColor: Colors.blue,
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Colors.grey[300],
    showUnselectedLabels: false,
    backgroundColor: Colors.black12,
  ),
  cardTheme: CardTheme(color: HexColor('333739')),
  textTheme: TextTheme(
      bodyText1: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      headline5: GoogleFonts.poppins(
          fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
      headline6: GoogleFonts.poppins(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      subtitle1: GoogleFonts.poppins(
          fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white)),
);
ThemeData themeLight = ThemeData(
  primarySwatch: Colors.teal,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 20,
    selectedItemColor: Colors.blue,
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Colors.grey[600],
    showUnselectedLabels: false,
  ),
  cardTheme: CardTheme(color: Colors.white),
  textTheme: TextTheme(
      bodyText1: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      headline5: GoogleFonts.poppins(
          fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
      headline6: GoogleFonts.poppins(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
      subtitle1: GoogleFonts.poppins(
          fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black)),
);
