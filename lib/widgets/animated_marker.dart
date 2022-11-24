import 'package:flutter/material.dart';
import 'package:schedulemanager/constants/constants.dart';

class AnimatedMarker extends StatefulWidget {
  final Color color;
  const AnimatedMarker({
    super.key,
    required this.color,
  });

  @override
  State<AnimatedMarker> createState() => _AnimatedMarkerState();
}

class _AnimatedMarkerState extends State<AnimatedMarker>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 850))
      ..forward()
      ..repeat(reverse: true)
      ..addListener(_animationListener);
    _animation = Tween<double>(begin: 1, end: 0.5).animate(_controller);
  }

  void _animationListener() {
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double value = _animation.value;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 25 * value,
          width: 25 * value,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.color.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
        ),
        Container(
          height: 15,
          width: 15,
          decoration: BoxDecoration(
            color: widget.color,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
