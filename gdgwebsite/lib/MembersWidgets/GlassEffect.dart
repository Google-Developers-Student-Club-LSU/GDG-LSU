import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';

class GlassEffect extends StatelessWidget {
  const GlassEffect({super.key, required this.children, this.title});
  final Widget? title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    final double maxW = isMobile ? size.width * 0.85 : size.width * 0.5;

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxW),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: gPurple.withOpacity(.12),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: gPurple.withOpacity(.28), width: 1.5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (title != null) ...[
                      title!,
                      const SizedBox(height: 24),
                    ],
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return Center(
                          child: ConstrainedBox(
                            constraints:
                                BoxConstraints(minWidth: constraints.maxWidth),
                            child: Center(
                              child: Wrap(
                                direction: Axis.horizontal,
                                runAlignment: WrapAlignment.center,
                                alignment: WrapAlignment.center,
                                spacing: 20,
                                runSpacing: 20,
                                children: children.map((c) {
                                  return ConstrainedBox(
                                    constraints:
                                        const BoxConstraints(maxWidth: 320),
                                    child: c,
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                 const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
