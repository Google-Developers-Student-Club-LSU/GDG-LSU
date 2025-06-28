//
// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
//
// Authors: Dina Taing
//



import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


const colorizeColors = [
  Color.fromARGB(255, 18, 32, 180),
  gRed,  
  gYellow,
  gGreen
];

//textfont
TextStyle textFont = GoogleFonts.ptSans();

//textStyle
final TextStyle StandardTextStyled = StandardText.copyWith(
  fontSize: 60,
  color: Colors.white,
  shadows: [
    Shadow(
      blurRadius: 6,
      color: Colors.black87,
      offset: Offset(2, 2),
    ),
  ],
);
TextStyle StandardText = TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w800,
                   );

TextStyle SecondSecStyle = StandardText.copyWith(
  fontWeight: FontWeight.w500
);
// backgroundColor
const lightBackgroundColor = Color(0xFFFFFFFF);
const darkBackgroundColor = Color(0xFF000000); 

// letterColor
const lightLetterColor = Color(0xFF000000); 
const darkLetterColor = Color(0xFFFFFFFF); 


//Google color
const gBlue = Color(0xFF4285F4);
const gRed = Color(0xFFEA4335);
const gYellow = Color(0xFFFBBC05);
const gGreen = Color(0xFF34AB53);




//ThemeData
//lightMode
final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
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
      fontSize: 30,
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
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: darkLetterColor,
    ),
  ),
);

