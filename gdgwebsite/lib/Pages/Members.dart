
import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';
import 'package:gdgwebsite/Constants.dart';
import 'package:gdgwebsite/MembersWidgets/CardFlip.dart';
import 'package:gdgwebsite/MembersWidgets/GlassEffect.dart';
import 'package:gdgwebsite/RandomArts/AuroraBackground.dart';
import 'package:gdgwebsite/Utils/CIickableImageLink.dart';
import 'package:gdgwebsite/Widgets/Appbar.dart';
import 'package:gdgwebsite/Widgets/Footbar.dart';

class Members extends StatelessWidget {
  const Members({super.key});

  @override
  Widget build(BuildContext context) {
    final  screenSize = MediaQuery.of(context).size;
    final scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      appBar: const Appbar(borderColor: gPurple),
      body: CustomScrollView(  // Use CustomScrollView for better flexibility
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        "Membership",
                        style: standardText,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                     isMobile ? 
                     WhyBecomeAMemberMobile(screenSize: screenSize, scaffoldColor: scaffoldColor, isMobile: isMobile)
                     :
                      Row(
                        children: [
                          WhyBecomeAMember(screenSize: screenSize, scaffoldColor: scaffoldColor, isMobile: isMobile),
                          SizedBox(width:  screenSize.width* (isMobile? 0.3: 0.02)),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              width: screenSize.width * 0.3,
                              constraints: BoxConstraints(minWidth: 150 ),
                              child: Image.asset(
                               thinkLikeADev,
                               fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 34),
                      GlassEffect(
                        title: 
                        FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(child: Text("Be Part of Our Communnity", textAlign: TextAlign.center, style: standardText.copyWith(fontSize: 30), )),
                                Image.asset(globe, width: 50,)
                              ],
                            
                            ),
                        ),
                        children: [
                            Center(child: ClickableImageLink(imageAsset: discordLogo, linkUrl: discordInviteLink)),
                            Center(child: ClickableImageLink(imageAsset: tigerlinkLogo, linkUrl: tigerlinkLink)),
                            Center(child: ClickableImageLink(imageAsset: gDSCLogo, linkUrl: gdgGoogleLink, width: 200,),),
                      ],),
                      const SizedBox(height: 34),
                      Center(child: CardFlip()),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Footer as a sliver to stick to the bottom
          SliverFillRemaining(
            hasScrollBody: false,  // Footer should not scroll with the body
            child: FooterBar(footbarColor: gPurple),
          ),
        ],
      ),
    );
  }
}





class WhyBecomeAMember extends StatelessWidget {
  const WhyBecomeAMember({
    super.key,
    required this.screenSize,
    required this.scaffoldColor,
    required this.isMobile,
  });

  final Size screenSize;
  final Color scaffoldColor;
  final bool isMobile;



  @override
  Widget build(BuildContext context) {
    final double cardWidth = isMobile? screenSize.width * 0.9:screenSize.width * 0.6;
    final double cardHeight =  screenSize.height * 0.9;

    


    return Container(
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        color: scaffoldColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFBC13FE).withValues(alpha: .5),
            offset: const Offset(0, 0),
            blurRadius: 15,
            spreadRadius: 5,
          ),
        ],
        border: Border.all(
          color: gPurple, // keep your theme color
          width: 3,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SelectableRegion(
          selectionControls: materialTextSelectionControls,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Why Join GDG LSU?",
                textAlign: TextAlign.center,
                style: standardText.copyWith(fontSize: isMobile ? 28 : 40),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                  itemCount: whyJoinGDGReasons.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("• ", style: TextStyle(fontSize: 18, )),
                          Expanded(
                            child: Text(
                              whyJoinGDGReasons[index],
                              style: const TextStyle(fontSize: 20,),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class WhyBecomeAMemberMobile extends StatelessWidget {
  const WhyBecomeAMemberMobile({
    super.key,
    required this.screenSize,
    required this.scaffoldColor,
    required this.isMobile,
  });

  final Size screenSize;
  final Color scaffoldColor;
  final bool isMobile;



  @override
  Widget build(BuildContext context) {
    final double cardWidth = isMobile? screenSize.width * 0.9:screenSize.width * 0.6;
    final double cardHeight =  screenSize.height * 0.9;

    


    return Container(
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        color: scaffoldColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFBC13FE).withValues(alpha: .5),
            offset: const Offset(0, 0),
            blurRadius: 15,
            spreadRadius: 5,
          ),
        ],
        border: Border.all(
          color: gPurple, 
          width: 3,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SelectableRegion(
          selectionControls: materialTextSelectionControls,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Why Join GDG LSU?",
                    textAlign: TextAlign.center,
                    style: standardText.copyWith(fontSize: isMobile ? 28 : 40),
                  ),
                  SizedBox(width: 20,),
                  Image.asset(thinkLikeADev, width: 70)
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                  itemCount: whyJoinGDGReasons.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("• ", style: TextStyle(fontSize: 18, )),
                          Expanded(
                            child: Text(
                              whyJoinGDGReasons[index],
                              style: const TextStyle(fontSize: 20,),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
