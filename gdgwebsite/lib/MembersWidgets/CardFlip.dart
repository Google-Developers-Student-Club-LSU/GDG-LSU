import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';

import 'dart:math' as math;

import 'package:url_launcher/url_launcher.dart';


const _cardSize = Size(560, 320); // one source of truth

class CardFlip extends StatefulWidget {
  const CardFlip({super.key});

  @override
  State<CardFlip> createState() => _CardFlipState();
}

class _CardFlipState extends State<CardFlip> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutCubic);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _toggle() {
    if (_ctrl.status == AnimationStatus.completed) {
      _ctrl.reverse();
    } else {
      _ctrl.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _cardSize.width,
      height: _cardSize.height,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: _toggle,
          child: AnimatedBuilder(
            animation: _anim,
            builder: (context, _) {
              final angle = _anim.value * math.pi;
              final showFront = angle <= math.pi / 2;

              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.0015)
                  ..rotateY(angle),
                child: showFront
                    ? FrontCard(size: _cardSize)
                    : Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..rotateY(math.pi),
                        child: BackCard(size: _cardSize),
                      ),
              );
            },
          ),
        ),
      ),
    );
  }
}



class FrontCard extends StatelessWidget {
  const FrontCard({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: gPurple.withOpacity(.15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: gPurple.withOpacity(.3),
                width: 1.5,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "How to Become a Member?",
                    style: standardText.copyWith( fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                  Text("(Tap to see more information)",
                  style: standardText.copyWith( fontSize: 15),
                    textAlign: TextAlign.center,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class BackCard extends StatelessWidget {
  const BackCard({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    final isMobile = size.width < 600;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: gPurple.withOpacity(.12),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: gPurple.withOpacity(.28),
                width: 1.5,
              ),
            ),
            child: SingleChildScrollView( // prevents overflow but keeps card size
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "How to Become a Member?",
                    textAlign: TextAlign.center,
                    style: standardText.copyWith(
                      fontSize: isMobile ? 20 : 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 1,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          gPurple.withOpacity(.6),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _StepLine(index: 1, text: "Pay \$20 for the entire year", isMobile: isMobile),
                  _StepLine(index: 2, text: "Join TigerLink", isMobile: isMobile),
                  _StepLine(index: 3, text: "Complete Hazing Prevention", isMobile: isMobile),
                  const SizedBox(height: 12),
                  Text(
                    "Follow these three simple steps to get started. The form below includes detailed guidance for completing each one.",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: standardText.copyWith(
                      fontSize: isMobile ? 14 : 16,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: 25,),
                  Center(
                    child: GlassButton(label: "Sign Up Form", url: "https://forms.gle/ks8xigwXhcaVQCw7A"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StepLine extends StatelessWidget {
  const _StepLine({required this.index, required this.text, required this.isMobile});
  final int index;
  final String text;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$index.",
            style: standardText.copyWith(
          
              fontSize: isMobile ? 16 : 18,
              height: 1.4,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              softWrap: true,
              style: standardText.copyWith(
               
                fontSize: isMobile ? 16 : 18,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class GlassButton extends StatelessWidget {
  const GlassButton({
    super.key,
    required this.label,
    required this.url,
  });

  final String label;
  final String url;

  Future<void> _openUrl(BuildContext context) async {
    final uri = Uri.parse(url);
    final ok = await launchUrl(
      uri,
      mode: LaunchMode.platformDefault,
      webOnlyWindowName: '_blank',
    );
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open link')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(10);

    return ClipRRect(
      borderRadius: borderRadius,
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: const SizedBox.shrink(),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: borderRadius,
              onTap: () => _openUrl(context),
              hoverColor: Colors.white.withValues(alpha: .04),
              child: Container(
                constraints: const BoxConstraints(minHeight: 30, minWidth: 70),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: gPurple.withValues(alpha: .14),
                  borderRadius: borderRadius,
                  border: Border.all(color: gPurple.withValues(alpha: .28), width: 1.2),
                ),
          child:  Center(
            child: Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: standardText.copyWith(fontSize: 14, height: 1.0),
                      ),
          ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
