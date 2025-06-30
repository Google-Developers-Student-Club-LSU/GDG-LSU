//
//
// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
//
// Authors: Dina Taing
//

import 'dart:ui';

import 'package:calendar_view/src/style/header_style.dart';

class Event {
  final String title;
  final String description;
  final String? image;
  final Color color;
  final String? room;

  Event( {
    required this.title,
    required this.description,
    this.image, 
    this.room,
    required this.color,
  });

 
}
