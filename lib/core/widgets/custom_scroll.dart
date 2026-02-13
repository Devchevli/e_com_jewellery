import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ScrollReveal extends StatefulWidget {
  final Widget child;
  final Offset beginOffset;
  final Duration duration;

  const ScrollReveal({
    super.key,
    required this.child,
    this.beginOffset = const Offset(0, 0.2),
    this.duration = const Duration(milliseconds: 900),
  });

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.hashCode.toString()),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3 && !_isVisible) {
          setState(() {
            _isVisible = true;
          });
        }
      },
      child: AnimatedSlide(
        offset: _isVisible ? Offset.zero : widget.beginOffset,
        duration: widget.duration,
        curve: Curves.easeOutCubic,
        child: AnimatedOpacity(
          opacity: _isVisible ? 1 : 0,
          duration: widget.duration,
          child: widget.child,
        ),
      ),
    );
  }
}
