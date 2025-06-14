//
//
// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
//
// Authors: Dina Taing
//

import 'package:flutter/material.dart';

class ReponsiveWrap extends StatelessWidget {
  final Widget Function(bool isMobile) builder ; 

  const ReponsiveWrap({super.key, required this.builder});

@override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return builder(isMobile);
  }
}
