
import 'dart:async';
import 'package:flutter/material.dart';

class AutoSlideCarousel extends StatefulWidget {
  final List<String> imagePaths;
  final double height;
  final Duration interval;
  final Duration transitionDuration;
  final BoxFit fit;

  const AutoSlideCarousel({
    super.key,
    required this.imagePaths,
    this.height = 250,
    this.interval = const Duration(seconds: 3),
    this.transitionDuration = const Duration(milliseconds: 500),
    this.fit = BoxFit.cover,
  });

  @override
  State<AutoSlideCarousel> createState() => _AutoSlideCarouselState();
}

class _AutoSlideCarouselState extends State<AutoSlideCarousel> {
  final PageController _controller = PageController();
  Timer? _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(widget.interval, (_) {
      _currentIndex = (_currentIndex + 1) % widget.imagePaths.length;
      _controller.animateToPage(
        _currentIndex,
        duration: widget.transitionDuration,
        curve: Curves.easeInOut,
      );
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
    return SizedBox(
      height: 877,
      width: double.infinity,
      child: PageView.builder(
        controller: _controller,
        itemCount: widget.imagePaths.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(24), 
            child: Image.asset(
              widget.imagePaths[index],
              fit: widget.fit,
              width: double.infinity,
              height: double.infinity,
            ),
          );
        },
      ),
    );
  }
}
