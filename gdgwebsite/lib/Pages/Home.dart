//
// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
//
// Authors: Dina Taing
//

import 'package:flutter/material.dart';
import 'package:gdgwebsite/Widgets/Appbar.dart';
import 'package:gdgwebsite/utils/Slideshow.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double scrollOffset = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            setState(() {
              scrollOffset = notification.metrics.pixels;
            });
          }
          return true;
        },
        child: ListView(
          children: [
            _buildAnimatedSlideshow(scrollOffset),
            const SizedBox(height: 600, child: Center(child: Text("More content goes here..."))),
          ],
        ),
      ),
    );
  }



  Widget _buildAnimatedSlideshow(double offset) {
    const double maxOffset = 200;
    final double clampedOffset = offset.clamp(0, maxOffset);

    // Shrinks from 1.0 to 0.8
    final double scale = 1.0 - (clampedOffset / maxOffset) * 0.2;

    // Moves right up to ~133 pixels
    final double translateX = clampedOffset / 1.5;

    return Transform.translate(
      offset: Offset(translateX, 0),
      child: Transform.scale(
        scale: scale,
        alignment: Alignment.center,
        child: const AutoSlideCarousel(imagePaths: [
          'firstSlide/slide1.png',
          'firstSlide/slide2.png',
          'firstSlide/slide3.png',
        ]),
      ),
    );
  }
}