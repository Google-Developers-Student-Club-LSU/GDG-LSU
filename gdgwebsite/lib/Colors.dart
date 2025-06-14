//
// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
//
// Authors: Dina Taing
//



import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//textfont
TextStyle textFont = GoogleFonts.ptSans();

//backgroundColor
const lightBackgroundColor = Color(0xFFFFFFFF);
const darkBackgroundColor = Color(0x00000000);


//letterColor 
const lightLetterColor = Color(0x00000000);
const darkLetterColor = Color(0xFFFFFFFF);


//Google color
const gBlue = Color(0xFF4285F4);
const gRed = Color(0xFFEA4335);
const gYellow = Color(0xFFFBBC05);
const gGreen = Color(0xFF34AB53);




//ThemeData
//lightMode
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: lightBackgroundColor,
  textTheme: GoogleFonts.ptSansTextTheme().apply(
    bodyColor: lightLetterColor,
    displayColor: lightLetterColor,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: lightBackgroundColor,
    foregroundColor: lightLetterColor,
    titleTextStyle: GoogleFonts.ptSans(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: lightLetterColor,
    ),
  ),
);



//DarkMode
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: darkBackgroundColor,
  textTheme: GoogleFonts.ptSansTextTheme().apply(
    bodyColor: darkLetterColor,
    displayColor: darkLetterColor,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: darkBackgroundColor,
    foregroundColor: darkLetterColor,
    titleTextStyle: GoogleFonts.ptSans(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: darkLetterColor,
    ),
  ),
);

