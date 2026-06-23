import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/auth/auth_session.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/models/mock_shop.dart';
import '../../../../shared/models/mock_tailor.dart';
import '../../../../shared/models/mock_user.dart';
import '../../../../features/customer/presentation/utils/customer_routes.dart';
import '../../../../features/customer/presentation/utils/customer_navigation.dart';
import '../../../../shared/widgets/app_drawer.dart';
import '../../../../shared/widgets/customer_bottom_nav_bar.dart';
import '../../../../shared/widgets/hero_banner.dart';
import '../../../../shared/widgets/provider_card.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../../shared/widgets/smart_stitch_logo.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthSession.currentUser ?? MockUser.customer;

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.sm),
            HeroBanner(
              onTryNow: () => context.push(RouteNames.aiAssistant),
            ),
            const SizedBox(height: AppSpacing.lg),
            SectionHeader(
              title: 'Tailors',
              onSeeAll: () {},
            ),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              height: 210,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                ),
                itemCount: MockTailor.sampleData.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(width: AppSpacing.md),
                itemBuilder: (context, index) {
                  final tailor = MockTailor.sampleData[index];
                  return ProviderCard(
                    name: tailor.name,
                    specialty: tailor.specialty,
                    experienceYears: tailor.experienceYears,
                    imageUrl: tailor.imageUrl,
                    onTap: () => context.push(
                      CustomerRoutes.tailorProfile(tailor.id),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            SectionHeader(
              title: 'Materials Shops',
              onSeeAll: () {},
            ),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              height: 210,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                ),
                itemCount: MockShop.sampleData.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(width: AppSpacing.md),
                itemBuilder: (context, index) {
                  final shop = MockShop.sampleData[index];
                  return ProviderCard(
                    name: shop.name,
                    specialty: shop.specialty,
                    experienceYears: shop.experienceYears,
                    imageUrl: shop.imageUrl,
                    onTap: () => context.push(
                      CustomerRoutes.shopProfile(shop.id),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
      floatingActionButton: HomeFabBar(
        onPlusPressed: () => context.push(RouteNames.customerSendRequest),
        onAiPressed: () => context.push(RouteNames.aiAssistant),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomerBottomNavBar(
        currentIndex: 0,
        onTap: (index) => handleCustomerNavTap(context, index),
      ),
    );
  }
}
