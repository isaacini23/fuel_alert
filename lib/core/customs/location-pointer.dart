import 'package:flutter/material.dart';

class LocationPointerPainter extends CustomPainter {
  final Color pinColor;

  LocationPointerPainter({required this.pinColor});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = pinColor
      ..style = PaintingStyle.fill;

    // Draw the pin shape (circle + pointer)
    double circleRadius = size.width * 0.3;
    Offset circleCenter = Offset(size.width / 2, size.height * 0.3);
    canvas.drawCircle(circleCenter, circleRadius, paint);

    Path pointerPath = Path();
    pointerPath.moveTo(size.width / 2, size.height); // Bottom point
    pointerPath.lineTo(0, size.height * 0.5); // Left point
    pointerPath.lineTo(size.width, size.height * 0.5); // Right point
    pointerPath.close();
    canvas.drawPath(pointerPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class LocationPointer extends StatelessWidget {
  final double size;
  final Color color;
  final Icon icon;

  const LocationPointer({
    Key? key,
    this.size = 100,
    this.color = Colors.red,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: Size(size, size * 1.5),
          painter: LocationPointerPainter(pinColor: color),
        ),
        Positioned(
          top: size * 0.2, // Position the icon slightly below the top circle
          child: SizedBox(
            width: size * 0.6,
            height: size * 0.6,
            child: icon,
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Custom Location Pointer')),
      body: const Center(
        child: LocationPointer(
          size: 100,
          color: Colors.red, // Customize the color of the pointer
          icon: Icon(Icons.local_gas_station,
              color: Colors.white, size: 40), // Customize the icon
        ),
      ),
    ),
  ));
}
