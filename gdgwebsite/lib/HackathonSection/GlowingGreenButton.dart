import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GlowingGreenButton extends StatefulWidget {
  final String text;
  final String url;

  const GlowingGreenButton({
    super.key,
    required this.text,
    required this.url,
  });

  @override
  State<GlowingGreenButton> createState() => _GlowingGreenButtonState();
}

class _GlowingGreenButtonState extends State<GlowingGreenButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _launchUrl() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch ${widget.url}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: SweepGradient(
              startAngle: 0.0,
              endAngle: 6.28,
              tileMode: TileMode.repeated,
              stops: const [0.0, 0.5, 1.0],
              transform: GradientRotation(_controller.value * 6.28),
              colors: const [
                Color(0xFF00FF66),
                Color(0xFF007F4E),
                Color(0xFF00FF66),
              ],
            ),
          ),
          child: Container(
            width: 180,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF1F3D2C),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextButton(
              onPressed: _launchUrl,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontSize: 25),
              ),
              child: Center(child: Text(widget.text)),
            ),
          ),
        );
      },
    );
  }
}
