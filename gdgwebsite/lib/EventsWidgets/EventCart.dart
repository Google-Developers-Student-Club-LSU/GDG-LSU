//
// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
// Authors: Dina Taing
//
import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';
import 'package:gdgwebsite/Constants.dart';
import 'package:gdgwebsite/EventsWidgets/CreateEvent.dart';
import 'package:gdgwebsite/Utils/CIickableImageLink.dart';
import 'package:intl/intl.dart';

class EventCart extends StatefulWidget {
  final String title;
  final String description;
  final DateTime start;
  final DateTime end;
  final Color color;
  final String? image;
  final String? room;
  final String? gallerUrl;
  final VoidCallback? onClose;
  final Offset? tapPosition;

  const EventCart({
    super.key,
    required this.title,
    required this.start,
    required this.end,
    required this.color,
    this.room,
    this.gallerUrl,
    this.image = failedImage,
    required this.description,
    this.onClose,
    this.tapPosition,
  });

  @override
  State<EventCart> createState() => _EventCartState();
}

class _EventCartState extends State<EventCart> with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _fadeController.forward();
  }

  Alignment _calculateAlignment(BuildContext context) {
    if (widget.tapPosition == null) return Alignment.center;

    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) return Alignment.center;

    final size = renderBox.size;
    final localTapPos = renderBox.globalToLocal(widget.tapPosition!);

    final alignmentX = (localTapPos.dx / size.width) * 2 - 1;
    final alignmentY = (localTapPos.dy / size.height) * 2 - 1;

    return Alignment(alignmentX, alignmentY);
  }

  @override
  Widget build(BuildContext context) {
    bool timeNotAvailable = widget.start == widget.end || widget.end.difference(widget.start).inMinutes <= 30;

    final isLightMode = Theme.of(context).brightness == Brightness.light;
    final greyColor = isLightMode ? Colors.black54 : Colors.white70;
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Center(
      child: AnimatedBuilder(
        animation: _fadeAnimation,
        builder: (context, child) {
          final alignment = _calculateAlignment(context);
          return Transform.scale(
            scale: _fadeAnimation.value,
            alignment: alignment,
            child: child,
          );
        },
        child: Material(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(16),
          clipBehavior: Clip.antiAlias,
          child: Container(
            width: MediaQuery.of(context).size.width * (isMobile ? 0.8 : 0.6),
            height: MediaQuery.of(context).size.width * (isMobile ? 1: 0.4),

            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: widget.color, width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(77),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Image.asset(gDSCLogo, height: 32),
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: widget.onClose ?? () => Navigator.of(context).pop(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SelectableText(
                   widget.title,
                    style: standardText.copyWith(fontSize: isMobile ? 30 : 40),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 10),
                  SelectableText(
                    timeNotAvailable
                        ? 'Time will be announced soon'
                        : 'Time: ${DateFormat('h:mm a').format(widget.start)} — ${DateFormat('h:mm a').format(widget.end)}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: timeNotAvailable ? gRed : widget.color,
                          fontSize: 20,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  SelectableText(
                    widget.room == null ? 'Room: TBD' : 'Room: ${widget.room}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: widget.room == null ? gRed : greyColor,
                          fontSize: 20,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: SelectableText(
                      widget.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 17),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Image.asset(
                    widget.image ?? failedImage,
                    width: MediaQuery.of(context).size.width * 0.4,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Text("Image failed to load.");
                    },
                  ),
                  const SizedBox(height: 50),
                  CalendarButton(
                    title: widget.title,
                    description: widget.description,
                    start: widget.start,
                    end: widget.end,
                    room: widget.room,
                    color: widget.color,
                  ),
                  if (widget.gallerUrl != null)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
                        child: Row(
                          children: [
                            ClickableImageLink(
                              width:  isMobile ? 50 : 70,
                              imageAsset: iconGallery,
                              linkUrl: widget.gallerUrl ?? '/',
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                '⬅️ Tap to see the event gallery',
                                softWrap: true,
                                style: standardText.copyWith(fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }
}
