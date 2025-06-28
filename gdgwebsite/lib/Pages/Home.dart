//
// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
//
// Authors: Dina Taing
//

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';
import 'package:gdgwebsite/Models/EventModel.dart';
import 'package:gdgwebsite/RandomArts/SmoothRandomArt.dart';
import 'package:gdgwebsite/Utils/CIickableImageLink.dart';
import 'package:gdgwebsite/Utils/CustomButton.dart';
import 'package:gdgwebsite/Utils/Footbar.dart';
import 'package:gdgwebsite/Widgets/Appbar.dart';
import 'package:gdgwebsite/utils/AnimatedCounter.dart';
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
      appBar:  Appbar(),
      body: ListView(
        controller: _scrollController,
        children: [
    Stack(children: [
        Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: const SmoothRandomArt(),
                ),
            _buildAnimatedSlideshow(scrollOffset),
            _buildAnimatedText(scrollOffset),
     ]),
     Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Workshops(),
        const SizedBox(width:50),
        Community(),  
      ],
     ),
      const SizedBox(height:50),
          Stack(
  children: [
    // 🔹 Carousel background
    Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.8,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: _buildThirdSlideShow(),
        ),
      ),
    ),

    // 🔹 Semi-transparent overlay
    Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(17),
        child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.8,
          color: Colors.black.withOpacity(0.2),
        ),
      ),
    ),

    // 🔹 Positioned animated text lower (but not fully bottom)
    Positioned(
      left: 20,
      right: 20,
      bottom: 60, // <-- adjust this value to move it up/down
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText(
                'Our Mission:',
                textStyle: StandardTextStyled,
              ),
            ],
            isRepeatingAnimation: false,
          ),
          const SizedBox(height: 24),
          AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText('We Grow', textStyle: StandardTextStyled.copyWith(color: gBlue)),
              TyperAnimatedText('We Innovate', textStyle: StandardTextStyled.copyWith(color: gGreen)),
              TyperAnimatedText('We Build', textStyle: StandardTextStyled.copyWith(color: gRed)),
              TyperAnimatedText('Together', textStyle: StandardTextStyled.copyWith(color: gYellow)),
            ],
            repeatForever: true,
            pause: const Duration(milliseconds: 1500),
          ),
        ],
      ),
    ),
  ],
),

          const SizedBox(
            height: 50,
          ),
          Center(child:Text("UPCOMING EVENTS",
          style: StandardText,)
          ),
      const SizedBox(
            height: 50,
          ),          
          Center(
               
            
                  child: CalendarControllerProvider<Event>(
                    controller: EventController<Event>(),
                    child: EventsCalendar(),
                  ),
              
              ),
          Center(
              child: HoverExpand(
                child: CustomButton(
                  width: 300,
                  height: 75  ,
                  buttonName: "More Details",
                  pressed: () => Navigator.pushReplacementNamed(context, '/events'),
                ),
              ),
          ),
      const SizedBox(
            height: 50,
          ),
           Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Center(child: Image.asset('icon/officers.png', width: 150,)),
                      AnimatedCounter(targetNumber: 8,),
                      Text('Officers',
                      style: StandardText.copyWith(fontWeight: FontWeight.w500),)
                    ],
                  ),
                  const SizedBox(width: 200,),
                  Column(
                    children: [
                      Center(child: Image.asset('icon/members.png', width: 150,)),
                      AnimatedCounter(targetNumber: 163,),
                      Text('Memebers',
                      style: StandardText.copyWith(fontWeight: FontWeight.w500),)
                    ],
                  )
                  
                ],
            ),
      const SizedBox(
            height: 50,
          ),            
          Center(
            child:Text('Join Us',
                style: StandardText.copyWith(fontWeight: FontWeight.w500),),
          ),
      const SizedBox(
            height: 50,
          ),   
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClickableImageLink(imageAsset: 'logo/Discord.png', width: 150, linkUrl: 'https://discord.com/'),
              const SizedBox(width: 200,),
              ClickableImageLink(imageAsset:'logo/TigerLink.png', width: 150, linkUrl: 'https://tigerlink.lsu.edu')

            ],
          ),
      const SizedBox(
            height: 50,
          ),           
          Center(
              child: HoverExpand(
                child: CustomButton(
                  color: gGreen,
                  width: 400,
                  height:100 ,
                  buttonName: "Sponsor Package",
                  pressed: () => Navigator.pushReplacementNamed(context, '/sponsor'),
                ),
              ),
          ),
          const SizedBox(height: 50),
          FooterBar()          

        ],
        
      ),
    );
  }

  Padding Workshops() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(8.0),
            child: Image.asset('icon/Workshop.png', width: 150,),),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text("Workshop", style: StandardText.copyWith(fontSize: 40 ),),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text("Hands-on learning opportunities on Python,​", style: StandardText.copyWith(fontSize: 20, color: gRed, fontWeight: FontWeight.w500 ),),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text("Flutter, Google Cloud, and more.​​", style: StandardText.copyWith(fontSize: 20, color: gRed, fontWeight: FontWeight.w500),),
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
          'firstSlide/slide5.png'

        ]),
      ),
    );
  }


    Widget _buildThirdSlideShow(){
    return AutoSlideCarousel(imagePaths: [
          'thirdSlide/slide1.png',
          'thirdSlide/slide2.jpg',
          'thirdSlide/slide3.jpg',
          'thirdSlide/slide4.jpg',
          'thirdSlide/slide5.png',
          'thirdSlide/slide6.jpg'
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
                  style: StandardText.copyWith( fontWeight: FontWeight.w500)
            ),
         Text(
               "  WE INNOVATE",
                  style: StandardText.copyWith(fontWeight: FontWeight.w500,)
            ),
         Text(
               "  WE BUILD",
                  style: StandardText.copyWith(fontWeight: FontWeight.w500)
            ), 
         Text(
               "  TOGETHER",
                  style: StandardText.copyWith(fontWeight: FontWeight.w500)
            ),                           
      ],
    );
  }


}

class Community extends StatelessWidget {
  const Community({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(padding: EdgeInsets.all(8.0),
          child: Image.asset('icon/Community.png', width: 145,),),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text("Community", style: StandardText.copyWith(fontSize: 40 ),),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text("Build connections and grow your network​", style: StandardText.copyWith(fontSize: 20, color: gRed, fontWeight: FontWeight.w500 ),),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text("through engaging social events.​​", style: StandardText.copyWith(fontSize: 20, color: gRed, fontWeight: FontWeight.w500),),
          )
        ],
      ),
    );
  }
}

class SplashColor extends StatelessWidget {
  const SplashColor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.01,
      left: MediaQuery.of(context).size.width * 0.04,
      child: Image.asset('splash/Green.png',
        width:  MediaQuery.of(context).size.width * 0.1 , 
         ),
    );
  }
}
