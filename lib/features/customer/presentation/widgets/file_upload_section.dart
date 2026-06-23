import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/models/selected_image.dart';
import '../../../../shared/widgets/picked_image_widget.dart';

class FileUploadSection extends StatelessWidget {
  const FileUploadSection({
    super.key,
    this.selectedImage,
    this.onPick,
    this.onClear,
  });

  final SelectedImage? selectedImage;
  final VoidCallback? onPick;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Upload Your File', style: AppTypography.titleLarge),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Upload your design sketch or reference photo',
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
              if (selectedImage != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  child: PickedImageWidget(
                    image: selectedImage!,
                    height: 180,
                    width: double.infinity,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        selectedImage!.displayName,
                        style: AppTypography.bodyMedium.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      onPressed: onClear,
                      icon: const Icon(Icons.close_rounded, size: 20),
                      tooltip: 'Remove',
                    ),
                  ],
                ),
              ] else ...[
                Icon(
                  Icons.upload_file_rounded,
                  size: 40,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Select file to upload',
                  style: AppTypography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Supported Format: PNG, JPG',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textHint,
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.md),
              SizedBox(
                height: 40,
                child: ElevatedButton.icon(
                  onPressed: onPick,
                  icon: Icon(
                    selectedImage == null
                        ? Icons.file_upload_outlined
                        : Icons.swap_horiz_rounded,
                    size: 18,
                  ),
                  label: Text(
                    selectedImage == null ? 'Upload File' : 'Change Photo',
                  ),
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
