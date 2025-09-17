import 'package:flutter/material.dart';
import 'dart:math';

class TirangaBackground extends StatelessWidget {
  final Widget child;

  const TirangaBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Custom Painter for Tiranga + Chakra + Glow
        CustomPaint(
          size: Size.infinite,
          painter: GlowTirangaPainter(),
        ),

        // Child content (your screen widgets)
        child,
      ],
    );
  }
}

/// 🎯 Smooth Tiranga Gradient + Chakra with Glow
class GlowTirangaPainter extends CustomPainter {
  final Color saffron = const Color(0xFFFF9933);
  final Color white = Colors.white;
  final Color green = const Color(0xFF138808);
  final Color chakraBlue = const Color(0xFF000080);

  @override
  void paint(Canvas canvas, Size size) {
    // Smooth vertical gradient for Tiranga
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    Paint paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [saffron, white, green],
        stops: [0.33, 0.5, 0.66],
      ).createShader(rect);
    canvas.drawRect(rect, paint);

    // Draw subtle glow behind Chakra
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double radius = size.height * 0.08;

    Paint glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          chakraBlue.withOpacity(0.2),
          Colors.transparent,
        ],
        stops: [0.0, 1.0],
      ).createShader(Rect.fromCircle(center: Offset(centerX, centerY), radius: radius * 2));

    canvas.drawCircle(Offset(centerX, centerY), radius * 2, glowPaint);

    // Draw Ashok Chakra
    paint.color = chakraBlue;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 3;
    canvas.drawCircle(Offset(centerX, centerY), radius, paint);

    // 24 spokes
    for (int i = 0; i < 24; i++) {
      double angle = 2 * pi * i / 24;
      double x = centerX + radius * cos(angle);
      double y = centerY + radius * sin(angle);
      canvas.drawLine(Offset(centerX, centerY), Offset(x, y), paint);
    }

    // Small inner circle
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(Offset(centerX, centerY), radius * 0.05, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
