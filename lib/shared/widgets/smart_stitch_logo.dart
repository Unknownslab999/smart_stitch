import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

class SmartStitchLogo extends StatelessWidget {
  const SmartStitchLogo({
    super.key,
    this.size = 80,
    this.showText = true,
    this.textStyle,
  });

  final double size;
  final bool showText;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomPaint(
          size: Size(size, size),
          painter: _LogoPainter(),
        ),
        if (showText) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Smart Stitch',
            style: textStyle ?? AppTypography.logo,
          ),
        ],
      ],
    );
  }
}

class _LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.06
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.35;

    final path = Path();
    path.moveTo(center.dx - radius * 0.3, center.dy - radius * 0.8);
    path.quadraticBezierTo(
      center.dx + radius * 0.8,
      center.dy - radius * 0.5,
      center.dx + radius * 0.5,
      center.dy + radius * 0.3,
    );
    path.quadraticBezierTo(
      center.dx,
      center.dy + radius * 0.9,
      center.dx - radius * 0.5,
      center.dy + radius * 0.2,
    );
    path.quadraticBezierTo(
      center.dx - radius * 0.9,
      center.dy - radius * 0.2,
      center.dx - radius * 0.3,
      center.dy - radius * 0.8,
    );

    canvas.drawPath(path, paint);

    canvas.drawCircle(
      Offset(center.dx + radius * 0.55, center.dy - radius * 0.45),
      size.width * 0.04,
      fillPaint,
    );

    final threadPath = Path();
    threadPath.moveTo(center.dx + radius * 0.55, center.dy - radius * 0.45);
    threadPath.lineTo(center.dx + radius * 0.7, center.dy + radius * 0.5);
    canvas.drawPath(threadPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
