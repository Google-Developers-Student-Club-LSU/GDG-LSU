//
// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
// Authors: Dina Taing
//





// UPCOMING EVENTS
//Title, Description, Date, Color  is required to create an events 
// if time is not yet available please put it less than or equal 30 min gap eg 
//                  (year, month, day, hour, mins) 
//    "date": DateTime(2025, 6, 15, 10, 0),
//    "endDate": DateTime(2025, 6, 15, 10, 30),
// Image, Time, Room number is no required can be update later

// General Body Meeting = Green, Workshop = Blue, OtherEvents = Red
import 'package:gdgwebsite/Colors.dart';

final List<Map<String, dynamic>> myEvents = [
  {
    "title": "General Body Meeting",
    "date": DateTime(2025, 7, 15, 10, 0),
    "endDate": DateTime(2025, 7, 15, 10, 30),
    "description": "Weekly sync-up with the team to discuss goals.",
    "color": gGreen,
    "room" : "PFT 1200",
    "galleryUrl" : "https://ww4.fmovies.co/film/family-guy-season-11-9393/"
  },
    {
    "title": "General Body Meeting",
    "date": DateTime(2025, 6, 15, 10, 0),
    "endDate": DateTime(2025, 6, 15, 10, 30),
    "description": "Weekly sync-up with the team to discuss goals.",
    "color": gGreen,
    "room" : "PFT 1200"
  },
  {
    "title": "Firebase WorkShop",
    "date": DateTime(2025, 7, 16, 14, 30),
    "endDate": DateTime(2025, 7, 16, 15,00 ),
    "description": "Annual physical check-up at local clinic.",
    "color": gBlue,
    "room" : "PFT 1202"
  },
  {
    "title": "Flutter Workshop",
    "date": DateTime(2025, 7, 17, 9, 0),
    "endDate": DateTime(2025, 7, 17, 12, 0),
    "description": 
    '''
Join us for an engaging hands-on workshop where you'll learn how to build modern, responsive mobile apps using Flutter, Google's open-source UI toolkit. Whether you're a beginner or looking to sharpen your cross-platform development skills, this session will guide you through the fundamentals of Dart, Flutter widgets, layouts, and state management.

Bring your laptop and get ready to code!
      ''',
    "image": "assets/events/Flutter.jpg",
    "color": gBlue,
    "room" : "PFT 1209"
  },
    {
    "title": "Hackathon",
    "date": DateTime(2025, 7, 30, 14, 30),
    "endDate": DateTime(2025, 7, 30, 15, 30),
    "description": "Annual physical check-up at local clinic.",
    "color": gRed,
    "room" : "PFT 1219",
  },
];
