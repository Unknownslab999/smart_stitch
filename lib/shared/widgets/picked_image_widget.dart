import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../models/selected_image.dart';

class PickedImageWidget extends StatelessWidget {
  const PickedImageWidget({
    super.key,
    required this.image,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  final SelectedImage image;
  final double? height;
  final double? width;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    Widget child = Image.memory(
      image.bytes,
      fit: fit,
      width: width,
      height: height,
    );

    if (borderRadius != null) {
      child = ClipRRect(borderRadius: borderRadius!, child: child);
    }

    if (height != null || width != null) {
      child = SizedBox(height: height, width: width, child: child);
    }

    return child;
  }
}

class PickedImagePreviewChip extends StatelessWidget {
  const PickedImagePreviewChip({
    super.key,
    required this.image,
    required this.onRemove,
    this.size = 72,
  });

  final SelectedImage image;
  final VoidCallback onRemove;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        PickedImageWidget(
          image: image,
          width: size,
          height: size,
          borderRadius: BorderRadius.circular(12),
        ),
        Positioned(
          top: -6,
          right: -6,
          child: Material(
            color: AppColors.surface,
            shape: const CircleBorder(),
            elevation: 2,
            child: InkWell(
              onTap: onRemove,
              customBorder: const CircleBorder(),
              child: const Padding(
                padding: EdgeInsets.all(4),
                child: Icon(Icons.close_rounded, size: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
