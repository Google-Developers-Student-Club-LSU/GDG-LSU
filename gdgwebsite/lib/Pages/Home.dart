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
import 'package:gdgwebsite/Constants.dart';
import 'package:gdgwebsite/Models/EventModel.dart';
import 'package:gdgwebsite/RandomArts/SmoothRandomArt.dart';
import 'package:gdgwebsite/RandomArts/TriangleMesh.dart';
import 'package:gdgwebsite/Utils/CIickableImageLink.dart';
import 'package:gdgwebsite/Utils/CustomButton.dart';
import 'package:gdgwebsite/Utils/ReponsiveWrap.dart';
import 'package:gdgwebsite/Widgets/FloatingDarkLightMode.dart';
import 'package:gdgwebsite/Widgets/Footbar.dart';
import 'package:gdgwebsite/Widgets/Appbar.dart';
import 'package:gdgwebsite/utils/AnimatedCounter.dart';
import 'package:gdgwebsite/utils/CircleImageContainer.dart';
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
      floatingActionButton: FloatingDarkLightmode(backgroundColor: gBlue,),
      appBar:  Appbar(borderColor: gBlue,),
      body: ListView(
        controller: _scrollController,
        children: [
    ReponsiveWrap(
      builder: (isMobile) {
        return 
        isMobile? FirstSectionMobile(context) :
      Stack(children: [
            FirstSectionBackground(),
                _buildFirstSlideShow(scrollOffset),
                _buildAnimatedText(scrollOffset),
         ]);
      }
    ),

     ReponsiveWrap(
       builder: (isMobile) {

         return isMobile ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Workshops(),
            SizedBox(height: 30,),
            Community()

          ],
         )
         : 
         SecondSection();
       }
     ),
      const SizedBox(height:50),
          ThirdSection(context),

          const SizedBox(
            height: 50,
          ),
          Center(child: SelectableText("UPCOMING EVENTS",
          style: StandardText,)
          ),
      const SizedBox(
            height: 50,
          ),          
          FourthSection(),
          Center(
              child: HoverExpand(
                child: CustomButton(
                  width: 300,
                  height: 75  ,
                  buttonName: "More Details",
                  pressed: () => Navigator.pushReplacementNamed(context, events),
                ),
              ),
          ),
      const SizedBox(
            height: 50,
          ),
           FifthSection(),
      const SizedBox(
            height: 50,
          ),            
          Center(
            child:SelectableText('Join Us',
                style: StandardText.copyWith(fontWeight: FontWeight.w500),),
          ),
      const SizedBox(
            height: 50,
          ),   
          SixthSection(),
      const SizedBox(
            height: 50,
          ),   
      Center(
            child:SelectableText('Follow us',
                style: StandardText.copyWith(fontWeight: FontWeight.w500),),
          ), 
      const SizedBox(height: 50),   
      Center(
        child: Wrap(
          runSpacing: 50 ,
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          spacing: 50,
          children: [
            ClickableImageLink(imageAsset: youtubeSquare, linkUrl: youtubeSoc),
            ClickableImageLink(imageAsset: linkedInLogo, linkUrl: linkedInSoc),
            ClickableImageLink(imageAsset: githubSquare, linkUrl: githubSoc),
            ClickableImageLink(imageAsset: xSquare , linkUrl: xSoc),
            ClickableImageLink(imageAsset: instagramSquare, linkUrl: instagramSoc),
          ],
        
        ),
      ), 
      const SizedBox(height: 50),   
          Center(
              child: HoverExpand(
                child: CustomButton(
                  color: gGreen,
                  width: 400,
                  height:100 ,
                  buttonName: "Sponsor Package",
                  pressed: () => Navigator.pushReplacementNamed(context, sponsor),
                ),
              ),
          ),
          const SizedBox(height: 50),
          FooterBar(footbarColor: gBlue,)          
        ],
        
      ),
    );
  }

  Stack FirstSectionMobile(BuildContext context) {
    return Stack(
        children: [
        Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: const TriangleMesh(),
        ),
      
      Padding(
        padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start ,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.65,),
              Align(
                    alignment: Alignment.bottomLeft,
                    child: AnimatedTextKit(animatedTexts: 
                    [
                      TypewriterAnimatedText('ENCHANCE',
                      textStyle: StandardText.copyWith(
                         fontSize: 40,
                        color: gBlue
                      ))
                    ],
                    totalRepeatCount: 1,),
                  ),
              Align(
                    alignment: Alignment.bottomLeft,
                    child: AnimatedTextKit(animatedTexts: 
                    [
                      TypewriterAnimatedText('YOUR TECHNICAL',
                      textStyle: StandardText.copyWith(
                        fontSize: 40,
                        color: gYellow
                      ))
                    ],
                    totalRepeatCount: 1,),
                  ),
              Align(
                    alignment: Alignment.bottomLeft,
                    child: AnimatedTextKit(animatedTexts: 
                    [
                      TypewriterAnimatedText('KNOWLEDGE',
                      textStyle: StandardText.copyWith(
                        fontSize: 40,
                        color: gGreen
                      ))
                    ],
                    totalRepeatCount: 1,),
                  ),
            ],
          ),
        
      ),
          
        
        ],
      );
  }












  ReponsiveWrap SixthSection() {
    return
     ReponsiveWrap(
       builder: (isMobile) {
         return isMobile ?
         Column(
          children: [
            ClickableImageLink(imageAsset: discordLogo, width: 150, linkUrl: discordInviteLink),
            const SizedBox(height: 50,),
            ClickableImageLink(imageAsset:tigerlinkLogo, width: 150, linkUrl: tigerlinkLink)
         
          ],

         )
         :Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClickableImageLink(imageAsset: discordLogo, width: 150, linkUrl: discordInviteLink),
                const SizedBox(width: 200,),
                ClickableImageLink(imageAsset:tigerlinkLogo, width: 150, linkUrl: tigerlinkLink)
         
              ],
            );
       }
     );
  }

  ReponsiveWrap FifthSection() {
    return ReponsiveWrap(
      builder: (isMobile) {
        return isMobile ?
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Column(
                      children: [
                        Center(child: Image.asset(iconOfficer, width: 150,)),
                        AnimatedCounter(targetNumber: 8,),
                        SelectableText('Officers',
                        style: StandardText.copyWith(fontWeight: FontWeight.w500),)
                      ],
                    ),
                    const SizedBox(height: 50,),
                    Column(
                      children: [
                        Center(child: Image.asset(iconMemember, width: 150,)),
                        AnimatedCounter(targetNumber: 163,),
                        SelectableText('Memebers',
                        style: StandardText.copyWith(fontWeight: FontWeight.w500),)
                      ],
                    ),

          ],
        )
         : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Center(child: Image.asset(iconOfficer, width: 150,)),
                        AnimatedCounter(targetNumber: 8,),
                        SelectableText('Officers',
                        style: StandardText.copyWith(fontWeight: FontWeight.w500),)
                      ],
                    ),
                    const SizedBox(width: 200,),
                    Column(
                      children: [
                        Center(child: Image.asset(iconMemember, width: 150,)),
                        AnimatedCounter(targetNumber: 163,),
                        SelectableText('Memebers',
                        style: StandardText.copyWith(fontWeight: FontWeight.w500),)
                      ],
                    ),
                    
                  ],
              );
      }
    );
  }

  AbsorbPointer FourthSection() {
    return AbsorbPointer(
      absorbing: true,
      child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height,
                    child: CalendarControllerProvider<Event>(
                      controller: EventController<Event>(),
                      child: EventsCalendar(),
                    ),
                  ),
              
              ),
    );
  }

  Stack ThirdSection(BuildContext context) {
    return Stack(
children: [

  Center(
    child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: _buildSecondSlideShow(),
      ),
    ),
  ),

 
  Center(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: Container(
      width: MediaQuery.of(context).size.width *  0.7999,
      height: MediaQuery.of(context).size.height * 0.7999,
        color: Colors.black.withValues(alpha: .2),
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
);
  }

  Row SecondSection() {
    return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Workshops(),
      const SizedBox(width:50),
      Community(),  
    ],
   );
  }

  Padding Workshops() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(8.0),
            child: CircleImageContainer(imagePath:gifWorkshop, size: 200,)
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: SelectableText("Workshop", style: StandardText.copyWith(fontSize: 40 ),),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: SelectableText("Hands-on learning opportunities on Python,​", style: StandardText.copyWith(fontSize: 20, color: gRed, fontWeight: FontWeight.w500 ),),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: SelectableText("Flutter, Google Cloud, and more.​​", style: StandardText.copyWith(fontSize: 20, color: gRed, fontWeight: FontWeight.w500),),
            )
        
          ],
        ),
      );
  }


Widget _buildAnimatedText(double offset) {
  const double maxOffset = 200;
  final double clampedOffset = offset.clamp(0, maxOffset);

  final double baseTop = 550;
  final double translateY = -clampedOffset / 0.85; 
  final double scale = 1.0 - (clampedOffset / maxOffset) * 0.1;
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
            SelectableText(
              "ENHANCE",
              style: StandardTextStyled.copyWith(
                fontSize: 50,
                fontWeight: FontWeight.w900,
                color: gBlue
              ),
            ),
            SelectableText(
              "YOUR TECHNICAL",
              style: StandardTextStyled.copyWith(
                fontSize: 50,
                fontWeight: FontWeight.w800,
                color: gGreen
              ),
            ),
            SelectableText(
              "KNOWLEDGE",
              style: StandardTextStyled.copyWith(
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

  Widget _buildFirstSlideShow(double offset) {
    const double maxOffset = 200;
    final double clampedOffset = offset.clamp(0, maxOffset);

    final double scale = 1.0 - (clampedOffset / maxOffset) * 0.425;
    final double translateX = clampedOffset / 0.75;
    

    return Transform.translate(
      offset: Offset(translateX, 0),
      child: Transform.scale(
        scale: scale,
        alignment: Alignment.center,
        child: const AutoSlideCarousel(imagePaths: firstSlideShow),
      ),
    );
  }


    Widget _buildSecondSlideShow(){
    return AutoSlideCarousel(imagePaths: secondSlideShow
    );
  }
    


}

class FirstSectionBackground extends StatelessWidget {
  const FirstSectionBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: const SpiralDotsArt(),
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
          child: CircleImageContainer(imagePath:gifCommunity, size: 200,)),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: SelectableText("Community", style: StandardText.copyWith(fontSize: 40 ),),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: SelectableText("Build connections and grow your network​", style: StandardText.copyWith(fontSize: 20, color: gRed, fontWeight: FontWeight.w500 ),),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: SelectableText("through engaging social events.​​", style: StandardText.copyWith(fontSize: 20, color: gRed, fontWeight: FontWeight.w500),),
          )
        ],
      ),
    );
  }
}
