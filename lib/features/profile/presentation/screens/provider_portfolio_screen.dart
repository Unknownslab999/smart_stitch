import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/auth/auth_session.dart';
import '../../../../core/enums/user_role.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/models/mock_user.dart';
import '../../../../shared/models/provider_portfolio_profile.dart';
import '../../../../shared/models/selected_image.dart';
import '../../../../shared/services/photo_picker_service.dart';
import '../../../../shared/widgets/app_drawer.dart';
import '../../../../shared/widgets/app_header_bar.dart';
import '../../../../shared/widgets/picked_image_widget.dart';
import '../../../shopkeeper/presentation/widgets/shopkeeper_profile_sections.dart';

class ProviderPortfolioScreen extends StatefulWidget {
  const ProviderPortfolioScreen({
    super.key,
    required this.role,
    required this.searchRoute,
  });

  final UserRole role;
  final String searchRoute;

  @override
  State<ProviderPortfolioScreen> createState() => _ProviderPortfolioScreenState();
}

class _ProviderPortfolioScreenState extends State<ProviderPortfolioScreen> {
  final List<SelectedImage> _uploadedMasterpieces = [];
  SelectedImage? _featuredPhoto;

  MockUser get _user {
    final current = AuthSession.currentUser;
    if (current != null && current.role == widget.role) return current;
    return switch (widget.role) {
      UserRole.tailor => MockUser.tailor,
      UserRole.shopkeeper => MockUser.shopkeeper,
      UserRole.customer => MockUser.customer,
    };
  }

  bool get _isTailor => widget.role == UserRole.tailor;

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _addMasterpiece() async {
    final image = await PhotoPickerService.showPickerSheet(context);
    if (image == null || !mounted) return;
    setState(() => _uploadedMasterpieces.add(image));
    _showSnack('Masterpiece added to your portfolio showcase');
  }

  Future<void> _editFeatured() async {
    final image = await PhotoPickerService.showPickerSheet(context);
    if (image == null || !mounted) return;
    setState(() => _featuredPhoto = image);
    _showSnack('Featured work photo updated');
  }

  @override
  Widget build(BuildContext context) {
    final featured = _isTailor
        ? ProviderPortfolioProfile.tailorFeatured
        : ProviderPortfolioProfile.shopkeeperFeatured;

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: SmartStitchDrawer(user: _user),
      appBar: AppHeaderBar(
        showDrawerButton: true,
        onSearchTap: () => context.push(widget.searchRoute),
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
            Text('Portfolio', style: AppTypography.titleLarge),
            const SizedBox(height: AppSpacing.xs),
            Text(
              _isTailor
                  ? 'Showcase your best tailoring work to attract premium clients.'
                  : 'Showcase your finest fabrics and materials to top-tier tailors.',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            if (_featuredPhoto != null) ...[
              Text(
                'Your Featured Photo',
                style: AppTypography.labelLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                child: PickedImageWidget(
                  image: _featuredPhoto!,
                  height: 180,
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
            PortfolioSpotlightSection(
              subtitle: _isTailor
                  ? ProviderPortfolioProfile.tailorSpotlightSubtitle
                  : ProviderPortfolioProfile.shopkeeperSpotlightSubtitle,
              onEditFeatured: _editFeatured,
            ),
            const SizedBox(height: AppSpacing.md),
            FeaturedPortfolioCarousel(
              items: featured,
              onAddMasterpiece: _addMasterpiece,
              onWorkTap: (item) => _showSnack('Opening ${item.title}'),
            ),
            if (_uploadedMasterpieces.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Your Uploads',
                style: AppTypography.titleMedium.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              SizedBox(
                height: 120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _uploadedMasterpieces.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(width: AppSpacing.md),
                  itemBuilder: (context, index) {
                    final image = _uploadedMasterpieces[index];
                    return ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusMd),
                      child: PickedImageWidget(
                        image: image,
                        width: 120,
                        height: 120,
                      ),
                    );
                  },
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.lg),
            ProfileAnalyticsSection(
              analytics: _isTailor
                  ? ProviderPortfolioProfile.tailorAnalytics
                  : ProviderPortfolioProfile.shopkeeperAnalytics,
            ),
            const SizedBox(height: AppSpacing.xl),
            EliteStatusCard(
              status: _isTailor
                  ? ProviderPortfolioProfile.tailorElite
                  : ProviderPortfolioProfile.shopkeeperElite,
            ),
            const SizedBox(height: AppSpacing.xl),
            PremiumLeadsSection(
              leads: _isTailor
                  ? ProviderPortfolioProfile.tailorLeads
                  : ProviderPortfolioProfile.shopkeeperLeads,
              onDiscoveryFeed: () =>
                  _showSnack('Opening discovery feed...'),
              onLeadAction: (lead) => _showSnack(
                '${lead.actionLabel} for ${lead.clientName}',
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            AiTrendReportSection(
              metrics: _isTailor
                  ? ProviderPortfolioProfile.tailorTrends
                  : ProviderPortfolioProfile.shopkeeperTrends,
              suggestion: _isTailor
                  ? ProviderPortfolioProfile.tailorTrendSuggestion
                  : ProviderPortfolioProfile.shopkeeperTrendSuggestion,
            ),
            const SizedBox(height: AppSpacing.lg),
            ProfileRecommendationsSection(
              title: _isTailor ? 'CRAFT RECS' : 'SOURCING RECS',
              exploreLabel:
                  _isTailor ? 'VIEW ATELIER SERVICES' : 'EXPLORE MARKETPLACE',
              recommendations: _isTailor
                  ? ProviderPortfolioProfile.tailorRecommendations
                  : ProviderPortfolioProfile.shopkeeperRecommendations,
              onExplore: () => _showSnack(
                _isTailor
                    ? 'Viewing atelier services...'
                    : 'Exploring marketplace...',
              ),
              onRecTap: (rec) => _showSnack('Viewing ${rec.name}'),
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}
