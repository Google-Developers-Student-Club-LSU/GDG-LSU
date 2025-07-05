//
//
// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
//
// Authors: Dina Taing
//

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';

class AutoSlideCarousel extends StatefulWidget {
  final List<String> imagePaths;
  final double height;
  final Duration interval;
  final Duration transitionDuration;
  final BoxFit fit;

  const AutoSlideCarousel({
    super.key,
    required this.imagePaths,
    this.height = 1000,
    this.interval = const Duration(seconds: 3),
    this.transitionDuration = const Duration(milliseconds: 500),
    this.fit = BoxFit.cover,
  });

  @override
  State<AutoSlideCarousel> createState() => _AutoSlideCarouselState();
}

class _AutoSlideCarouselState extends State<AutoSlideCarousel> {
  Timer? _timer;
late PageController _controller;

@override
void initState() {
  super.initState();
  _controller = PageController(initialPage: 1);
  _startAutoSlide();
}

  List<String> get _loopedImages {
  final images = widget.imagePaths;
  if (images.length <= 1) return images;
  return [images.last, ...images, images.first];
}


void _startAutoSlide() {
  _timer = Timer.periodic(widget.interval, (_) {
    if (_controller.hasClients) {
      _controller.nextPage(
        duration: widget.transitionDuration,
        curve: Curves.easeInOut,
      );
    }
  });
}


  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

@override
Widget build(BuildContext context) {
  return AbsorbPointer(
    absorbing: true,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        border: Border.all(
          color: gBlue.withAlpha(2),
          width: 2,
        ),
      ),
      child: SizedBox(
        height:  MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: PageView.builder(
          controller: _controller,
          itemCount: _loopedImages.length,
          onPageChanged: (index) {
            if (index == 0) {
              Future.microtask(() {
                _controller.jumpToPage(_loopedImages.length - 2);
              });
            } else if (index == _loopedImages.length - 1) {
              Future.microtask(() {
                _controller.jumpToPage(1);
              });
            }
          },
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                _loopedImages[index],
                fit: widget.fit,
                width: double.infinity,
                height: double.infinity,
              ),
            );
          },
        ),
      ),
    ),
  );
}
}