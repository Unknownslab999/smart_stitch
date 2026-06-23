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
      customerName: 'ARJUN SHARMA',
      garmentDetail: 'Custom Sherwani • Silk Chiffon • 2h ago',
      timeAgo: '2h ago',
      imageUrl:
          'https://images.unsplash.com/photo-1594938298603-c8148c4dae35?w=200',
    ),
    TailorIncomingRequest(
      id: '2',
      customerName: 'MEERA PATEL',
      garmentDetail: 'Formal Blazer • Wool Blend • 4h ago',
      timeAgo: '4h ago',
      imageUrl:
          'https://images.unsplash.com/photo-1507679799987-c73779587ccf?w=200',
    ),
    TailorIncomingRequest(
      id: '3',
      customerName: 'KABIR SINGH',
      garmentDetail: 'Kurta Set • Cotton Silk • 6h ago',
      timeAgo: '6h ago',
      imageUrl:
          'https://images.unsplash.com/photo-1617127365659-c47fa864d8bc?w=200',
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
    this.isPriority = false,
    this.actionLabel = 'UPDATE STATUS',
  });

  final String id;
  final String orderNumber;
  final String clientName;
  final String expectedDate;
  final TailorOrderStatus status;
  final String progressLabel;
  final int progressPercent;
  final bool isPriority;
  final String actionLabel;

  static const sampleData = [
    TailorActiveOrder(
      id: '1',
      orderNumber: 'ST-8821',
      clientName: 'Priya V.',
      expectedDate: 'Oct 24',
      status: TailorOrderStatus.inProgress,
      progressLabel: 'MANUFACTURING PROGRESS',
      progressPercent: 65,
      isPriority: true,
      actionLabel: 'UPDATE STATUS',
    ),
    TailorActiveOrder(
      id: '2',
      orderNumber: 'ST-8794',
      clientName: 'Rohan D.',
      expectedDate: 'Oct 20',
      status: TailorOrderStatus.finishing,
      progressLabel: 'QUALITY CONTROL',
      progressPercent: 90,
      actionLabel: 'MARK READY',
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
  final double responseTimeHours;
  final int clientReturnPercent;

  static const current = TailorAtelierHealth(
    qualityRating: 4.5,
    responseTimeHours: 1.4,
    clientReturnPercent: 22,
  );
}
