import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/models/mock_quotation.dart';

class QuotationCard extends StatelessWidget {
  const QuotationCard({
    super.key,
    required this.quotation,
    required this.onAccept,
    required this.onDecline,
  });

  final MockQuotation quotation;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.inputBorder),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 36,
            backgroundColor: AppColors.surface,
            child: Icon(
              Icons.person_rounded,
              size: 40,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            quotation.formattedPrice,
            style: AppTypography.headlineMedium.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            quotation.providerName,
            style: AppTypography.titleMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            quotation.location,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onAccept,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.surface,
                    foregroundColor: AppColors.textPrimary,
                    side: const BorderSide(color: AppColors.success, width: 1.5),
                    minimumSize: const Size(0, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusPill),
                    ),
                  ),
                  child: Text(
                    'Accept',
                    style: AppTypography.labelLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: ElevatedButton(
                  onPressed: onDecline,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.textPrimary,
                    minimumSize: const Size(0, 48),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusPill),
                    ),
                  ),
                  child: Text(
                    'Decline',
                    style: AppTypography.labelLarge.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OrderHistoryCard extends StatelessWidget {
  const OrderHistoryCard({
    super.key,
    required this.order,
  });

  final MockOrderHistory order;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.inputBorder),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.surface,
            child: Icon(
              Icons.person_rounded,
              color: AppColors.textSecondary,
              size: 28,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.formattedPrice,
                  style: AppTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  order.providerName,
                  style: AppTypography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: switch (order.status) {
                OrderHistoryStatus.done => AppColors.success,
                OrderHistoryStatus.inProgress => AppColors.primary,
                OrderHistoryStatus.cancelled => AppColors.textHint,
              },
              borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
            ),
            child: Text(
              order.status.label,
              style: AppTypography.labelLarge.copyWith(
                color: AppColors.textOnPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
