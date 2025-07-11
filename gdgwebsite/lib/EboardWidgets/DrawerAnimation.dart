import 'dart:math' as math;
import 'package:flutter/gestures.dart' as ui;
import 'package:flutter/material.dart';
import 'package:gdgwebsite/EboardWidgets/Picture.dart';
import 'package:gdgwebsite/EboardWidgets/ProfileDrawer.dart';

class AnimationPage extends StatefulWidget {
  final String fullName;
  final String position;
  final String yearAndMajor;
  final String shortIntroduction;
  final String linkedinLink;
  final String assets;
  final double width;
  final double height;

  const AnimationPage({
    super.key,
    required this.fullName,
    required this.position,
    required this.yearAndMajor,
    required this.shortIntroduction,
    required this.linkedinLink,
    required this.assets,
    required this.width,
    required this.height,
  });

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _onEnter(ui.PointerEnterEvent event) {
    if (animationController.isDismissed) {
      animationController.forward();
    }
  }

  void _onExit(ui.PointerExitEvent event) {
    if (animationController.isCompleted) {
      animationController.reverse();
    }
  }

        @override
      Widget build(BuildContext context) {
        double maxSlide = widget.width;
      bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 600;

        final child = AnimatedBuilder(
          animation: animationController,
          builder: (context, _) {
            final value = animationController.value;
            return Stack(
              children: [
                Transform.translate(
                  offset: Offset(maxSlide * (value - 1), 0),
                  child: Transform(
                    alignment: Alignment.centerRight,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(math.pi / 2 * (1 - value)),
                    child: ProfileDrawer(
                      fullName: widget.fullName,
                      position: widget.position,
                      yearAndMajor: widget.yearAndMajor,
                      shortIntroduction: widget.shortIntroduction,
                      linkedinLink: widget.linkedinLink,
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(maxSlide * value, 0),
                  child: Transform(
                    alignment: Alignment.centerLeft,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(-math.pi / 2 * value),
                    child: Picture(
                      assets: widget.assets,
                      width: widget.width,
                      height: widget.height,
                    ),
                  ),
                ),
              ],
            );
          },
        );

        return isMobile(context)
            ? GestureDetector(
                onTap: () {
                  if (animationController.isDismissed) {
                    animationController.forward();
                  } else if (animationController.isCompleted) {
                    animationController.reverse();
                  }
                },
                child: child,
              )
            : MouseRegion(
                onEnter: _onEnter,
                onExit: _onExit,
                child: child,
              );
      }
    }