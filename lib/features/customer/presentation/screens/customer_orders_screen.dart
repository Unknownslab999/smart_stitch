import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/auth/auth_session.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/models/mock_quotation.dart';
import '../../../../shared/models/mock_user.dart';
import '../../../../shared/widgets/app_drawer.dart';
import '../../../../shared/widgets/customer_bottom_nav_bar.dart';
import '../../../../shared/widgets/app_header_bar.dart';
import '../utils/customer_navigation.dart';
import '../widgets/order_cards.dart';

class CustomerOrdersScreen extends StatefulWidget {
  const CustomerOrdersScreen({super.key});

  @override
  State<CustomerOrdersScreen> createState() => _CustomerOrdersScreenState();
}

class _CustomerOrdersScreenState extends State<CustomerOrdersScreen> {
  late List<MockQuotation> _quotations;
  late List<MockOrderHistory> _orderHistory;

  @override
  void initState() {
    super.initState();
    _quotations = List.of(MockQuotation.pending);
    _orderHistory = List.of(MockOrderHistory.sampleData);
  }

  void _acceptQuotation(MockQuotation quotation) {
    setState(() {
      _quotations.removeWhere((item) => item.id == quotation.id);
      _orderHistory.insert(
        0,
        MockOrderHistory(
          id: 'accepted-${quotation.id}',
          providerName: quotation.providerName,
          price: quotation.price,
          status: OrderHistoryStatus.inProgress,
        ),
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Accepted quotation from ${quotation.providerName}'),
      ),
    );
  }

  void _declineQuotation(MockQuotation quotation) {
    setState(() {
      _quotations.removeWhere((item) => item.id == quotation.id);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Declined quotation from ${quotation.providerName}'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthSession.currentUser ?? MockUser.customer;

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: SmartStitchDrawer(user: user),
      appBar: AppHeaderBar(
        showDrawerButton: true,
        onSearchTap: () => context.push(RouteNames.customerSearch),
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
            Text('Quotations', style: AppTypography.titleLarge),
            const SizedBox(height: AppSpacing.md),
            if (_quotations.isEmpty)
              _EmptyStateMessage(
                message:
                    'No pending quotations yet. Send a request to receive offers from tailors and shopkeepers.',
              )
            else
              ..._quotations.map(
                (quotation) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: QuotationCard(
                    quotation: quotation,
                    onAccept: () => _acceptQuotation(quotation),
                    onDecline: () => _declineQuotation(quotation),
                  ),
                ),
              ),
            const SizedBox(height: AppSpacing.lg),
            Text('Order History', style: AppTypography.titleLarge),
            const SizedBox(height: AppSpacing.md),
            if (_orderHistory.isEmpty)
              const _EmptyStateMessage(
                message: 'Your completed orders will appear here.',
              )
            else
              ..._orderHistory.map(
                (order) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: OrderHistoryCard(order: order),
                ),
              ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
      bottomNavigationBar: CustomerBottomNavBar(
        currentIndex: 2,
        onTap: (index) => handleCustomerNavTap(context, index),
      ),
    );
  }
}

class _EmptyStateMessage extends StatelessWidget {
  const _EmptyStateMessage({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Text(
        message,
        style: AppTypography.bodySmall.copyWith(
          color: AppColors.textSecondary,
          height: 1.4,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
