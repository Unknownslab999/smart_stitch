import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/auth/auth_session.dart';
import '../../core/enums/user_role.dart';
import '../../core/routing/route_names.dart';
import '../../core/routing/drawer_navigation.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../features/auth/data/role_agreement_content.dart';
import '../models/mock_user.dart';
import 'smart_stitch_logo.dart';
import 'star_rating.dart';

class _DrawerItem {
  const _DrawerItem({
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;
}

class SmartStitchDrawer extends StatelessWidget {
  const SmartStitchDrawer({
    super.key,
    required this.user,
  });

  final MockUser user;

  static const _allMainItems = [
    _DrawerItem(label: 'Profile', icon: Icons.account_circle_outlined),
    _DrawerItem(label: 'Portfolio', icon: Icons.pie_chart_outline_rounded),
    _DrawerItem(label: 'Orders', icon: Icons.notifications_outlined),
    _DrawerItem(label: 'Order History', icon: Icons.history_rounded),
    _DrawerItem(
      label: 'Report an Issue',
      icon: Icons.help_outline_rounded,
    ),
    _DrawerItem(
      label: 'Help',
      icon: Icons.warning_amber_rounded,
    ),
  ];

  static const _bottomItems = [
    _DrawerItem(label: 'Setting', icon: Icons.settings_outlined),
    _DrawerItem(label: 'Logout', icon: Icons.logout_rounded),
  ];

  String get _agreementLabel => RoleAgreementContent.forRole(user.role).title;

  List<_DrawerItem> get _mainItems {
    final agreementItem = _DrawerItem(
      label: _agreementLabel,
      icon: Icons.description_outlined,
    );

    if (user.role == UserRole.customer) {
      return [
        ..._allMainItems.where((item) => item.label != 'Portfolio'),
        agreementItem,
      ];
    }

    return [..._allMainItems, agreementItem];
  }

  void _onItemTap(BuildContext context, _DrawerItem item) {
    Navigator.of(context).pop();
    if (item.label == 'Logout') {
      AuthSession.signOut();
      context.go(RouteNames.splash);
      return;
    }
    handleDrawerNavigation(context, user.role, item.label);
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;

    return Drawer(
      backgroundColor: AppColors.drawerBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(AppSpacing.radiusXl),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.lg,
                topPadding + AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.md,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SmartStitch',
                    style: AppTypography.titleLarge.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  SmartStitchLogo(
                    variant: SmartStitchLogoVariant.iconOnly,
                    height: 28,
                    maxWidth: 28,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Divider(color: AppColors.divider, height: 1),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.md,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ..._mainItems.map(
                      (item) => _DrawerTile(
                        item: item,
                        onTap: () => _onItemTap(context, item),
                      ),
                    ),
                    const Spacer(),
                    ..._bottomItems.map(
                      (item) => _DrawerTile(
                        item: item,
                        onTap: () => _onItemTap(context, item),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Divider(color: AppColors.divider, height: 1),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColors.textPrimary,
                    child: const Icon(
                      Icons.person_rounded,
                      color: AppColors.textOnPrimary,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.role.label,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textHint,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          user.fullName,
                          style: AppTypography.titleMedium.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        StarRating(rating: user.rating),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  const _DrawerTile({
    required this.item,
    required this.onTap,
  });

  final _DrawerItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.sm,
            horizontal: AppSpacing.xs,
          ),
          child: Row(
            children: [
              Icon(
                item.icon,
                size: 24,
                color: AppColors.textPrimary,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  item.label,
                  style: AppTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
