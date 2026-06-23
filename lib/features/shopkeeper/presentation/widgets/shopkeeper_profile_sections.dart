import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/models/provider_portfolio_profile.dart';
import '../../../../shared/widgets/app_image.dart';

const _eliteBrown = Color(0xFF4A3C31);
const _actionBrown = Color(0xFF5C4A3D);

class PortfolioSpotlightSection extends StatelessWidget {
  const PortfolioSpotlightSection({
    super.key,
    this.onEditFeatured,
    this.subtitle = ProviderPortfolioProfile.shopkeeperSpotlightSubtitle,
  });

  final VoidCallback? onEditFeatured;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PORTFOLIO SPOTLIGHT',
                style: AppTypography.titleLarge.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                subtitle,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onEditFeatured,
          child: Text(
            'EDIT FEATURED',
            style: AppTypography.labelMedium.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: 0.4,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}

class FeaturedPortfolioCarousel extends StatelessWidget {
  const FeaturedPortfolioCarousel({
    super.key,
    required this.items,
    this.onAddMasterpiece,
    this.onWorkTap,
  });

  final List<FeaturedWork> items;
  final VoidCallback? onAddMasterpiece;
  final ValueChanged<FeaturedWork>? onWorkTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(right: AppSpacing.md),
              child: _FeaturedWorkCard(
                item: item,
                onTap: () => onWorkTap?.call(item),
              ),
            ),
          ),
          _AddMasterpieceCard(onTap: onAddMasterpiece),
        ],
      ),
    );
  }
}

class _FeaturedWorkCard extends StatelessWidget {
  const _FeaturedWorkCard({required this.item, this.onTap});

  final FeaturedWork item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: SizedBox(
          width: 160,
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (item.isPlaceholder)
                Container(color: const Color(0xFF2B2B2B))
              else
                AppImage(
                  source: item.imageUrl!,
                  fit: BoxFit.cover,
                ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.72),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: AppSpacing.sm,
                right: AppSpacing.sm,
                bottom: AppSpacing.sm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: AppTypography.labelMedium.copyWith(
                        color: AppColors.textOnPrimary,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.3,
                      ),
                    ),
                    Text(
                      item.saves,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textOnPrimary.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddMasterpieceCard extends StatelessWidget {
  const _AddMasterpieceCard({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        painter: _DashedBorderPainter(
          color: AppColors.inputBorder,
          radius: AppSpacing.radiusMd,
        ),
        child: SizedBox(
          width: 160,
          height: 220,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.textPrimary,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                ),
                child: const Icon(
                  Icons.add_rounded,
                  color: AppColors.textOnPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'ADD MASTERPIECE',
                textAlign: TextAlign.center,
                style: AppTypography.labelMedium.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                child: Text(
                  'Click to upload high-resolution work',
                  textAlign: TextAlign.center,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileAnalyticsSection extends StatelessWidget {
  const ProfileAnalyticsSection({
    super.key,
    required this.analytics,
  });

  final ProfileAnalytics analytics;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _AnalyticsCard(
            label: 'MONTHLY REVENUE',
            value: analytics.monthlyRevenue,
            trend: '↑ ${analytics.revenueTrendPercent}%',
            showTrend: true,
            child: const Align(
              alignment: Alignment.bottomLeft,
              child: Icon(
                Icons.bar_chart_rounded,
                color: AppColors.textPrimary,
                size: 28,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: _AnalyticsCard(
            label: 'PROFILE VIEWS',
            value: analytics.profileViews,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(
                5,
                (index) => Container(
                  width: 8,
                  height: 12 + index * 6.0,
                  decoration: BoxDecoration(
                    color: AppColors.textSecondary.withValues(
                      alpha: 0.25 + index * 0.12,
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AnalyticsCard extends StatelessWidget {
  const _AnalyticsCard({
    required this.label,
    required this.value,
    required this.child,
    this.trend,
    this.showTrend = false,
  });

  final String label;
  final String value;
  final Widget child;
  final String? trend;
  final bool showTrend;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: AppTypography.labelMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4,
                ),
              ),
              if (showTrend && trend != null)
                Text(
                  trend!,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.success,
                    fontWeight: FontWeight.w700,
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            value,
            style: AppTypography.headlineMedium.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const Spacer(),
          child,
        ],
      ),
    );
  }
}

class EliteStatusCard extends StatelessWidget {
  const EliteStatusCard({super.key, required this.status});

  final EliteStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: _eliteBrown,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.emoji_events_outlined,
                color: AppColors.textOnPrimary,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                ),
                child: Text(
                  status.label,
                  style: AppTypography.labelMedium.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            status.metricLabel,
            style: AppTypography.labelMedium.copyWith(
              color: AppColors.textOnPrimary.withValues(alpha: 0.75),
              letterSpacing: 0.6,
            ),
          ),
          Text(
            '${status.retentionRate}%',
            style: AppTypography.displayLarge.copyWith(
              color: AppColors.textOnPrimary,
              fontWeight: FontWeight.w800,
              fontSize: 48,
            ),
          ),
        ],
      ),
    );
  }
}

class PremiumLeadsSection extends StatelessWidget {
  const PremiumLeadsSection({
    super.key,
    required this.leads,
    this.onDiscoveryFeed,
    this.onLeadAction,
  });

  final List<PremiumLead> leads;
  final VoidCallback? onDiscoveryFeed;
  final ValueChanged<PremiumLead>? onLeadAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'PREMIUM LEADS',
              style: AppTypography.titleLarge.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: 0.3,
              ),
            ),
            GestureDetector(
              onTap: onDiscoveryFeed,
              child: Row(
                children: [
                  Text(
                    'DISCOVERY FEED',
                    style: AppTypography.labelMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.north_east_rounded, size: 14),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        ...leads.map(
          (lead) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.lg),
            child: _PremiumLeadCard(
              lead: lead,
              onAction: () => onLeadAction?.call(lead),
            ),
          ),
        ),
      ],
    );
  }
}

class _PremiumLeadCard extends StatelessWidget {
  const _PremiumLeadCard({required this.lead, this.onAction});

  final PremiumLead lead;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.divider),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 10,
                child: AppImage(
                  source: lead.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: AppSpacing.sm,
                left: AppSpacing.sm,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: lead.badge == 'HIGH POTENTIAL'
                        ? AppColors.success
                        : AppColors.textPrimary,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                  ),
                  child: Text(
                    lead.badge,
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.textOnPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lead.clientName,
                            style: AppTypography.titleMedium.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            lead.projectTitle,
                            style: AppTypography.labelMedium.copyWith(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      lead.statusLabel,
                      style: AppTypography.labelMedium.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ],
                ),
                if (lead.description != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    lead.description!,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.4,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
                if (lead.price != null || lead.timeline != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      if (lead.price != null) ...[
                        const Icon(Icons.payments_outlined, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          lead.price!,
                          style: AppTypography.bodySmall.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                      ],
                      if (lead.timeline != null) ...[
                        const Icon(Icons.schedule_outlined, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          lead.timeline!,
                          style: AppTypography.bodySmall.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
                const SizedBox(height: AppSpacing.md),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: onAction,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _actionBrown,
                      foregroundColor: AppColors.textOnPrimary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusPill),
                      ),
                    ),
                    child: Text(
                      lead.actionLabel,
                      style: AppTypography.labelLarge.copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                        color: AppColors.textOnPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AiTrendReportSection extends StatelessWidget {
  const AiTrendReportSection({
    super.key,
    required this.metrics,
    this.suggestion = ProviderPortfolioProfile.shopkeeperTrendSuggestion,
  });

  final List<TrendMetric> metrics;
  final String suggestion;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome_rounded, size: 20),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'AI TREND REPORT',
                style: AppTypography.titleMedium.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          ...metrics.map(
            (metric) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: _TrendMetricRow(metric: metric),
            ),
          ),
          Text(
            suggestion,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _TrendMetricRow extends StatelessWidget {
  const _TrendMetricRow({required this.metric});

  final TrendMetric metric;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              metric.label,
              style: AppTypography.labelMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '+${metric.growthPercent}%',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.success,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          metric.value,
          style: AppTypography.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
          child: LinearProgressIndicator(
            value: metric.progress,
            minHeight: 6,
            backgroundColor: AppColors.divider,
            color: AppColors.success,
          ),
        ),
      ],
    );
  }
}

class ProfileRecommendationsSection extends StatelessWidget {
  const ProfileRecommendationsSection({
    super.key,
    required this.recommendations,
    this.title = 'SOURCING RECS',
    this.exploreLabel = 'EXPLORE MARKETPLACE',
    this.onExplore,
    this.onRecTap,
  });

  final List<ProfileRecommendation> recommendations;
  final String title;
  final String exploreLabel;
  final VoidCallback? onExplore;
  final ValueChanged<ProfileRecommendation>? onRecTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.titleMedium.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ...recommendations.map(
            (rec) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: _RecommendationTile(
                rec: rec,
                onTap: () => onRecTap?.call(rec),
              ),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: onExplore,
              child: Text(
                exploreLabel,
                style: AppTypography.labelLarge.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.4,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecommendationTile extends StatelessWidget {
  const _RecommendationTile({required this.rec, this.onTap});

  final ProfileRecommendation rec;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            child: AppImage(
              source: rec.imageUrl,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rec.name,
                  style: AppTypography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  rec.subtitle,
                  style: AppTypography.labelMedium.copyWith(
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  _DashedBorderPainter({
    required this.color,
    required this.radius,
  });

  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(radius),
        ),
      );

    const dashWidth = 6.0;
    const dashSpace = 4.0;
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final end = distance + dashWidth;
        canvas.drawPath(
          metric.extractPath(distance, end.clamp(0, metric.length)),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.radius != radius;
  }
}
