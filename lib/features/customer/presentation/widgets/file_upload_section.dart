import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class FileUploadSection extends StatelessWidget {
  const FileUploadSection({
    super.key,
    this.fileName,
    this.onUpload,
  });

  final String? fileName;
  final VoidCallback? onUpload;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Upload Your File', style: AppTypography.titleLarge),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Upload your file or other media here',
          style: AppTypography.bodySmall.copyWith(color: AppColors.textHint),
        ),
        const SizedBox(height: AppSpacing.md),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.xl,
          ),
          decoration: BoxDecoration(
            color: AppColors.primaryLight.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            border: Border.all(color: AppColors.inputBorder),
          ),
          child: Column(
            children: [
              Icon(
                Icons.upload_file_rounded,
                size: 40,
                color: AppColors.textSecondary,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                fileName ?? 'Select file to upload',
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Supported Format: SVG, PNG, JPG',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textHint,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              SizedBox(
                height: 40,
                child: ElevatedButton.icon(
                  onPressed: onUpload,
                  icon: const Icon(Icons.file_upload_outlined, size: 18),
                  label: const Text('Upload File'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.textOnPrimary,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusPill),
                    ),
                    textStyle: AppTypography.labelLarge.copyWith(
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
