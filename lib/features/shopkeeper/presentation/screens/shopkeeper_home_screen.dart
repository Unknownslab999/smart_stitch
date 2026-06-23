import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/auth/auth_session.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/models/mock_shopkeeper_dashboard.dart';
import '../../../../shared/models/mock_user.dart';
import '../../../../shared/models/selected_image.dart';
import '../../../../shared/services/photo_picker_service.dart';
import '../../../../shared/widgets/app_header_bar.dart';
import '../../../../shared/widgets/app_drawer.dart';
import '../../../../shared/widgets/customer_bottom_nav_bar.dart';
import '../../../../shared/widgets/price_quote_sheet.dart';
import '../utils/shopkeeper_navigation.dart';
import '../widgets/shopkeeper_dashboard_sections.dart';

class ShopkeeperHomeScreen extends StatefulWidget {
  const ShopkeeperHomeScreen({super.key});

  @override
  State<ShopkeeperHomeScreen> createState() => _ShopkeeperHomeScreenState();
}

class _ShopkeeperHomeScreenState extends State<ShopkeeperHomeScreen> {
  String? _selectedCategory = ShopkeeperInventoryItem.filterCategories.first;
  String _searchQuery = '';
  SelectedImage? _uploadedMaterial;

  List<ShopkeeperInventoryItem> get _filteredInventory {
    return ShopkeeperInventoryItem.sampleData.where((item) {
      final matchesCategory = _selectedCategory == null ||
          item.categories.contains(_selectedCategory);
      final query = _searchQuery.trim().toLowerCase();
      final matchesSearch = query.isEmpty ||
          item.name.toLowerCase().contains(query) ||
          item.tags.any((tag) => tag.toLowerCase().contains(query));
      return matchesCategory && matchesSearch;
    }).toList();
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _uploadMaterial() async {
    final image = await PhotoPickerService.showPickerSheet(context);
    if (image == null || !mounted) return;
    setState(() => _uploadedMaterial = image);
    _showSnack('Material photo "${image.displayName}" ready to list');
  }

  Future<void> _sendOffer(ShopkeeperMaterialRequest request) async {
    final amount = await PriceQuoteSheet.show(
      context,
      title: 'Send Offer',
      subtitle:
          'Offer for ${request.materialName} (${request.quantity}) requested by '
          '${request.requestedBy}',
      confirmLabel: 'Send Offer',
      initialValue: 8000,
    );
    if (amount == null || !mounted) return;
    _showSnack(
      'Offer of ${PriceQuoteSheet.formatAmount(amount)} sent for '
      '${request.materialName}',
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MarketplaceHeaderSection(
              onExportInventory: () => _showSnack('Exporting inventory...'),
              onUploadMaterial: _uploadMaterial,
            ),
            if (_uploadedMaterial != null) ...[
              const SizedBox(height: AppSpacing.md),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                child: Image.memory(
                  _uploadedMaterial!.bytes,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.xl),
            ActiveMaterialRequestsSection(
              requests: ShopkeeperMaterialRequest.sampleData,
              onViewAll: () => _showSnack('Viewing all material requests...'),
              onSendOffer: _sendOffer,
            ),
            const SizedBox(height: AppSpacing.xl),
            InventorySearchSection(
              selectedCategory: _selectedCategory,
              categories: ShopkeeperInventoryItem.filterCategories,
              onCategorySelected: (category) {
                setState(() {
                  _selectedCategory =
                      _selectedCategory == category ? null : category;
                });
              },
              onSearchChanged: (value) {
                setState(() => _searchQuery = value);
              },
            ),
            const SizedBox(height: AppSpacing.lg),
            InventoryListSection(
              items: _filteredInventory,
              onItemTap: (item) => _showSnack('Opening ${item.name}'),
            ),
            const SizedBox(height: AppSpacing.xl),
            AddNewMaterialSection(
              onTap: () => _showSnack('Add new material'),
            ),
            const SizedBox(height: AppSpacing.xl),
            MaterialPortfolioSection(
              items: ShopkeeperPortfolioItem.sampleData,
              onItemTap: (item) => _showSnack('Viewing ${item.title}'),
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
      bottomNavigationBar: CustomerBottomNavBar(
        currentIndex: 0,
        onTap: (index) => handleShopkeeperNavTap(context, index),
      ),
    );
  }
}
