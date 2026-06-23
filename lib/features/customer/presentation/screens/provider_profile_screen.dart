import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/auth/auth_session.dart';
import '../../../../core/enums/provider_type.dart';
import '../../../../core/enums/request_type.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/routing/send_request_args.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/models/mock_user.dart';
import '../../../../shared/models/provider_profile.dart';
import '../../../../shared/widgets/app_drawer.dart';
import '../widgets/portfolio_reviews_section.dart';
import '../widgets/provider_profile_header.dart';

class ProviderProfileScreen extends StatelessWidget {
  const ProviderProfileScreen({
    super.key,
    required this.type,
    required this.providerId,
  });

  final ProviderType type;
  final String providerId;

  @override
  Widget build(BuildContext context) {
    final profile = ProviderProfile.findById(type, providerId);
    final user = AuthSession.currentUser ?? MockUser.customer;

    if (profile == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: const Center(child: Text('Provider not found')),
      );
    }

    final portfolioTitle = switch (type) {
      ProviderType.tailor => 'Dresses & Work',
      ProviderType.shopkeeper => 'Materials & Fabrics',
    };

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.background,
        drawer: SmartStitchDrawer(user: user),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => context.pop(),
          ),
          title: Text(
            'SmartStitch',
            style: AppTypography.titleLarge.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.primaryDark,
            ),
          ),
          centerTitle: false,
          backgroundColor: AppColors.background,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(height: 1, color: AppColors.divider),
          ),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.sm,
                ),
                child: ProviderProfileHeader(profile: profile),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _TabBarDelegate(
                TabBar(
                  labelColor: AppColors.primaryDark,
                  unselectedLabelColor: AppColors.textHint,
                  indicatorColor: AppColors.primary,
                  labelStyle: AppTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  tabs: const [
                    Tab(text: 'Portfolio'),
                    Tab(text: 'Reviews'),
                  ],
                ),
              ),
            ),
          ],
          body: TabBarView(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: PortfolioGrid(
                  items: profile.portfolio,
                  title: portfolioTitle,
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: ReviewsList(reviews: profile.reviews),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'profile_send_request_fab',
          onPressed: () {
            context.push(
              RouteNames.customerSendRequest,
              extra: SendRequestArgs(
                providerId: profile.id,
                providerName: profile.name,
                providerImageUrl: profile.imageUrl,
                requestType: switch (type) {
                  ProviderType.tailor => RequestType.tailoring,
                  ProviderType.shopkeeper => RequestType.material,
                },
                isPersonal: true,
              ),
            );
          },
          backgroundColor: AppColors.primary,
          child: const Icon(
            Icons.add_rounded,
            color: AppColors.textOnPrimary,
          ),
        ),
      ),
    );
  }
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  _TabBarDelegate(this.tabBar);

  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: AppColors.background,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant _TabBarDelegate oldDelegate) => false;
}
