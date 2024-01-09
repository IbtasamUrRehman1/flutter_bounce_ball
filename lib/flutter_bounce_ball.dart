import 'package:flutter/material.dart';

/// A Flutter package providing a customizable bouncing ball loader.
///
/// This loader consists of a bouncing ball within a circular container.
/// Users can customize the size, color of the ball, and the color of the container.
class FlutterBounceBall extends StatefulWidget {
  /// The size of the loader. Defaults to 50.0.
  final double size;

  /// The color of the bouncing ball. Defaults to Colors.white.
  final Color ballColor;

  /// The color of the circular container. Defaults to Colors.blue.
  final Color containerColor;

  /// Creates a [FlutterBounceBall] widget.
  ///
  /// Users can customize the [size], [ballColor], and [containerColor].
  const FlutterBounceBall({
    Key? key,
    this.size = 50.0,
    this.ballColor = Colors.white,
    this.containerColor = Colors.blue,
  }) : super(key: key);

  @override
  _FlutterBounceBallState createState() => _FlutterBounceBallState();
}

/// The state class for the [FlutterBounceBall] widget.
///
/// Manages the animation controller and animation for the bouncing ball.
class _FlutterBounceBallState extends State<FlutterBounceBall>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller with a duration of 1000 milliseconds.
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    // Create a linear animation from 0 to 1 with ease-in and ease-out curve.
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Repeat the animation with a bounce effect.
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    // Dispose of the animation controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: widget.containerColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Transform.translate(
              offset: Offset(0, widget.size / 2 * _animation.value),
              child: Container(
                width: widget.size * 0.4,
                height: widget.size * 0.4,
                decoration: BoxDecoration(
                  color: widget.ballColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
