import 'package:flutter/material.dart';

class ItemFader extends StatefulWidget {
  final child, delay, direction;

  ItemFader({
    @required this.child,
    @required this.delay,
    this.direction = 'vertical',
  });

  @override
  _ItemFaderState createState() => _ItemFaderState();
}

class _ItemFaderState extends State<ItemFader>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _animation = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          widget.delay,
          1.0,
          curve: Curves.easeInOut,
        ),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        return Transform(
          transform: widget.direction == 'vertical'
              ? Matrix4.translationValues(0, _animation.value * height, 0)
              : Matrix4.translationValues(_animation.value * width, 0, 0),
          child: child,
        );
      },
    );
  }
}
