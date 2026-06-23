import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/auth/auth_session.dart';
import '../../../../core/enums/user_role.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/models/mock_direct_commission.dart';
import '../../../../shared/models/mock_user.dart';
import '../../../../shared/widgets/app_drawer.dart';
import '../../../../shared/widgets/app_header_bar.dart';
import '../../../../shared/widgets/customer_bottom_nav_bar.dart';
import '../../../../shared/widgets/direct_commission_order_card.dart';

class ProviderOrdersScreen extends StatefulWidget {
  const ProviderOrdersScreen({
    super.key,
    required this.role,
    required this.searchRoute,
    required this.onNavTap,
  });

  final UserRole role;
  final String searchRoute;
  final ValueChanged<int> onNavTap;

  @override
  State<ProviderOrdersScreen> createState() => _ProviderOrdersScreenState();
}

class _ProviderOrdersScreenState extends State<ProviderOrdersScreen> {
  late List<DirectCommissionRequest> _requests;

  @override
  void initState() {
    super.initState();
    _requests = DirectCommissionRequest.forRole(widget.role);
  }

  MockUser get _user {
    final current = AuthSession.currentUser;
    if (current != null && current.role == widget.role) return current;
    return switch (widget.role) {
      UserRole.tailor => MockUser.tailor,
      UserRole.shopkeeper => MockUser.shopkeeper,
      UserRole.customer => MockUser.customer,
    };
  }

  void _accept(DirectCommissionRequest request) {
    setState(() {
      _requests.removeWhere((item) => item.id == request.id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Accepted commission from ${request.customerName}'),
      ),
    );
  }

  void _decline(DirectCommissionRequest request) {
    setState(() {
      _requests.removeWhere((item) => item.id == request.id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Declined commission from ${request.customerName}'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            Text('Orders', style: AppTypography.titleLarge),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Direct commissions from customers who chose you exclusively.',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            if (_requests.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
                child: Text(
                  'No direct commissions yet. Customers who select you from '
                  'your profile will appear here.',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            else
              ..._requests.map(
                (request) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: DirectCommissionOrderCard(
                    request: request,
                    onAccept: () => _accept(request),
                    onDecline: () => _decline(request),
                  ),
                ),
              ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
      bottomNavigationBar: CustomerBottomNavBar(
        currentIndex: 2,
        onTap: widget.onNavTap,
      ),
    );
  }
}
