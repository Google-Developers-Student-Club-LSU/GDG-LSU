import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';
import 'package:gdgwebsite/Constants.dart';
import 'package:gdgwebsite/HackathonSection/Cloud.dart';
import 'package:gdgwebsite/HackathonSection/GlowingGreenButton.dart';
import 'package:gdgwebsite/HackathonSection/TimeRect.dart';
import 'package:gdgwebsite/Utils/CIickableImageLink.dart';
import 'package:gdgwebsite/Utils/ReponsiveWrap.dart';

class HackathonContainer extends StatefulWidget {
  const HackathonContainer({super.key});

  @override
  State<HackathonContainer> createState() => _HackathonContainerState();
}

class _HackathonContainerState extends State<HackathonContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _cloudController;
  late Animation<double> _cloudOffset;

  @override
  void initState() {
    super.initState();

    _cloudController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat(reverse: true);

    _cloudOffset = Tween<double>(begin: -50, end: 50).animate(
      CurvedAnimation(parent: _cloudController, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _cloudController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final eventDate = DateTime.parse("2025-11-07 18:00:00");
    const spaceBox = SizedBox(height: 10, width: 10);

    final dullGreen = Color.lerp(const Color(0xFF006400), Colors.grey, 0.4)!;

    return Center(
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF87CEEB),
              const Color(0xFF006400).withValues(alpha: .3),
             // const Color(0xFF00FFA3).withValues(alpha: .3),
            ],
            stops: const [0.5, 1],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF87CEEB).withValues(alpha: .5),
              blurRadius: 20,
              spreadRadius: 2,
              offset: const Offset(0, -8),
              ),
            BoxShadow(
              
              color: const Color(0xFF00FF66).withValues(alpha: .5),
              blurRadius: 20,
              spreadRadius: 2,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Container(
          width: screenSize.width * 0.7,
          height: screenSize.width * 0.4,
          constraints: const BoxConstraints(
            minHeight: 600,
            minWidth: 350,
          ),
          decoration: BoxDecoration(
            color: dullGreen.withValues(alpha: .7),
            borderRadius: BorderRadius.circular(12),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final mobile = constraints.maxWidth < 600;

              return Stack(
                children: [
                  Container(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight * 0.7,
                    decoration: const BoxDecoration(
                      color: Color(0xFF87CEEB),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                    ),
                  ),
                  Image.asset(sun, width: 100),

                  AnimatedBuilder(
                    animation: _cloudController,
                    builder: (context, child) {
                      return Positioned(
                        top: 10,
                        right: 50 + _cloudOffset.value * (2),
                        child: FloatingCloud(
                          width: 100,
                          height: 50,
                          color: Colors.grey.shade200,
                          shadowColor: Colors.transparent,
                        ),
                      );
                    },
                  ),

                  AnimatedBuilder(
                    animation: _cloudController,
                    builder: (context, child) {
                      return Positioned(
                        top: 40,
                        right: 500 + _cloudOffset.value * 3,
                        child: FloatingCloud(
                          width: 100,
                          color: Colors.white.withValues(alpha: 0.8),
                          height: 50,
                        ),
                      );
                    },
                  ),

                  Positioned(
                    left: (screenSize.width <= 700) ? 10 : 30,
                    bottom: constraints.maxHeight -
                        (constraints.maxHeight * 0.7) -
                        ((screenSize.width <= 700) ? 10 : 120),
                    child: Image.asset(
                      mike,
                      height: (screenSize.width <= 700) ? 80 : 200,
                    ),
                  ),
                  Positioned(
                    right: -(250 / 2),
                    bottom: constraints.maxHeight -
                        (constraints.maxHeight * 0.7) -
                        50,
                    child: Image.asset(
                      tree,
                      height: 300,
                    ),
                  ),
                  Positioned(
                    right: -(50 / 2),
                    bottom: constraints.maxHeight -
                        (constraints.maxHeight * 0.7) -
                        30,
                    child: Image.asset(
                      bush,
                      width: 150,
                    ),
                  ),

                  // Center content
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        spaceBox,
                        Text(
                          "GeauxHack 2025",
                          style: standardText.copyWith(
                            fontSize: mobile ? 40 : 60,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        spaceBox,
                        TimeRect(targetTime: eventDate),
                        SelectableText(
                          "Hosted by:",
                          style: standardText.copyWith(
                            color: Colors.white,
                            fontSize: mobile ? 40 : 50,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        spaceBox,
                        Center(
                          child: ResponsiveWrap(
                            builder: (isMobile) {
                              return isMobile
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ClickableImageLink(
                                          imageAsset: saseLogo,
                                          linkUrl: saseLink,
                                          width: 70,
                                        ),
                                        const SizedBox(width: 30),
                                        ClickableImageLink(
                                          imageAsset: gDSCLogo,
                                          linkUrl: 'http://gdsclsu.org/',
                                          width: 100,
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ClickableImageLink(
                                          imageAsset: saseLogo,
                                          linkUrl: saseLink,
                                          width: 100,
                                        ),
                                        const SizedBox(width: 100),
                                        ClickableImageLink(
                                          imageAsset: gDSCLogo,
                                          linkUrl: 'http://gdsclsu.org/',
                                          width: 125,
                                        ),
                                      ],
                                    );
                            },
                          ),
                        ),
                        const SizedBox(height: 50),
                        Center(
                          child: GlowingGreenButton(
                            text: "More Info",
                            url: "https://www.saselsu.org/#/hackathon",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
