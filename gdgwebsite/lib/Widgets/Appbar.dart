//
// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
//
// Authors: Dina Taing
//


import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';
import 'package:gdgwebsite/Constants.dart';
import 'package:gdgwebsite/Utils/NavHoverItem.dart';
import 'package:gdgwebsite/Utils/ResponsiveAppbar.dart';

class Appbar extends StatefulWidget implements PreferredSizeWidget {
  const Appbar({super.key});

  @override
  State<Appbar> createState() => _AppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppbarState extends State<Appbar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isMenuOpen = false;

  static OverlayEntry? _menuOverlay;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleMenu(BuildContext context) {
    if (isMenuOpen) {
      _controller.reverse();
      _removeDropdown();
    } else {
      _controller.forward();
      _showTopDropdown(context);
    }
    setState(() => isMenuOpen = !isMenuOpen);
  }

  void _removeDropdown() {
    _menuOverlay?.remove();
    _menuOverlay = null;
  }

  void _showTopDropdown(BuildContext context) {
    final overlay = Overlay.of(context);
    late AnimationController controller;
    late Animation<Offset> offsetAnimation;
    late Animation<double> opacityAnimation;

    _menuOverlay = OverlayEntry(
      builder: (context) {
        controller = AnimationController(
          vsync: Navigator.of(context),
          duration: const Duration(milliseconds: 200),
        );
        offsetAnimation = Tween<Offset>(
          begin: const Offset(0, -0.1),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
        opacityAnimation = CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
        );

        controller.forward();

        return GestureDetector(
          onTap: () {
            controller.reverse().then((_) {
              _removeDropdown();
              setState(() => isMenuOpen = false);
              _controller.reverse();
            });
          },
          behavior: HitTestBehavior.translucent,
          child: Material(
            color: Colors.transparent,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(color: Colors.transparent),
                ),
                Positioned(
                  top: kToolbarHeight,
                  left: 0,
                  right: 0,
                  child: SlideTransition(
                    position: offsetAnimation,
                    child: FadeTransition(
                      opacity: opacityAnimation,
                      child: Material(
                        elevation: 4,
                        color: Theme.of(context).appBarTheme.backgroundColor ?? Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _dropdownItem(context, 'Home', home),
                            _dropdownItem(context, 'Eboard', eboard),
                            _dropdownItem(context, 'Events', events),
                            _dropdownItem(context, 'Sponsor', sponsor),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    overlay.insert(_menuOverlay!);
  }

  Widget _dropdownItem(BuildContext context, String label, String route) {
    return ListTile(
      title: Text(label, style: Theme.of(context).textTheme.bodyLarge),
      onTap: () {
        _removeDropdown();
        Navigator.pushReplacementNamed(context, route);
        setState(() {
          isMenuOpen = false;
          _controller.reverse();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyMedium?.color ?? Colors.black;

    Widget spacer = const SizedBox(width: 25);

    return ResponsiveAppBar(
      navItems: [
        NavHoverItem(label: 'Home', route: home, baseColor: textColor, hoverColor: gBlue),
        spacer,
        NavHoverItem(label: 'Eboard', route: eboard, baseColor: textColor, hoverColor: gYellow),
        spacer,
        NavHoverItem(label: 'Events', route: events, baseColor: textColor, hoverColor: gGreen),
        spacer,
        NavHoverItem(label: 'Sponsor', route: sponsor, baseColor: textColor, hoverColor: gRed),
        spacer,
      ],
      onMenuTap: () => _toggleMenu(context),
      isMenuOpen: isMenuOpen,
      menuAnimation: _controller,
    );
  }
}
