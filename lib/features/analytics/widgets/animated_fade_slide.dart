import 'package:flutter/material.dart';

class AnimatedFadeSlide extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const AnimatedFadeSlide({
    super.key,
    required this.child,
    this.delay = const Duration(milliseconds: 100),
  });

  @override
  State<AnimatedFadeSlide> createState() => _AnimatedFadeSlideState();
}

class _AnimatedFadeSlideState extends State<AnimatedFadeSlide>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> opacity;
  late Animation<Offset> offset;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    opacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    offset = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacity,
      child: SlideTransition(position: offset, child: widget.child),
    );
  }
}
