import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/models/mock_tailor_dashboard.dart';
import '../../../../shared/widgets/app_image.dart';
import '../../../../shared/widgets/star_rating.dart';

class DailySummarySection extends StatelessWidget {
  const DailySummarySection({
    super.key,
    required this.summary,
    this.onExportLog,
  });

  final TailorDailySummary summary;
  final VoidCallback? onExportLog;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 18,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'DAILY SUMMARY',
              style: AppTypography.labelLarge.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Row(
          children: [
            Expanded(
              child: _SummaryStat(
                label: 'ORDERS',
                value: summary.orders.toString(),
              ),
            ),
            Expanded(
              child: _SummaryStat(
                label: 'PENDING',
                value: summary.pending.toString(),
                valueColor: AppColors.error,
              ),
            ),
            Expanded(
              child: _SummaryStat(
                label: 'DUE TODAY',
                value: summary.dueToday.toString().padLeft(2, '0'),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: onExportLog,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.textPrimary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
              ),
            ),
            child: Text(
              'EXPORT LOG',
              style: AppTypography.labelLarge.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SummaryStat extends StatelessWidget {
  const _SummaryStat({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: AppTypography.bodySmall.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          value,
          style: AppTypography.headlineMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: valueColor ?? AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class IncomingRequestsSection extends StatelessWidget {
  const IncomingRequestsSection({
    super.key,
    required this.requests,
    required this.queueCount,
    this.onDismiss,
    this.onQuote,
  });

  final List<TailorIncomingRequest> requests;
  final int queueCount;
  final ValueChanged<TailorIncomingRequest>? onDismiss;
  final ValueChanged<TailorIncomingRequest>? onQuote;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'INCOMING REQUESTS',
              style: AppTypography.titleLarge.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: 0.3,
              ),
            ),
            Text(
              'QUEUE ($queueCount)',
              style: AppTypography.bodySmall.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        ...requests.map(
          (request) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: _IncomingRequestTile(
              request: request,
              onDismiss: () => onDismiss?.call(request),
              onQuote: () => onQuote?.call(request),
            ),
          ),
        ),
      ],
    );
  }
}

class _IncomingRequestTile extends StatelessWidget {
  const _IncomingRequestTile({
    required this.request,
    this.onDismiss,
    this.onQuote,
  });

  final TailorIncomingRequest request;
  final VoidCallback? onDismiss;
  final VoidCallback? onQuote;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          child: AppImage(
            source: request.imageUrl,
            width: 52,
            height: 52,
            fit: BoxFit.cover,
            errorIcon: Icons.checkroom_outlined,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                request.customerName,
                style: AppTypography.labelLarge.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                request.garmentDetail,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onDismiss,
          icon: const Icon(Icons.close_rounded),
          style: IconButton.styleFrom(
            backgroundColor: AppColors.surfaceVariant,
            minimumSize: const Size(36, 36),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        SizedBox(
          height: 36,
          child: ElevatedButton(
            onPressed: onQuote,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.textPrimary,
              elevation: 0,
              minimumSize: const Size(0, 36),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
              ),
            ),
            child: Text(
              'QUOTE',
              style: AppTypography.bodySmall.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ActiveOrdersSection extends StatelessWidget {
  const ActiveOrdersSection({
    super.key,
    required this.orders,
    this.onUpdateStatus,
    this.onChat,
    this.onAttachment,
  });

  final List<TailorActiveOrder> orders;
  final ValueChanged<TailorActiveOrder>? onUpdateStatus;
  final ValueChanged<TailorActiveOrder>? onChat;
  final ValueChanged<TailorActiveOrder>? onAttachment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ACTIVE ORDERS',
          style: AppTypography.titleLarge.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        ...orders.map(
          (order) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: _ActiveOrderCard(
              order: order,
              onUpdateStatus: () => onUpdateStatus?.call(order),
              onChat: () => onChat?.call(order),
              onAttachment: () => onAttachment?.call(order),
            ),
          ),
        ),
      ],
    );
  }
}

class _ActiveOrderCard extends StatelessWidget {
  const _ActiveOrderCard({
    required this.order,
    this.onUpdateStatus,
    this.onChat,
    this.onAttachment,
  });

  final TailorActiveOrder order;
  final VoidCallback? onUpdateStatus;
  final VoidCallback? onChat;
  final VoidCallback? onAttachment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.inputBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order #${order.orderNumber}',
                style: AppTypography.titleMedium.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                children: [
                  _StatusChip(label: order.status.label),
                  if (order.isPriority) ...[
                    const SizedBox(width: AppSpacing.sm),
                    _StatusChip(
                      label: TailorOrderStatus.priority.label,
                      isPriority: true,
                    ),
                  ],
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '${order.clientName} • Expected ${order.expectedDate}',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            order.progressLabel,
            style: AppTypography.bodySmall.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
            child: LinearProgressIndicator(
              value: order.progressPercent / 100,
              minHeight: 8,
              backgroundColor: AppColors.inputFill,
              color: AppColors.primaryDark,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${order.progressPercent}%',
            style: AppTypography.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              IconButton(
                onPressed: onChat,
                icon: const Icon(Icons.chat_bubble_outline_rounded),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.surfaceVariant,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              IconButton(
                onPressed: onAttachment,
                icon: const Icon(Icons.attach_file_rounded),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.surfaceVariant,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: onUpdateStatus,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.textPrimary,
                  elevation: 0,
                  minimumSize: const Size(0, 40),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.sm,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
                  ),
                ),
                child: Text(
                  order.actionLabel,
                  style: AppTypography.bodySmall.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.3,
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

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.label,
    this.isPriority = false,
  });

  final String label;
  final bool isPriority;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: isPriority
            ? AppColors.error.withValues(alpha: 0.12)
            : AppColors.primaryLight,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Text(
        label,
        style: AppTypography.bodySmall.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 10,
          color: isPriority ? AppColors.error : AppColors.textPrimary,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

class AtelierHealthSection extends StatelessWidget {
  const AtelierHealthSection({super.key, required this.health});

  final TailorAtelierHealth health;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ATELIER HEALTH',
          style: AppTypography.titleLarge.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            border: Border.all(color: AppColors.inputBorder),
          ),
          child: Column(
            children: [
              _HealthRow(
                label: 'QUALITY RATING',
                child: StarRating(rating: health.qualityRating, size: 20),
              ),
              const Divider(height: AppSpacing.lg),
              _HealthRow(
                label: 'RESPONSE TIME',
                child: Text(
                  '${health.responseTimeHours} hrs',
                  style: AppTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Divider(height: AppSpacing.lg),
              _HealthRow(
                label: 'CLIENT RETURN',
                child: Text(
                  '${health.clientReturnPercent}%',
                  style: AppTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HealthRow extends StatelessWidget {
  const _HealthRow({
    required this.label,
    required this.child,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.bodySmall.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
        ),
        child,
      ],
    );
  }
}
