import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/models/portfolio_item.dart';
import '../../../../shared/widgets/star_rating.dart';

class PortfolioGrid extends StatelessWidget {
  const PortfolioGrid({
    super.key,
    required this.items,
    required this.title,
  });

  final List<PortfolioItem> items;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTypography.titleLarge),
        const SizedBox(height: AppSpacing.md),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: AppSpacing.md,
            crossAxisSpacing: AppSpacing.md,
            childAspectRatio: 0.82,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    item.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.primaryLight,
                      child: const Icon(Icons.image_outlined),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      color: Colors.black.withValues(alpha: 0.45),
                      child: Text(
                        item.title,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textOnPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class ReviewsList extends StatelessWidget {
  const ReviewsList({super.key, required this.reviews});

  final List<ProviderReview> reviews;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Reviews', style: AppTypography.titleLarge),
        const SizedBox(height: AppSpacing.md),
        ...reviews.map(
          (review) => Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: AppSpacing.md),
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              border: Border.all(color: AppColors.inputBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      review.customerName,
                      style: AppTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      review.date,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textHint,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                StarRating(rating: review.rating, size: 16),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  review.comment,
                  style: AppTypography.bodyMedium.copyWith(
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
