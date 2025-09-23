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
import 'package:gdgwebsite/EventsWidgets/MonthCalendar.dart';
import 'package:gdgwebsite/HackathonSection/HackathonContainer.dart';
import 'package:gdgwebsite/Models/EventModel.dart';
import 'package:gdgwebsite/RandomArts/SmoothRandomArt.dart';
import 'package:gdgwebsite/RandomArts/TriangleMesh.dart';
import 'package:gdgwebsite/Utils/CIickableImageLink.dart';
import 'package:gdgwebsite/Utils/CustomButton.dart';
import 'package:gdgwebsite/Utils/InformationCard.dart';
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
    ResponsiveWrap(
      builder: (isMobile) {
        return 
        isMobile? firstSectionMobile(context) :
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: MediaQuery.of(context).size.width *.8,
                height: MediaQuery.of(context).size.height * .8,
                decoration: BoxDecoration(
                  border: Border.all(color: gBlue, width: 2,  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: _buildFirstSlideShow() ,
              ),
            ),
            _buildAnimatedText()
          ],
        );
      }
    ),

    HackathonContainer(),
    
     const SizedBox(height: 25),   
     Wrap(
        direction: Axis.horizontal,            // horizontal first
        alignment: WrapAlignment.center,       // center each line
        runAlignment: WrapAlignment.center,    // center the group of lines
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 20,                      // gap between items
        runSpacing: 16,                // gap between rows
        children: [
          InformationCard(
            title: "Grow",
            description: "We grow by learning together, through hands-on projects, workshops, and real-world challenges that push us beyond the classroom. Whether you're new to tech or an experienced builder, there's always more to explore.",
            size: Size(MediaQuery.of(context).size.width < 600 ? MediaQuery.of(context).size.width * .9 : 400, 400),
          ),
          InformationCard(
            title: "Connect",
            description: "We connect not just code — but people.At GDSC LSU, we bring together students from all backgrounds, majors, and skill levels to collaborate on shared goals. Whether you're a designer, developer, or simply curious, you’ll find a space to meet teammates, mentors, and lifelong friends. Together, we build more than apps — we build a community.",
            size: Size(MediaQuery.of(context).size.width < 600 ? MediaQuery.of(context).size.width * .9 : 400, 400),
          ),
          InformationCard(
            title: "Give",
            description: "Make a difference through tech-driven social impact initiatives. Give back to the community.",
            size: Size(MediaQuery.of(context).size.width < 600 ? MediaQuery.of(context).size.width * .9 : 400, 400),
          ),
        ],
      ),
      const SizedBox(height: 25),

     Center(
       child: SelectableRegion(
        selectionControls: materialTextSelectionControls,
         child: ResponsiveWrap(
           builder: (isMobile) {
         
             return isMobile ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                workshops(),
                SizedBox(height: 30,),
                Community()
         
              ],
             )
             : 
             secondSection();
           }
         ),
       ),
     ),
      SizedBox(height: 30,),
     RealworldExpr(),
      const SizedBox(height:50),
          thirdSection(context),

          const SizedBox(
            height: 50,
          ),
          Center(child: SelectableText("UPCOMING EVENTS",
          textAlign: TextAlign.center,
          style: standardText,)
          ),
          const SizedBox(
            height: 50,
          ),          
          fourthSection(),
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
           fifthSection(),
      const SizedBox(
            height: 50,
          ),            
          Center(
            child:SelectableText('Join Us',
                style: standardText.copyWith(fontWeight: FontWeight.w500),),
          ),
      const SizedBox(
            height: 50,
          ),   
          sixthSection(),
      const SizedBox(
            height: 50,
          ),   
      Center(
            child:SelectableText('Follow us',
                style: standardText.copyWith(fontWeight: FontWeight.w500),),
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
                  width: 350,
                  height:80 ,
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

  Stack firstSectionMobile(BuildContext context) {
    return Stack(
        children: [
        SizedBox(
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
                      textStyle: standardText.copyWith(
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
                      textStyle: standardText.copyWith(
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
                      textStyle: standardText.copyWith(
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












  ResponsiveWrap sixthSection() {
    return
     ResponsiveWrap(
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

  ResponsiveWrap fifthSection() {
    return ResponsiveWrap(
      builder: (isMobile) {
        return isMobile ?
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Column(
                      children: [
                        Center(child: Image.asset(iconOfficer, width: 150,)),
                        AnimatedCounter(targetNumber: numberOfficer,),
                        SelectableText('Officers',
                        style: standardText.copyWith(fontWeight: FontWeight.w500),)
                      ],
                    ),
                    const SizedBox(height: 50,),
                    Column(
                      children: [
                        Center(child: Image.asset(iconMemember, width: 150,)),
                        AnimatedCounter(targetNumber: numberMembers,),
                        SelectableText('Developers',
                        style: standardText.copyWith(fontWeight: FontWeight.w500),)
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
                        AnimatedCounter(targetNumber: numberOfficer,),
                        SelectableText('Officers',
                        style: standardText.copyWith(fontWeight: FontWeight.w500),)
                      ],
                    ),
                    const SizedBox(width: 200,),
                    Column(
                      children: [
                        Center(child: Image.asset(iconMemember, width: 150,)),
                        AnimatedCounter(targetNumber: numberMembers,),
                        SelectableText('Developers',
                        style: standardText.copyWith(fontWeight: FontWeight.w500),)
                      ],
                    ),
                    
                  ],
              );
      }
    );
  }

  Widget fourthSection() {
    return AbsorbPointer(
      absorbing: true,
      child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height,
                    child: Hero(
                      tag: "calendar",
                      child: CalendarControllerProvider<Event>(
                        controller: EventController<Event>(),
                        child: MonthCalendar(),
                      ),
                    ),
                  ),
              
              ),
    );
  }

  Stack thirdSection(BuildContext context) {
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
        color: Colors.black.withValues(alpha: .6),
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
              textStyle: standardTextStyled,
            ),
          ],
          isRepeatingAnimation: false,
        ),
        const SizedBox(height: 24),
        AnimatedTextKit(
          animatedTexts: [
            TyperAnimatedText('Think Big.', textStyle: standardTextStyled.copyWith(color: gBlue)),
            TyperAnimatedText('Build Smart.', textStyle: standardTextStyled.copyWith(color: gGreen)),
            TyperAnimatedText('Lead Change.', textStyle: standardTextStyled.copyWith(color: gRed)),
            TyperAnimatedText('Together, We Thrive.', textStyle: standardTextStyled.copyWith(color: gYellow)),
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

  Row secondSection() {
    return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      workshops(),
      const SizedBox(width:50),
      Community(),  
    ],
   );
  }

  Padding workshops() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(8.0),
            child: CircleImageContainer(imagePath:gifWorkshop, size: 200,)
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: SelectableText("Workshop", style: standardText.copyWith(fontSize: 40 ),),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: SelectableText("Hands-on learning opportunities on Python,​", style: standardText.copyWith(fontSize: 20, fontWeight: FontWeight.w500,), textAlign: TextAlign.center,),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: SelectableText("Flutter, Google Cloud, and more.​​", style: standardText.copyWith(fontSize: 20, fontWeight: FontWeight.w500),),
            )
        
          ],
        ),
      );
  }


Widget _buildAnimatedText() {
  return AnimatedTextKit(
    repeatForever: true,
    animatedTexts: 
    [
      TypewriterAnimatedText('ENCHANCE',
      textStyle: standardText.copyWith(
         fontSize: 60,
        color: gBlue
      )),
      TypewriterAnimatedText('YOUR TECHNICAL',
      textStyle: standardText.copyWith(
        fontSize: 60,
        color: gYellow
      )),
      TypewriterAnimatedText('KNOWLEDGE',
      textStyle: standardText.copyWith(
        fontSize: 60,
        color: gGreen
      ))
    ],
    totalRepeatCount: 1,
    pause: const Duration(milliseconds: 1000),
    displayFullTextOnTap: true,
    stopPauseOnTap: true,
  );
}

  Widget _buildFirstSlideShow (){
    return  AutoSlideCarousel(imagePaths: firstSlideShow
     
    );
  }


    Widget _buildSecondSlideShow(){
    return AutoSlideCarousel(imagePaths: secondSlideShow
    );
  }
    


}

class RealworldExpr extends StatelessWidget {
  const RealworldExpr({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.all(8.0),
          child: CircleImageContainer(imagePath: robot, size: 200,)),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: SelectableText("Real World Experience", style: standardText.copyWith(fontSize: 40 ),),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: SelectableText("Build and launch a production-ready app ​", style: standardText.copyWith(fontSize: 20, fontWeight: FontWeight.w500 ),),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: SelectableText("leveraging Firebase, Flutter, and more​​", style: standardText.copyWith(fontSize: 20, fontWeight: FontWeight.w500),),
          )
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
          child: CircleImageContainer(imagePath:gifCommunity, size: 200,)),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: SelectableText("Community", style: standardText.copyWith(fontSize: 40 ),),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: SelectableText("Build connections and grow your network​", style: standardText.copyWith(fontSize: 20, fontWeight: FontWeight.w500 ),),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: SelectableText("through engaging social events.​​", style: standardText.copyWith(fontSize: 20, fontWeight: FontWeight.w500),),
          )
        ],
      ),
    );
  }
}
