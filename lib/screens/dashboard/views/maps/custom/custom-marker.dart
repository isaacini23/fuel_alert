import 'package:flutter/material.dart';

class GlowingLocationMarker extends StatefulWidget {

  const GlowingLocationMarker({
    super.key
  });

  @override
  _GlowingLocationMarkerState createState() => _GlowingLocationMarkerState();
}

class _GlowingLocationMarkerState extends State<GlowingLocationMarker>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  initAnimation() async {
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initAnimation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        print('Animation value: ${_animation.value}'); // Debugging line
        return Container(
          width: 60 * _animation.value,
          height: 60 * _animation.value,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue.withOpacity(0.3),
          ),
          child: const Center(
            child: Icon(
              Icons.my_location,
              color: Colors.blue,
              size: 20,
            ),
          ),
        );
      },
    );
  }
}
