//
// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
//
// Authors: Dina Taing
//

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';
import 'package:gdgwebsite/Models/EventModel.dart';
import 'package:gdgwebsite/Utils/CustomButton.dart';
import 'package:gdgwebsite/Widgets/Appbar.dart';
import 'package:gdgwebsite/utils/EventsCalendar.dart';
import 'package:gdgwebsite/utils/HoverExpand.dart';
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
          Stack(
            children: [
          Positioned(
                top: MediaQuery.of(context).size.height * 0.01,
                right: MediaQuery.of(context).size.width * 0.04,
                child: Image.asset('splash/BLUE.png',
                  width:  MediaQuery.of(context).size.width * 0.1 , 
                   ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                     width: MediaQuery.of(context).size.width * 0.6,
                     height: MediaQuery.of(context).size.height * 0.6,
                    child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildSecondSlideShow(),
                  )),
                  _buildSecondText()
                ],
              ),
            ],
          ),

          const SizedBox(
            height: 50,
          ),
          Stack(
            children: [
              Positioned(
                top: MediaQuery.of(context).size.height * 0.01,
                left: MediaQuery.of(context).size.width * 0.04,
                child: Image.asset('splash/Green.png',
                  width:  MediaQuery.of(context).size.width * 0.1 , 
                   ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildThirdText(),
                  SizedBox(
                     width: MediaQuery.of(context).size.width * 0.6,
                     height: MediaQuery.of(context).size.height * 0.6,
                    child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildThirdSlideShow(),
                  )
                  ),         
                  
                ],
              ),
            ],
          ),
      const SizedBox(
            height: 50,
          ),
          Center(child:Text("UPCOMING EVENTS",
          style: StandardText,)
          ),
          Center(
            child: AbsorbPointer(
              absorbing: true,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 1000,
                child: CalendarControllerProvider<Event>(
                  controller: EventController<Event>(),
                  child: EventsCalendar(),
                ),
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: 200,
              child: HoverExpand(
                child: CustomButton(
                  buttonName: "More Details",
                  pressed: () => Navigator.pushReplacementNamed(context, '/events'),
                ),
              ),
            ),
          )

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

  Widget _buildSecondSlideShow(){
    return AutoSlideCarousel(imagePaths: [
          'secondSlide/slide1.png',
          'secondSlide/slide2.png',
          'secondSlide/slide3.jpg',
    ]
    );
  }

  Widget _buildSecondText(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
                  "CONNECT ",
                  style: StandardText
            ),
         Text(
               "WITH DEVELOPERS",
                  style: StandardText
            ),
      ],
    );
  }

    Widget _buildThirdSlideShow(){
    return AutoSlideCarousel(imagePaths: [
          'thirdSlide/slide1.png',
          'thirdSlide/slide2.jpg',
          'thirdSlide/slide3.jpg',
          'thirdSlide/slide4.jpg',
    ]
    );
  }
    Widget _buildThirdText(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
                  "OUR MISSION: ",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    
                  ),
            ),
         Text(
               "  WE GROW",
                  style: StandardText.copyWith(color: gBlue)
            ),
         Text(
               "  WE INNOVATE",
                  style: StandardText.copyWith(color: gRed)
            ),
         Text(
               "  WE BUILD",
                  style: StandardText.copyWith(color: gYellow)
            ), 
         Text(
               "  TOGETHER",
                  style: StandardText.copyWith(color: gGreen)
            ),                           
      ],
    );
  }


}
