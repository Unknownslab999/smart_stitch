import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/models/mock_shopkeeper_dashboard.dart';

const _actionDark = Color(0xFF3D3028);

class MarketplaceHeaderSection extends StatelessWidget {
  const MarketplaceHeaderSection({
    super.key,
    this.onExportInventory,
    this.onUploadMaterial,
  });

  final VoidCallback? onExportInventory;
  final VoidCallback? onUploadMaterial;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          ),
          child: Text(
            'SHOPKEEPER DASHBOARD',
            style: AppTypography.labelMedium.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Material Marketplace',
          style: GoogleFonts.playfairDisplay(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            height: 1.2,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Manage your premium inventory and respond to bespoke fabric '
          'requests from top-tier tailors worldwide.',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48,
                child: OutlinedButton(
                  onPressed: onExportInventory,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textPrimary,
                    side: const BorderSide(color: AppColors.inputBorder),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusPill),
                    ),
                  ),
                  child: Text(
                    'EXPORT INVENTORY',
                    style: AppTypography.labelMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: SizedBox(
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: onUploadMaterial,
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: Text(
                    'UPLOAD MATERIAL',
                    style: AppTypography.labelMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.textPrimary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusPill),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ActiveMaterialRequestsSection extends StatelessWidget {
  const ActiveMaterialRequestsSection({
    super.key,
    required this.requests,
    this.onViewAll,
    this.onSendOffer,
  });

  final List<ShopkeeperMaterialRequest> requests;
  final VoidCallback? onViewAll;
  final ValueChanged<ShopkeeperMaterialRequest>? onSendOffer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.assignment_outlined,
              size: 20,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                'Active Material Requests',
                style: AppTypography.titleLarge.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            GestureDetector(
              onTap: onViewAll,
              child: Text(
                'View All Requests',
                style: AppTypography.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        ...requests.map(
          (request) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: _MaterialRequestCard(
              request: request,
              onSendOffer: () => onSendOffer?.call(request),
            ),
          ),
        ),
      ],
    );
  }
}

class _MaterialRequestCard extends StatelessWidget {
  const _MaterialRequestCard({
    required this.request,
    this.onSendOffer,
  });

  final ShopkeeperMaterialRequest request;
  final VoidCallback? onSendOffer;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (request.isUrgent)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                  ),
                  child: Text(
                    'URGENT',
                    style: AppTypography.labelMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                )
              else
                const SizedBox.shrink(),
              Text(
                request.timeAgo,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            request.materialName,
            style: AppTypography.titleLarge.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Requested by: ${request.requestedBy}',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Icon(
                Icons.mail_outline_rounded,
                size: 16,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                request.quantity,
                style: AppTypography.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              onPressed: onSendOffer,
              style: ElevatedButton.styleFrom(
                backgroundColor: _actionDark,
                foregroundColor: AppColors.textOnPrimary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
                ),
              ),
              child: Text(
                'SEND OFFER',
                style: AppTypography.labelLarge.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: AppColors.textOnPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InventorySearchSection extends StatelessWidget {
  const InventorySearchSection({
    super.key,
    required this.selectedCategory,
    required this.categories,
    this.onCategorySelected,
    this.onSearchChanged,
  });

  final String? selectedCategory;
  final List<String> categories;
  final ValueChanged<String>? onCategorySelected;
  final ValueChanged<String>? onSearchChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          onChanged: onSearchChanged,
          decoration: InputDecoration(
            hintText: 'Search materials, colors, or composition...',
            hintStyle: AppTypography.bodyMedium.copyWith(
              color: AppColors.textHint,
            ),
            prefixIcon: const Icon(
              Icons.search_rounded,
              color: AppColors.textHint,
            ),
            filled: true,
            fillColor: AppColors.surface,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
              borderSide: const BorderSide(color: AppColors.inputBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
              borderSide: const BorderSide(color: AppColors.inputBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categories.map((category) {
              final isSelected = selectedCategory == category;
              return Padding(
                padding: const EdgeInsets.only(right: AppSpacing.sm),
                child: FilterChip(
                  label: Text(category),
                  selected: isSelected,
                  onSelected: (_) => onCategorySelected?.call(category),
                  labelStyle: AppTypography.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                  ),
                  backgroundColor: AppColors.surfaceVariant,
                  selectedColor: AppColors.primary,
                  showCheckmark: false,
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xs,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class InventoryListSection extends StatelessWidget {
  const InventoryListSection({
    super.key,
    required this.items,
    this.onItemTap,
  });

  final List<ShopkeeperInventoryItem> items;
  final ValueChanged<ShopkeeperInventoryItem>? onItemTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.lg),
          child: _InventoryMaterialCard(
            item: item,
            onTap: () => onItemTap?.call(item),
          ),
        );
      }).toList(),
    );
  }
}

class _InventoryMaterialCard extends StatelessWidget {
  const _InventoryMaterialCard({
    required this.item,
    this.onTap,
  });

  final ShopkeeperInventoryItem item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    item.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.primaryLight,
                      child: const Icon(Icons.texture_rounded, size: 48),
                    ),
                  ),
                ),
                Positioned(
                  top: AppSpacing.sm,
                  right: AppSpacing.sm,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    ),
                    child: Text(
                      item.stockStatus.label,
                      style: AppTypography.labelMedium.copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                        color: item.stockStatus == InventoryStockStatus.lowStock
                            ? AppColors.error
                            : AppColors.textPrimary,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          style: AppTypography.titleLarge.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Text(
                        item.pricePerMeter,
                        style: AppTypography.bodyMedium.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.xs,
                    children: item.tags.map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceVariant,
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusSm),
                        ),
                        child: Text(
                          tag,
                          style: AppTypography.labelMedium.copyWith(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  const Divider(height: 1, color: AppColors.divider),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      Expanded(
                        child: _InventoryDetail(
                          label: item.inventoryLabel,
                          value: item.inventoryValue,
                          valueColor: item.isLowInventory
                              ? AppColors.error
                              : AppColors.textPrimary,
                        ),
                      ),
                      Expanded(
                        child: _InventoryDetail(
                          label: item.detailLabel,
                          value: item.detailValue,
                          alignEnd: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InventoryDetail extends StatelessWidget {
  const _InventoryDetail({
    required this.label,
    required this.value,
    this.valueColor,
    this.alignEnd = false,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.labelMedium.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: AppTypography.bodyMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}

class AddNewMaterialSection extends StatelessWidget {
  const AddNewMaterialSection({super.key, this.onTap});

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
        child: Container(
          width: double.infinity,
          height: 140,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.textHint),
                ),
                child: const Icon(
                  Icons.add_rounded,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Add New Material',
                style: AppTypography.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MaterialPortfolioSection extends StatelessWidget {
  const MaterialPortfolioSection({
    super.key,
    required this.items,
    this.onItemTap,
  });

  final List<ShopkeeperPortfolioItem> items;
  final ValueChanged<ShopkeeperPortfolioItem>? onItemTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Material Portfolio',
          textAlign: TextAlign.center,
          style: GoogleFonts.playfairDisplay(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'A curated showcase of your finest textiles used in recent haute '
          'couture projects. High-quality imagery helps tailors envision '
          'the final garment.',
          textAlign: TextAlign.center,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.lg),
            child: _PortfolioCard(
              item: item,
              onTap: () => onItemTap?.call(item),
            ),
          ),
        ),
      ],
    );
  }
}

class _PortfolioCard extends StatelessWidget {
  const _PortfolioCard({
    required this.item,
    this.onTap,
  });

  final ShopkeeperPortfolioItem item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: AspectRatio(
          aspectRatio: 4 / 3,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                item.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.primaryLight,
                  child: const Icon(Icons.image_outlined, size: 48),
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.75),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: AppSpacing.md,
                right: AppSpacing.md,
                bottom: AppSpacing.md,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.seriesLabel,
                      style: AppTypography.labelMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                        color: AppColors.textOnPrimary.withValues(alpha: 0.85),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      item.title,
                      style: AppTypography.titleLarge.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.textOnPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      item.subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textOnPrimary.withValues(alpha: 0.9),
                        height: 1.4,
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
