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
          _buildAnimatedSlideshow(scrollOffset),
          const SizedBox(
            height: 600,
            child: Center(child: Text("More content goes here...")),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedSlideshow(double offset) {
    const double maxOffset = 200;
    final double clampedOffset = offset.clamp(0, maxOffset);

    final double scale = 1.0 - (clampedOffset / maxOffset) * 0.5;
    final double translateX = clampedOffset / 0.5;

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
