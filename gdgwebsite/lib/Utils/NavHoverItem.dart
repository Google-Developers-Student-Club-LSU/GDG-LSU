//
// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
//
// Authors: Dina Taing
//



import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavHoverItem extends StatefulWidget {
  final String label;
  final String route;
  final Color baseColor;
  final Color hoverColor;

  const NavHoverItem({
    super.key,
    required this.label,
    required this.route,
    required this.baseColor,
    required this.hoverColor,
  });

  @override
  State<NavHoverItem> createState() => _NavHoverItemState();
}

class _NavHoverItemState extends State<NavHoverItem> {
  bool _isHovered = false;

  void _onEnter(PointerEnterEvent event) => setState(() => _isHovered = true);
  void _onExit(PointerExitEvent event) => setState(() => _isHovered = false);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      child: TextButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, widget.route);
        },
        child: Text(
          widget.label,
          style: GoogleFonts.ptSans(
            fontWeight: FontWeight.w200,
            fontSize: 20,
            color: _isHovered ? widget.hoverColor : widget.baseColor,
          ),
        ),
      ),
    );
  }
}
