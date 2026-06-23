import 'package:flutter/material.dart';

import '../../core/constants/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

enum SmartStitchLogoSize { compact, medium, large }

enum SmartStitchLogoVariant { iconOnly, withLabel }

class SmartStitchLogo extends StatelessWidget {
  const SmartStitchLogo({
    super.key,
    this.variant = SmartStitchLogoVariant.withLabel,
    this.size = SmartStitchLogoSize.medium,
    this.maxWidth,
    this.height,
  });

  final SmartStitchLogoVariant variant;
  final SmartStitchLogoSize size;
  final double? maxWidth;
  final double? height;

  String get _assetPath => switch (variant) {
        SmartStitchLogoVariant.iconOnly => AppAssets.logoIconOnly,
        SmartStitchLogoVariant.withLabel => AppAssets.logoWithLabel,
      };

  double _resolveMaxWidth(double screenWidth) {
    if (maxWidth != null) return maxWidth!;

    return switch (size) {
      SmartStitchLogoSize.compact => screenWidth * 0.32,
      SmartStitchLogoSize.medium => screenWidth * 0.52,
      SmartStitchLogoSize.large => screenWidth * 0.45,
    }.clamp(100.0, 280.0);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final resolvedWidth = _resolveMaxWidth(screenWidth);

    return Image.asset(
      _assetPath,
      width: resolvedWidth,
      height: height,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
      gaplessPlayback: true,
      errorBuilder: (context, error, stackTrace) {
        return SizedBox(
          width: resolvedWidth,
          height: height ?? resolvedWidth * 0.4,
          child: Center(
            child: Icon(
              Icons.image_not_supported_outlined,
              size: resolvedWidth * 0.3,
              color: AppColors.primary,
            ),
          ),
        );
      },
    );
  }
}

class ThemedFab extends StatelessWidget {
  const ThemedFab({
    super.key,
    required this.icon,
    required this.onPressed,
    this.heroTag,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final Object? heroTag;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSpacing.fabSize,
      height: AppSpacing.fabSize,
      child: FloatingActionButton(
        heroTag: heroTag,
        onPressed: onPressed,
        backgroundColor: AppColors.primary,
        elevation: 4,
        shape: const CircleBorder(),
        child: Icon(
          icon,
          color: AppColors.textOnPrimary,
          size: 28,
        ),
      ),
    );
  }
}

class HomeFabBar extends StatelessWidget {
  const HomeFabBar({
    super.key,
    required this.onPlusPressed,
    required this.onAiPressed,
  });

  final VoidCallback onPlusPressed;
  final VoidCallback onAiPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: AppSpacing.fabSize,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Align(
            alignment: Alignment.center,
            child: ThemedFab(
              heroTag: 'home_plus_fab',
              icon: Icons.add_rounded,
              onPressed: onPlusPressed,
            ),
          ),
          Positioned(
            right: AppSpacing.md,
            child: ThemedFab(
              heroTag: 'home_ai_fab',
              icon: Icons.auto_awesome_rounded,
              onPressed: onAiPressed,
            ),
          ),
        ],
      ),
    );
  }
}
