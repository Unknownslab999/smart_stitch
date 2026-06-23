import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/models/mock_selectable_provider.dart';
import '../../../../shared/widgets/star_rating.dart';

class ProviderSelectorRow extends StatelessWidget {
  const ProviderSelectorRow({
    super.key,
    required this.providers,
    required this.selectedId,
    required this.onSelected,
    this.onSearch,
  });

  final List<MockSelectableProvider> providers;
  final String? selectedId;
  final ValueChanged<String> onSelected;
  final VoidCallback? onSearch;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: providers.length + 1,
        separatorBuilder: (context, index) =>
            const SizedBox(width: AppSpacing.md),
        itemBuilder: (context, index) {
          if (index == providers.length) {
            return _SearchChip(onTap: onSearch);
          }

          final provider = providers[index];
          return _ProviderChip(
            provider: provider,
            isSelected: selectedId == provider.id,
            onTap: () => onSelected(provider.id),
          );
        },
      ),
    );
  }
}

class _ProviderChip extends StatelessWidget {
  const _ProviderChip({
    required this.provider,
    required this.isSelected,
    required this.onTap,
  });

  final MockSelectableProvider provider;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 72,
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: provider.avatarColor,
                shape: BoxShape.circle,
                border: isSelected
                    ? Border.all(color: AppColors.primaryDark, width: 2.5)
                    : null,
              ),
              child: Icon(
                Icons.person_rounded,
                color: AppColors.textPrimary.withValues(alpha: 0.7),
                size: 28,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              provider.name,
              style: AppTypography.bodySmall.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            StarRating(rating: provider.rating, size: 12),
          ],
        ),
      ),
    );
  }
}

class _SearchChip extends StatelessWidget {
  const _SearchChip({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 72,
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.search_rounded,
                color: AppColors.textOnPrimary,
                size: 28,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Search',
              style: AppTypography.bodySmall.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
