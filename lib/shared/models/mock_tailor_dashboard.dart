import '../../core/constants/app_assets.dart';

class TailorDailySummary {
  const TailorDailySummary({
    required this.orders,
    required this.pending,
    required this.dueToday,
  });

  final int orders;
  final int pending;
  final int dueToday;

  static const current = TailorDailySummary(
    orders: 142,
    pending: 12,
    dueToday: 3,
  );
}

class TailorIncomingRequest {
  const TailorIncomingRequest({
    required this.id,
    required this.customerName,
    required this.garmentDetail,
    required this.timeAgo,
    required this.imageUrl,
  });

  final String id;
  final String customerName;
  final String garmentDetail;
  final String timeAgo;
  final String imageUrl;

  static const sampleData = [
    TailorIncomingRequest(
      id: '1',
      customerName: 'AYESHA RAHIM',
      garmentDetail: 'Bridal Lehenga • Premium Silk • 2h ago',
      timeAgo: '2h ago',
      imageUrl: AppAssets.dress1,
    ),
    TailorIncomingRequest(
      id: '2',
      customerName: 'MEHWISH ALI',
      garmentDetail: 'Lawn 3-Piece • Cotton Silk • 4h ago',
      timeAgo: '4h ago',
      imageUrl: AppAssets.dress2,
    ),
    TailorIncomingRequest(
      id: '3',
      customerName: 'HIRA SHAH',
      garmentDetail: 'Party Frock • Chiffon • 6h ago',
      timeAgo: '6h ago',
      imageUrl: AppAssets.dress3,
    ),
  ];
}

enum TailorOrderStatus {
  inProgress('IN PROGRESS'),
  finishing('FINISHING'),
  priority('PRIORITY');

  const TailorOrderStatus(this.label);
  final String label;
}

class TailorActiveOrder {
  const TailorActiveOrder({
    required this.id,
    required this.orderNumber,
    required this.clientName,
    required this.expectedDate,
    required this.status,
    required this.progressLabel,
    required this.progressPercent,
    required this.actionLabel,
    this.isPriority = false,
  });

  final String id;
  final String orderNumber;
  final String clientName;
  final String expectedDate;
  final TailorOrderStatus status;
  final String progressLabel;
  final int progressPercent;
  final String actionLabel;
  final bool isPriority;

  static const sampleData = [
    TailorActiveOrder(
      id: '1',
      orderNumber: 'SS-2847',
      clientName: 'Komal Shah',
      expectedDate: 'Jun 22',
      status: TailorOrderStatus.inProgress,
      progressLabel: 'EMBROIDERY PHASE',
      progressPercent: 65,
      actionLabel: 'UPDATE STATUS',
      isPriority: true,
    ),
    TailorActiveOrder(
      id: '2',
      orderNumber: 'SS-2831',
      clientName: 'Sana Saif',
      expectedDate: 'Jun 25',
      status: TailorOrderStatus.finishing,
      progressLabel: 'FINAL FITTING',
      progressPercent: 88,
      actionLabel: 'UPDATE STATUS',
    ),
  ];
}

class TailorAtelierHealth {
  const TailorAtelierHealth({
    required this.qualityRating,
    required this.responseTimeHours,
    required this.clientReturnPercent,
  });

  final double qualityRating;
  final int responseTimeHours;
  final int clientReturnPercent;

  static const current = TailorAtelierHealth(
    qualityRating: 4.8,
    responseTimeHours: 2,
    clientReturnPercent: 68,
  );
}
