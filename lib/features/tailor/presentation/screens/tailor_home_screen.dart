import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/auth/auth_session.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/models/mock_tailor_dashboard.dart';
import '../../../../shared/models/mock_user.dart';
import '../../../../shared/services/photo_picker_service.dart';
import '../../../../shared/widgets/app_header_bar.dart';
import '../../../../shared/widgets/app_drawer.dart';
import '../../../../shared/widgets/customer_bottom_nav_bar.dart';
import '../../../../shared/widgets/price_quote_sheet.dart';
import '../utils/tailor_navigation.dart';
import '../widgets/tailor_dashboard_sections.dart';

class TailorHomeScreen extends StatefulWidget {
  const TailorHomeScreen({super.key});

  @override
  State<TailorHomeScreen> createState() => _TailorHomeScreenState();
}

class _TailorHomeScreenState extends State<TailorHomeScreen> {
  late List<TailorIncomingRequest> _incomingRequests;

  @override
  void initState() {
    super.initState();
    _incomingRequests = List.of(TailorIncomingRequest.sampleData);
  }

  void _dismissRequest(TailorIncomingRequest request) {
    setState(() {
      _incomingRequests.removeWhere((item) => item.id == request.id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Dismissed request from ${request.customerName}')),
    );
  }

  Future<void> _quoteRequest(TailorIncomingRequest request) async {
    final amount = await PriceQuoteSheet.show(
      context,
      title: 'Send Quote',
      subtitle: 'Quote for ${request.customerName} — ${request.garmentDetail}',
      confirmLabel: 'Send Quote',
      initialValue: 5000,
    );
    if (amount == null || !mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Quote of ${PriceQuoteSheet.formatAmount(amount)} sent to '
          '${request.customerName}',
        ),
      ),
    );
  }

  Future<void> _attachToOrder(TailorActiveOrder order) async {
    final image = await PhotoPickerService.showPickerSheet(context);
    if (image == null || !mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Photo attached to ${order.orderNumber} (${image.displayName})',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthSession.currentUser ?? MockUser.tailor;

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: SmartStitchDrawer(user: user),
      appBar: AppHeaderBar(
        showDrawerButton: true,
        onSearchTap: () => context.push(RouteNames.tailorSearch),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DailySummarySection(
              summary: TailorDailySummary.current,
              onExportLog: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Exporting daily log...')),
                );
              },
            ),
            const SizedBox(height: AppSpacing.xl),
            IncomingRequestsSection(
              requests: _incomingRequests,
              queueCount: _incomingRequests.length,
              onDismiss: _dismissRequest,
              onQuote: _quoteRequest,
            ),
            const SizedBox(height: AppSpacing.xl),
            ActiveOrdersSection(
              orders: TailorActiveOrder.sampleData,
              onUpdateStatus: (order) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Updating ${order.orderNumber}')),
                );
              },
              onAttachment: _attachToOrder,
            ),
            const SizedBox(height: AppSpacing.xl),
            const AtelierHealthSection(
              health: TailorAtelierHealth.current,
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
      bottomNavigationBar: CustomerBottomNavBar(
        currentIndex: 0,
        onTap: (index) => handleTailorNavTap(context, index),
      ),
    );
  }
}
