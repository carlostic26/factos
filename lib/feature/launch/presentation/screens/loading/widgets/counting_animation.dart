import 'package:factos/core/config/styles/constants/theme_data.dart';
import 'package:flutter/material.dart';

class CountingAnimation extends StatefulWidget {
  final int endCount;

  const CountingAnimation({super.key, required this.endCount});

  @override
  _CountingAnimationState createState() => _CountingAnimationState();
}

class _CountingAnimationState extends State<CountingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 9),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: widget.endCount.toDouble())
        .animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return Text(
          _animation.value.toInt().toString(),
          style: const TextStyle(
              fontSize: 12,
              color: subtitleTextColor,
              fontWeight: FontWeight.bold),
        );
      },
    );
  }
}
