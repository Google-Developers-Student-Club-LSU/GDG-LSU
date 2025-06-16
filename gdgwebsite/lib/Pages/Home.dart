//
// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
//
// Authors: Dina Taing
//

import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';
import 'package:gdgwebsite/Widgets/Appbar.dart';
import 'package:gdgwebsite/utils/Slideshow.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  double scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      // Avoid setState spam by throttling
      final newOffset = _scrollController.offset;
      if ((newOffset - scrollOffset).abs() > 1) {
        scrollOffset = newOffset;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(),
      body: ListView(
        controller: _scrollController,
        children: [
          Stack(children: [
            _buildAnimatedSlideshow(scrollOffset),
            _buildAnimatedText(scrollOffset),
            
          ]),
          const SizedBox(
            height: 600,
            child: Center(child: Text("More content goes here...")),
          ),
        ],
      ),
    );
  }



Widget _buildAnimatedText(double offset) {
  const double maxOffset = 200;
  final double clampedOffset = offset.clamp(0, maxOffset);

  final double baseTop = 550;
  final double translateY = -clampedOffset / 0.75; 
  final double scale = 1.0 - (clampedOffset / maxOffset) * 0.15;
  final double translateX = clampedOffset / 4; 

  return Positioned(
    top: baseTop + translateY,
    left: 50 + translateX,
    child: Transform.scale(
      scale: scale,
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ENHANCE",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w900,
                color: gBlue
              ),
            ),
            Text(
              "YOUR TECHNICAL",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w800,
                color: gGreen
              ),
            ),
            Text(
              "KNOWLEDGE",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w800,
                color: gYellow
              ),
            ),
          ],
        ),
      ),
    ),
  );
}



  Widget _buildAnimatedSlideshow(double offset) {
    const double maxOffset = 200;
    final double clampedOffset = offset.clamp(0, maxOffset);

    final double scale = 1.0 - (clampedOffset / maxOffset) * 0.5;
    final double translateX = clampedOffset / 0.75;
    

    return Transform.translate(
      offset: Offset(translateX, 0),
      child: Transform.scale(
        scale: scale,
        alignment: Alignment.center,
        child: const AutoSlideCarousel(imagePaths: [
          'firstSlide/slide1.png',
          'firstSlide/slide2.png',
          'firstSlide/slide3.png',
          'firstSlide/slide4.jpg',

        ]),
      ),
    );
  }
}
