import 'package:flutter/material.dart';

class ScannerOverlay extends StatelessWidget {
  const ScannerOverlay({required this.scanRect, super.key});

  final Rect scanRect;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: _ScannerOverlayPainter(scanRect),
    );
  }
}

class _ScannerOverlayPainter extends CustomPainter {
  _ScannerOverlayPainter(this.scanRect);

  final Rect scanRect;

  @override
  void paint(Canvas canvas, Size size) {
    //Rectángulo Central Transparente
    final clearPaint = Paint()..color = Colors.black.withValues(alpha: .2);

    canvas.drawRRect(
      RRect.fromRectAndRadius(scanRect, const Radius.circular(16)),
      clearPaint,
    );

    const radius = 16.0;
    const cornerLength = 26.0;
    final r = scanRect;

    final paint = Paint()
      ..color = Colors.blueAccent
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(r.left + radius, r.top)
      ..arcToPoint(
        Offset(r.left, r.top + radius),
        radius: const Radius.circular(radius),
        clockwise: false,
      )
      ..lineTo(r.left, r.top + cornerLength)
      ..moveTo(r.left + radius, r.top)
      ..lineTo(r.left + cornerLength, r.top)
      // Arriba + Derecha
      ..moveTo(r.right - radius, r.top)
      ..arcToPoint(
        Offset(r.right, r.top + radius),
        radius: const Radius.circular(radius),
      )
      ..lineTo(r.right, r.top + cornerLength)
      ..moveTo(r.right - radius, r.top)
      ..lineTo(r.right - cornerLength, r.top)
      // Abajo - Izquierda
      ..moveTo(r.left + radius, r.bottom)
      ..arcToPoint(
        Offset(r.left, r.bottom - radius),
        radius: const Radius.circular(radius),
      )
      ..lineTo(r.left, r.bottom - cornerLength)
      ..moveTo(r.left + radius, r.bottom)
      ..lineTo(r.left + cornerLength, r.bottom)
      // Abajo - Derecha
      ..moveTo(r.right - radius, r.bottom)
      ..arcToPoint(
        Offset(r.right, r.bottom - radius),
        radius: const Radius.circular(radius),
        clockwise: false,
      )
      ..lineTo(r.right, r.bottom - cornerLength)
      ..moveTo(r.right - radius, r.bottom)
      ..lineTo(r.right - cornerLength, r.bottom);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _ScannerOverlayPainter oldDelegate) =>
      oldDelegate.scanRect != scanRect;
}
