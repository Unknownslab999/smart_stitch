import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/models/mock_shop.dart';
import '../../../../shared/models/mock_tailor.dart';
import '../../../../shared/widgets/customer_bottom_nav_bar.dart';
import '../../../../shared/widgets/hero_banner.dart';
import '../../../../shared/widgets/provider_card.dart';
import '../../../../shared/widgets/section_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded),
          onPressed: () {},
        ),
        title: Text(
          'SmartStitch',
          style: AppTypography.logoSmall,
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
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(RouteNames.aiAssistant),
        backgroundColor: AppColors.primary,
        elevation: 4,
        child: const Icon(
          Icons.auto_awesome_rounded,
          color: AppColors.textOnPrimary,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomerBottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              break;
            case 1:
              context.go(RouteNames.customerSearch);
            case 2:
              context.go(RouteNames.customerOrders);
            case 3:
              context.go(RouteNames.customerProfile);
          }
        },
      ),
    );
  }
}
