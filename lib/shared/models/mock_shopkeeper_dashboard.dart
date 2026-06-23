import '../../core/constants/app_assets.dart';

enum InventoryStockStatus {
  inStock('IN STOCK'),
  lowStock('LOW STOCK');

  const InventoryStockStatus(this.label);
  final String label;
}

class ShopkeeperMaterialRequest {
  const ShopkeeperMaterialRequest({
    required this.id,
    required this.materialName,
    required this.requestedBy,
    required this.quantity,
    required this.timeAgo,
    this.isUrgent = false,
  });

  final String id;
  final String materialName;
  final String requestedBy;
  final String quantity;
  final String timeAgo;
  final bool isUrgent;

  static const sampleData = [
    ShopkeeperMaterialRequest(
      id: '1',
      materialName: 'Raw Silk (Cream)',
      requestedBy: 'Atelier Marc',
      quantity: '15.5 Meters',
      timeAgo: '2h ago',
      isUrgent: true,
    ),
  ];
}

class ShopkeeperInventoryItem {
  const ShopkeeperInventoryItem({
    required this.id,
    required this.name,
    required this.pricePerMeter,
    required this.imageUrl,
    required this.tags,
    required this.stockStatus,
    required this.inventoryLabel,
    required this.inventoryValue,
    required this.detailLabel,
    required this.detailValue,
    this.isLowInventory = false,
    this.categories = const [],
  });

  final String id;
  final String name;
  final String pricePerMeter;
  final String imageUrl;
  final List<String> tags;
  final InventoryStockStatus stockStatus;
  final String inventoryLabel;
  final String inventoryValue;
  final String detailLabel;
  final String detailValue;
  final bool isLowInventory;
  final List<String> categories;

  static const sampleData = [
    ShopkeeperInventoryItem(
      id: '1',
      name: 'Emerald Mulberry Silk',
      pricePerMeter: 'PKR 820/m',
      imageUrl: AppAssets.dress5,
      tags: ['PREMIUM', 'NATURAL DYE'],
      stockStatus: InventoryStockStatus.inStock,
      inventoryLabel: 'INVENTORY',
      inventoryValue: '42.5 Meters',
      detailLabel: 'WEIGHT',
      detailValue: '19mm',
      categories: ['Silk'],
    ),
    ShopkeeperInventoryItem(
      id: '2',
      name: 'Chantilly Lace Veil',
      pricePerMeter: 'PKR 820/m',
      imageUrl: AppAssets.dress6,
      tags: ['HANDMADE', 'LACE'],
      stockStatus: InventoryStockStatus.lowStock,
      inventoryLabel: 'INVENTORY',
      inventoryValue: '4.2 Meters',
      detailLabel: 'ORIGIN',
      detailValue: 'Lahore',
      isLowInventory: true,
      categories: ['Lace'],
    ),
    ShopkeeperInventoryItem(
      id: '3',
      name: 'Pearl Button Set',
      pricePerMeter: 'PKR 120/set',
      imageUrl: AppAssets.dress7,
      tags: ['ACCESSORY', 'BUTTON'],
      stockStatus: InventoryStockStatus.inStock,
      inventoryLabel: 'INVENTORY',
      inventoryValue: '240 Units',
      detailLabel: 'SIZE',
      detailValue: '12mm',
      categories: ['Button'],
    ),
  ];

  static const filterCategories = ['Button', 'Lace', 'Silk', 'Cotton'];
}

class ShopkeeperPortfolioItem {
  const ShopkeeperPortfolioItem({
    required this.id,
    required this.seriesLabel,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });

  final String id;
  final String seriesLabel;
  final String title;
  final String subtitle;
  final String imageUrl;

  static const sampleData = [
    ShopkeeperPortfolioItem(
      id: '1',
      seriesLabel: 'WORKSHOP SERIES',
      title: 'Industrial Wool Stack',
      subtitle:
          'Showcasing the structural integrity and heritage weave of our British Wool collection.',
      imageUrl: AppAssets.dress8,
    ),
    ShopkeeperPortfolioItem(
      id: '2',
      seriesLabel: 'WORKSHOP SERIES',
      title: 'Heritage Lace Archive',
      subtitle:
          'Hand-finished Chantilly lace selected for recent bridal couture commissions.',
      imageUrl: AppAssets.dress4,
    ),
  ];
}
