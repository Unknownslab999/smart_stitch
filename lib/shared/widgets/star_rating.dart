import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class StarRating extends StatelessWidget {
  const StarRating({
    super.key,
    required this.rating,
    this.maxStars = 5,
    this.size = 18,
  });

  final double rating;
  final int maxStars;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxStars, (index) {
        final filled = index < rating.floor();
        final half = !filled && index < rating;

        return Icon(
          filled
              ? Icons.star_rounded
              : half
                  ? Icons.star_half_rounded
                  : Icons.star_outline_rounded,
          size: size,
          color: filled || half
              ? const Color(0xFFE8B923)
              : AppColors.inputBorder,
        );
      }),
    );
  }
}
