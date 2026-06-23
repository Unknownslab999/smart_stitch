import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/auth/auth_session.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/models/provider_portfolio_profile.dart';
import '../../../../shared/models/mock_user.dart';
import '../../../../shared/widgets/app_drawer.dart';
import '../../../../shared/widgets/app_header_bar.dart';
import '../../../../shared/widgets/customer_bottom_nav_bar.dart';
import '../utils/shopkeeper_navigation.dart';
import '../widgets/shopkeeper_profile_sections.dart';

class ShopkeeperProfileScreen extends StatelessWidget {
  const ShopkeeperProfileScreen({super.key});

  void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthSession.currentUser ?? MockUser.shopkeeper;

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: SmartStitchDrawer(user: user),
      appBar: AppHeaderBar(
        showDrawerButton: true,
        onSearchTap: () => context.push(RouteNames.shopkeeperSearch),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, color: AppColors.divider),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Profile', style: AppTypography.titleLarge),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Welcome back, ${user.fullName}',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            PortfolioSpotlightSection(
              onEditFeatured: () => _showSnack(context, 'Editing featured work...'),
            ),
            const SizedBox(height: AppSpacing.md),
            FeaturedPortfolioCarousel(
              items: ProviderPortfolioProfile.shopkeeperFeatured,
              onAddMasterpiece: () =>
                  _showSnack(context, 'Uploading masterpiece...'),
              onWorkTap: (item) =>
                  _showSnack(context, 'Opening ${item.title}'),
            ),
            const SizedBox(height: AppSpacing.lg),
            const ProfileAnalyticsSection(
              analytics: ProviderPortfolioProfile.shopkeeperAnalytics,
            ),
            const SizedBox(height: AppSpacing.xl),
            const EliteStatusCard(
              status: ProviderPortfolioProfile.shopkeeperElite,
            ),
            const SizedBox(height: AppSpacing.xl),
            PremiumLeadsSection(
              leads: ProviderPortfolioProfile.shopkeeperLeads,
              onDiscoveryFeed: () =>
                  _showSnack(context, 'Opening discovery feed...'),
              onLeadAction: (lead) =>
                  _showSnack(context, '${lead.actionLabel} for ${lead.clientName}'),
            ),
            const SizedBox(height: AppSpacing.lg),
            const AiTrendReportSection(
              metrics: ProviderPortfolioProfile.shopkeeperTrends,
            ),
            const SizedBox(height: AppSpacing.lg),
            ProfileRecommendationsSection(
              recommendations: ProviderPortfolioProfile.shopkeeperRecommendations,
              onExplore: () =>
                  _showSnack(context, 'Exploring marketplace...'),
              onRecTap: (rec) => _showSnack(context, 'Viewing ${rec.name}'),
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
      bottomNavigationBar: CustomerBottomNavBar(
        currentIndex: 3,
        onTap: (index) => handleShopkeeperNavTap(context, index),
      ),
    );
  }
}
