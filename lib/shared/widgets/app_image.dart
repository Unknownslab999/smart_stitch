import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

bool isAssetImage(String source) => source.startsWith('assets/');

ImageProvider imageProviderFor(String source) {
  if (isAssetImage(source)) {
    return AssetImage(source);
  }
  return NetworkImage(source);
}

class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    required this.source,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.errorIcon = Icons.image_outlined,
  });

  final String source;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final IconData errorIcon;

  @override
  Widget build(BuildContext context) {
    Widget image = isAssetImage(source)
        ? Image.asset(
            source,
            width: width,
            height: height,
            fit: fit,
            errorBuilder: _errorBuilder,
          )
        : Image.network(
            source,
            width: width,
            height: height,
            fit: fit,
            errorBuilder: _errorBuilder,
          );

    if (borderRadius != null) {
      image = ClipRRect(borderRadius: borderRadius!, child: image);
    }

    return image;
  }

  Widget _errorBuilder(BuildContext context, Object error, StackTrace? stack) {
    return Container(
      width: width,
      height: height,
      color: AppColors.primaryLight,
      child: Icon(errorIcon, color: AppColors.primary),
    );
  }
}
