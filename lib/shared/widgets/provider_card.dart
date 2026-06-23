import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import 'app_image.dart';

class ProviderCard extends StatelessWidget {
  const ProviderCard({
    super.key,
    required this.name,
    required this.specialty,
    required this.experienceYears,
    required this.imageUrl,
    this.onTap,
    this.width = 160,
  });

  final String name;
  final String specialty;
  final int experienceYears;
  final String imageUrl;
  final VoidCallback? onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              child: AppImage(
                source: imageUrl,
                height: 140,
                width: width,
                fit: BoxFit.cover,
                errorIcon: Icons.checkroom_outlined,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              name,
              style: AppTypography.titleMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              specialty,
              style: AppTypography.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              '$experienceYears yrs exp',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textHint,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
