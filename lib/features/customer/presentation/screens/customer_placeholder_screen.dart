import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/customer_bottom_nav_bar.dart';

class CustomerPlaceholderScreen extends StatelessWidget {
  const CustomerPlaceholderScreen({
    super.key,
    required this.title,
    required this.navIndex,
    required this.onNavTap,
  });

  final String title;
  final int navIndex;
  final ValueChanged<int> onNavTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(title, style: AppTypography.titleLarge),
      ),
      body: Center(
        child: Text(
          '$title — Coming soon',
          style: AppTypography.bodyLarge.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ),
      bottomNavigationBar: CustomerBottomNavBar(
        currentIndex: navIndex,
        onTap: onNavTap,
      ),
    );
  }
}
