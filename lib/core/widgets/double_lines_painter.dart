import 'dart:math';
import 'package:flutter/material.dart';

class DoubleLinesPainter extends CustomPainter {
  final int lineCount;
  final Color lineColor;
  final double lineWidth;
  final double maxOffset; // max outward offset at middle point

  DoubleLinesPainter({
    this.lineCount = 18,
    this.lineColor = Colors.grey,
    this.lineWidth = 1.0,
    this.maxOffset = 8.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final random = Random();
    final paint = Paint()
      ..color = lineColor.withOpacity(0.14)
      ..strokeWidth = lineWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < lineCount; i++) {
      final startX = random.nextDouble() * size.width;
      final startY = random.nextDouble() * size.height;
      final angle = random.nextDouble() * 2 * pi;
      final length = (size.width + size.height) * (0.15 + 0.20 * random.nextDouble());

      final endX = startX + length * cos(angle);
      final endY = startY + length * sin(angle);

      // Mid point of the line segment
      final midX = (startX + endX) / 2;
      final midY = (startY + endY) / 2;

      // Perpendicular vector components
      final perpX = maxOffset * cos(angle + pi / 2);
      final perpY = maxOffset * sin(angle + pi / 2);

      // Define top path (curved outward)
      Path topPath = Path()
        ..moveTo(startX, startY)
        ..quadraticBezierTo(midX + perpX, midY + perpY, endX, endY);

      // Define bottom path (curved outward opposite side)
      Path bottomPath = Path()
        ..moveTo(startX, startY)
        ..quadraticBezierTo(midX - perpX, midY - perpY, endX, endY);

      // Draw both paths
      canvas.drawPath(topPath, paint);
      canvas.drawPath(bottomPath, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
