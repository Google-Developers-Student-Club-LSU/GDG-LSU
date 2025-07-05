//
// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
//
// Authors: Dina Taing
//
import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';
import 'package:gdgwebsite/Constants.dart';
import 'package:gdgwebsite/RandomArts/SwirlPainter.dart';
import 'package:gdgwebsite/SponsorWidget/PdfView.dart';
import 'package:gdgwebsite/Utils/CIickableImageLink.dart';
import 'package:gdgwebsite/Utils/ReponsiveWrap.dart';
import 'package:gdgwebsite/Widgets/Footbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gdgwebsite/Widgets/Appbar.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class SponsorPage extends StatefulWidget {
  const SponsorPage({super.key});

  @override
  State<SponsorPage> createState() => _SponsorPageState();
}

class _SponsorPageState extends State<SponsorPage> {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  bool _isHoveringPdf = false;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const Appbar(),
      body: Stack(
        children: [
           Positioned.fill(child: MagnetismField()),
          ReponsiveWrap(
            builder: (isMobiles) {
              return NotificationListener<ScrollNotification>(
                onNotification: (_) => _isHoveringPdf,
                child: SingleChildScrollView(
                  child: isMobiles
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: PDFView(
                                isMobile: true,
                                pdfViewerController: _pdfViewerController,
                                onHoverChanged: (hovering) =>
                                    setState(() => _isHoveringPdf = hovering),
                              ),
                            ),
                            SecondPart(isMobile: true),
                            const SizedBox(height: 30),
                            const FooterBar(),
                          ],
                        )
                      : Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: PDFView(
                                      isMobile: false,
                                      pdfViewerController: _pdfViewerController,
                                      onHoverChanged: (hovering) =>
                                          setState(() => _isHoveringPdf = hovering),
                                    ),
                                  ),
                                ),
                                SecondPart(isMobile: false),
                              ],
                            ),
                            const SizedBox(height: 30),
                            const FooterBar(),
                          ],
                        ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class SecondPart extends StatelessWidget {
  final bool isMobile;

  const SecondPart({
    this.isMobile = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 800;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
    Padding(
      padding: const EdgeInsets.all(16.0),
        child: Container(
           width: isMobile ? double.infinity : 600,
          child: SelectableText('THANK YOU TO OUR SPONSORS!',
              textAlign:TextAlign.center  ,
              style: StandardText.copyWith(fontSize: isMobile ? 40:40),
              ),
        ),
      
    ),
     Wrap(
          children: [
           ClickableImageLink(imageAsset: googleLogo, linkUrl: googleLink)
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Align(
            alignment: isMobile? Alignment.center :Alignment.centerRight ,
            child: SponsorLink()),
        ),
      ],
    );
  }
}






class SponsorLink extends StatefulWidget {
 
  const SponsorLink({
    
    super.key});
  @override
  _SponsorLinkState createState() => _SponsorLinkState();
}

class _SponsorLinkState extends State<SponsorLink>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 5),
  )..repeat(reverse: true);
  final List<Color> _colors = [gBlue, gYellow, gRed, gGreen];
  

  void _launchLink() async {
    final Uri url = Uri.parse(sponsorBookletLink);
    if (!await launchUrl(url, webOnlyWindowName: '_blank')) {
      debugPrint('Could not launch');
    }
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   bool isMobile = MediaQuery.of(context).size.width < 600;
      final double _fontSize = isMobile ? 40 : 50;;

    return InkWell(
      onTap: _launchLink,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final shader = LinearGradient(
            colors: _colors,
            stops: _colors
                .asMap()
                .map((i, _) => MapEntry(i, i / (_colors.length - 1)))
                .values
                .toList(),
            transform: GradientRotation(_controller.value * 2 * 3.14159),
          ).createShader(
            Rect.fromLTWH(0, 0, _fontSize * 3.5, _fontSize),
          );
          return CustomPaint(
            painter: _UnderlinePainter(shader, _fontSize),
            child: Text(
              'Sponsorship Booklet',
              style: StandardText.copyWith(
                fontSize: _fontSize,
                fontWeight: FontWeight.bold,
                foreground: Paint()..shader = shader,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _UnderlinePainter extends CustomPainter {
  final Shader shader;
  final double fontSize;
  _UnderlinePainter(this.shader, this.fontSize);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = shader
      ..strokeWidth = fontSize * 0.05
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(0, size.height),
      Offset(size.width, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _UnderlinePainter old) =>
      old.shader != shader;
}
