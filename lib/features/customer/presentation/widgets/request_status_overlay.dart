import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

enum _RequestOverlayPhase { requesting, sent }

class RequestStatusOverlay {
  RequestStatusOverlay._();

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => _RequestStatusSheet(
        onFinished: () {
          Navigator.of(sheetContext).pop();
          if (context.mounted) {
            context.go(RouteNames.customerOrders);
          }
        },
      ),
    );
  }
}

class _RequestStatusSheet extends StatefulWidget {
  const _RequestStatusSheet({required this.onFinished});

  final VoidCallback onFinished;

  @override
  State<_RequestStatusSheet> createState() => _RequestStatusSheetState();
}

class _RequestStatusSheetState extends State<_RequestStatusSheet>
    with SingleTickerProviderStateMixin {
  late final AnimationController _spinController;
  _RequestOverlayPhase _phase = _RequestOverlayPhase.requesting;
  Timer? _successTimer;
  Timer? _finishTimer;

  @override
  void initState() {
    super.initState();
    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();

    _successTimer = Timer(const Duration(milliseconds: 2200), () {
      if (!mounted) return;
      _spinController.stop();
      setState(() => _phase = _RequestOverlayPhase.sent);
    });

    _finishTimer = Timer(const Duration(milliseconds: 3800), () {
      if (mounted) widget.onFinished();
    });
  }

  @override
  void dispose() {
    _successTimer?.cancel();
    _finishTimer?.cancel();
    _spinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sheetHeight = MediaQuery.sizeOf(context).height * 0.88;

    return Container(
      height: sheetHeight,
      decoration: BoxDecoration(
        color: AppColors.drawerBackground,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusXl),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.md),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textPrimary.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                switchInCurve: Curves.easeOut,
                child: _phase == _RequestOverlayPhase.requesting
                    ? _LoadingContent(spinController: _spinController)
                    : const _SuccessContent(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingContent extends StatelessWidget {
  const _LoadingContent({required this.spinController});

  final AnimationController spinController;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('loading'),
      mainAxisSize: MainAxisSize.min,
      children: [
        RotationTransition(
          turns: spinController,
          child: const CustomPaint(
            size: Size(72, 72),
            painter: _DashedLoadingPainter(),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Requesting.....',
          style: AppTypography.titleMedium.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _SuccessContent extends StatelessWidget {
  const _SuccessContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('success'),
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.success, width: 3),
          ),
          child: const Icon(
            Icons.check_rounded,
            color: AppColors.success,
            size: 40,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Request Sent',
          style: AppTypography.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _DashedLoadingPainter extends CustomPainter {
  const _DashedLoadingPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.textPrimary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;

    const dashCount = 12;
    const sweepPerDash = 0.35;
    const gapRadians = (6.28318 / dashCount) - sweepPerDash;

    var startAngle = -1.5708;
    for (var i = 0; i < dashCount; i++) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepPerDash,
        false,
        paint,
      );
      startAngle += sweepPerDash + gapRadians;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
