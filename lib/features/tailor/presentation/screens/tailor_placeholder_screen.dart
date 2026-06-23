import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/auth/auth_session.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/models/mock_user.dart';
import '../../../../shared/widgets/app_drawer.dart';
import '../../../../shared/widgets/app_header_bar.dart';
import '../../../../shared/widgets/customer_bottom_nav_bar.dart';

class TailorPlaceholderScreen extends StatelessWidget {
  const TailorPlaceholderScreen({
    super.key,
    required this.title,
    required this.navIndex,
    required this.onNavTap,
    this.onSearchTap,
    this.showBottomNav = true,
    this.showBackButton = false,
  });

  final String title;
  final int navIndex;
  final ValueChanged<int> onNavTap;
  final VoidCallback? onSearchTap;
  final bool showBottomNav;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    final user = AuthSession.currentUser ?? MockUser.tailor;

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: showBackButton ? null : SmartStitchDrawer(user: user),
      appBar: AppHeaderBar(
        showDrawerButton: !showBackButton,
        leading: showBackButton
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () => context.pop(),
              )
            : null,
        onSearchTap: onSearchTap,
        searchReadOnly: !showBackButton || title != 'Search',
      ),
      body: Center(
        child: Text(
          '$title — Coming soon',
          style: AppTypography.bodyLarge.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ),
      bottomNavigationBar: showBottomNav
          ? CustomerBottomNavBar(
              currentIndex: navIndex,
              onTap: onNavTap,
            )
          : null,
    );
  }
}
