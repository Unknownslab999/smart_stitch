import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/models/provider_profile.dart';
import '../../../../shared/widgets/star_rating.dart';

class ProviderProfileHeader extends StatelessWidget {
  const ProviderProfileHeader({super.key, required this.profile});

  final ProviderProfile profile;

  String _formatCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(count >= 10000 ? 0 : 1)}k';
    }
    return count.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 44,
            backgroundColor: AppColors.surface,
            backgroundImage: NetworkImage(profile.imageUrl),
            onBackgroundImageError: (exception, stackTrace) {},
            child: Icon(
              Icons.person_rounded,
              size: 44,
              color: AppColors.textHint,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            profile.name,
            style: AppTypography.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            profile.roleLabel,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            profile.specialty,
            style: AppTypography.bodySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _StatItem(
                value: profile.following.toString(),
                label: 'Following',
              ),
              _StatItem(
                value: _formatCount(profile.projects),
                label: 'Project',
              ),
              _StatItem(
                value: profile.rating.toStringAsFixed(1),
                label: 'Rating',
                showStars: true,
                rating: profile.rating,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.value,
    required this.label,
    this.showStars = false,
    this.rating,
  });

  final String value;
  final String label;
  final bool showStars;
  final double? rating;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppTypography.titleLarge.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        if (showStars && rating != null) ...[
          const SizedBox(height: 2),
          StarRating(rating: rating!, size: 14),
        ],
        const SizedBox(height: 2),
        Text(
          label,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textHint,
          ),
        ),
      ],
    );
  }
}

class SelectedProviderBanner extends StatelessWidget {
  const SelectedProviderBanner({
    super.key,
    required this.name,
    required this.roleLabel,
    required this.imageUrl,
    required this.rating,
  });

  final String name;
  final String roleLabel;
  final String imageUrl;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(imageUrl),
            onBackgroundImageError: (exception, stackTrace) {},
            child: Icon(Icons.person, color: AppColors.textHint),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sending request to',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textHint,
                  ),
                ),
                Text(
                  name,
                  style: AppTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  roleLabel,
                  style: AppTypography.bodySmall,
                ),
              ],
            ),
          ),
          StarRating(rating: rating, size: 14),
        ],
      ),
    );
  }
}
