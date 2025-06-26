//
//
// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
//
// Authors: Dina Taing
//

import 'package:flutter/material.dart';
import 'package:gdgwebsite/Widgets/Appbar.dart';

class ScrollAwareLayout extends StatefulWidget {
  final Widget body;
  const ScrollAwareLayout({super.key, required this.body});

  @override
  State<ScrollAwareLayout> createState() => _ScrollAwareLayoutState();
}

class _ScrollAwareLayoutState extends State<ScrollAwareLayout>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _appBarController;
  double _lastOffset = 0;

  @override
  void initState() {
    super.initState();
    _appBarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      value: 1,
    );

    _scrollController.addListener(() {
      final offset = _scrollController.offset;
      final delta = offset - _lastOffset;
      if (delta > 5) {
        _appBarController.reverse();
      } else if (delta < -5) {
        _appBarController.forward();
      }
      _lastOffset = offset;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _appBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (_) => true,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: _AppBarDelegate(
                FadeTransition(
                  opacity: _appBarController,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, -1),
                      end: Offset.zero,
                    ).animate(_appBarController),
                    child: const Appbar(),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: widget.body),
          ],
        ),
      ),
    );
  }
}

class _AppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _AppBarDelegate(this.child);

  @override
  double get minExtent => kToolbarHeight;

  @override
  double get maxExtent => kToolbarHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}