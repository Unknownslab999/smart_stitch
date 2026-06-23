import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/auth/auth_session.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/models/mock_user.dart';
import '../../../../shared/widgets/app_drawer.dart';
import '../../../../shared/widgets/smart_stitch_logo.dart';

class TailorHomeScreen extends StatelessWidget {
  const TailorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthSession.currentUser ?? MockUser.tailor;

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: SmartStitchDrawer(user: user),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: SmartStitchLogo(
          variant: SmartStitchLogoVariant.iconOnly,
          height: 36,
          maxWidth: 36,
        ),
        centerTitle: true,
        backgroundColor: AppColors.background,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.content_cut_rounded,
                size: 64,
                color: AppColors.primary,
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Tailor Dashboard',
                style: AppTypography.headlineMedium,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Welcome, ${user.fullName}',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Incoming requests, quotations, and orders will appear here.',
                textAlign: TextAlign.center,
                style: AppTypography.bodySmall,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(RouteNames.aiAssistant),
        backgroundColor: AppColors.primary,
        child: const Icon(
          Icons.auto_awesome_rounded,
          color: AppColors.textOnPrimary,
        ),
      ),
    );
  }
}
