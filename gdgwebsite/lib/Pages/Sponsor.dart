//
// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
//
// Authors: Dina Taing
//
import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';
import 'package:gdgwebsite/RandomArts/SwirlPainter.dart';
import 'package:gdgwebsite/Utils/CIickableImageLink.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(),
     
       body:
          
            
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: MagnetismField()
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: gGreen, width: 2 ),
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: Colors.transparent,
                          ),
                         
                          width: MediaQuery.of(context).size.width * 0.40 ,
                          height:  MediaQuery.of(context).size.height * 0.85 ,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            child: SfPdfViewer.asset(
                              'sponsorPackage/Sponsors.pdf',
                              controller: _pdfViewerController,
                              scrollDirection: PdfScrollDirection.vertical,
                              pageLayoutMode: PdfPageLayoutMode.continuous,
                              enableDoubleTapZooming: true,
                              canShowScrollHead: true,
                              canShowScrollStatus: true,
                              onDocumentLoaded: (details) {
                                // 1.0  fits width. You can tweak based on screen size.
                                _pdfViewerController.zoomLevel = 1.0;
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('THANK YOU TO OUR SPONSORS!',
                          style: StandardText,
                          ),
                    ),
                     Wrap(
                          children: [
                           ClickableImageLink(imageAsset: 'logo/Google.png', linkUrl: 'www.google.com')
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: SponsorLink()),
                        ),
                      ],
                    )
                  ],
                 
                ),
              ],
            ),

    );
  }
}





class SponsorLink extends StatefulWidget {
  const SponsorLink({super.key});
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
  final double _fontSize = 50;

  void _launchLink() async {
    final Uri url = Uri.parse('https://www.youtube.com');
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
