import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class TigerText extends StatefulWidget {
  final String text;
  final TextStyle style;

  const TigerText({
    super.key,
    required this.text,
    required this.style,
  });

  @override
  State<TigerText> createState() => _TigerTextState();
}

class _TigerTextState extends State<TigerText> {
  ui.Image? tigerImage;

  @override
  void initState() {
    super.initState();
    _loadTigerPattern();
  }

  Future<void> _loadTigerPattern() async {
    final data = await DefaultAssetBundle.of(context).load('mesh/tigerStripe.jpg');
    final bytes = data.buffer.asUint8List();
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    setState(() {
      tigerImage = frame.image;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (tigerImage == null) {
      return Text(widget.text, style: widget.style); 
    }

    final shader = ImageShader(
      tigerImage!,
      TileMode.repeated,
      TileMode.repeated,
      Matrix4.identity().scaled(0.5, 0.5).storage, 
    );

    return ShaderMask(
      shaderCallback: (bounds) => shader,
      blendMode: BlendMode.srcIn,
      child: SelectableText(
        widget.text,
        style: widget.style,
        textAlign: TextAlign.center,
      ),
    );
  }
}
