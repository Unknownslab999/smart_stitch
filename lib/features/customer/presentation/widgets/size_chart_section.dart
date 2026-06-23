import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class SizeChartSection extends StatelessWidget {
  const SizeChartSection({super.key});

  static const _shirtRow = ['Shirt', '47', '19', '19', '10'];
  static const _trouserRow = ['Trouser', '47', '19', '19', '10'];
  static const _headers = ['', 'Length', 'Waist', 'Shoulders', 'Sleeve/L'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Size Chart', style: AppTypography.titleLarge),
        const SizedBox(height: AppSpacing.md),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.primaryLight.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            border: Border.all(color: AppColors.inputBorder),
          ),
          child: Column(
            children: [
              _MeasurementTable(
                headers: _headers,
                row: _shirtRow,
              ),
              const SizedBox(height: AppSpacing.md),
              _MeasurementTable(
                headers: _headers,
                row: _trouserRow,
                lastColumnLabel: 'Poecha',
              ),
              const SizedBox(height: AppSpacing.md),
              SizedBox(
                height: 44,
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.textOnPrimary,
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusPill),
                    ),
                  ),
                  child: Text(
                    'Set Size',
                    style: AppTypography.labelLarge.copyWith(
                      color: AppColors.textOnPrimary,
                      fontWeight: FontWeight.w600,
                    ),
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

class _MeasurementTable extends StatelessWidget {
  const _MeasurementTable({
    required this.headers,
    required this.row,
    this.lastColumnLabel,
  });

  final List<String> headers;
  final List<String> row;
  final String? lastColumnLabel;

  @override
  Widget build(BuildContext context) {
    final displayHeaders = List<String>.from(headers);
    if (lastColumnLabel != null && displayHeaders.isNotEmpty) {
      displayHeaders[displayHeaders.length - 1] = lastColumnLabel!;
    }

    return Table(
      border: TableBorder.all(color: AppColors.inputBorder),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.8),
          ),
          children: displayHeaders
              .map(
                (header) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.sm,
                  ),
                  child: Text(
                    header,
                    style: AppTypography.bodySmall.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
              .toList(),
        ),
        TableRow(
          children: row
              .map(
                (cell) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.sm,
                  ),
                  child: Text(
                    cell,
                    style: AppTypography.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
