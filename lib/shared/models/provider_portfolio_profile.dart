import '../../core/constants/app_assets.dart';

enum PremiumLeadStatus { newLead, active }

class FeaturedWork {
  const FeaturedWork({
    required this.id,
    required this.title,
    required this.saves,
    this.imageUrl,
    this.isPlaceholder = false,
  });

  final String id;
  final String title;
  final String saves;
  final String? imageUrl;
  final bool isPlaceholder;
}

class ProfileAnalytics {
  const ProfileAnalytics({
    required this.monthlyRevenue,
    required this.revenueTrendPercent,
    required this.profileViews,
  });

  final String monthlyRevenue;
  final int revenueTrendPercent;
  final String profileViews;
}

class EliteStatus {
  const EliteStatus({
    required this.retentionRate,
    required this.label,
    this.metricLabel = 'RETENTION RATE',
  });

  final int retentionRate;
  final String label;
  final String metricLabel;
}

class PremiumLead {
  const PremiumLead({
    required this.id,
    required this.clientName,
    required this.projectTitle,
    required this.imageUrl,
    required this.badge,
    required this.status,
    required this.actionLabel,
    this.price,
    this.timeline,
    this.description,
  });

  final String id;
  final String clientName;
  final String projectTitle;
  final String imageUrl;
  final String badge;
  final PremiumLeadStatus status;
  final String actionLabel;
  final String? price;
  final String? timeline;
  final String? description;

  String get statusLabel => switch (status) {
        PremiumLeadStatus.newLead => 'NEW',
        PremiumLeadStatus.active => 'ACTIVE',
      };
}

class TrendMetric {
  const TrendMetric({
    required this.label,
    required this.value,
    required this.growthPercent,
    required this.progress,
  });

  final String label;
  final String value;
  final int growthPercent;
  final double progress;
}

class ProfileRecommendation {
  const ProfileRecommendation({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.imageUrl,
  });

  final String id;
  final String name;
  final String subtitle;
  final String imageUrl;
}

abstract final class ProviderPortfolioProfile {
  static const shopkeeperSpotlightSubtitle =
      'Maximize your visibility to high-tier clientele.';

  static const tailorSpotlightSubtitle =
      'Showcase your finest craftsmanship to discerning clients.';

  static const shopkeeperFeatured = [
    FeaturedWork(
      id: 's1',
      title: 'PREMIUM RAW SILK',
      saves: '1.2k Saves',
      imageUrl: AppAssets.dress5,
    ),
    FeaturedWork(
      id: 's2',
      title: 'CHANTILLY LACE COLLECTION',
      saves: '842 Saves',
      imageUrl: AppAssets.dress6,
    ),
  ];

  static const tailorFeatured = [
    FeaturedWork(
      id: 't1',
      title: 'CUSTOM BRIDAL LEHENGA',
      saves: '2.1k Saves',
      imageUrl: AppAssets.dress1,
    ),
    FeaturedWork(
      id: 't2',
      title: 'EMBROIDERED LAWN SUIT',
      saves: '1.6k Saves',
      imageUrl: AppAssets.dress2,
    ),
  ];

  static const shopkeeperAnalytics = ProfileAnalytics(
    monthlyRevenue: 'Rs. 84,200',
    revenueTrendPercent: 12,
    profileViews: '3.2k',
  );

  static const tailorAnalytics = ProfileAnalytics(
    monthlyRevenue: 'Rs. 1,12,400',
    revenueTrendPercent: 18,
    profileViews: '4.8k',
  );

  static const shopkeeperElite = EliteStatus(
    retentionRate: 94,
    label: 'ELITE STATUS',
  );

  static const tailorElite = EliteStatus(
    retentionRate: 97,
    label: 'MASTER TAILOR',
    metricLabel: 'CLIENT SATISFACTION',
  );

  static const shopkeeperLeads = [
    PremiumLead(
      id: 'sl1',
      clientName: 'Hira Shah',
      projectTitle: 'BRIDAL SILK FABRIC ORDER',
      imageUrl: AppAssets.dress3,
      badge: 'HIGH POTENTIAL',
      status: PremiumLeadStatus.newLead,
      actionLabel: 'SEND PROPOSAL',
      price: 'RS. 45K+',
      timeline: '14 DAYS',
    ),
    PremiumLead(
      id: 'sl2',
      clientName: 'Sana Saif',
      projectTitle: 'PREMIUM LAWN COLLECTION',
      imageUrl: AppAssets.dress4,
      badge: 'REPEAT CLIENT',
      status: PremiumLeadStatus.active,
      actionLabel: 'VIEW FULL REQUIREMENTS',
      description:
          'Seeking soft premium lawn for a summer wedding wardrobe. '
          'Pastel tones preferred.',
    ),
  ];

  static const tailorLeads = [
    PremiumLead(
      id: 'tl1',
      clientName: 'Komal Shah',
      projectTitle: '3 PIECE LAWN SHALWAR KAMEEZ',
      imageUrl: AppAssets.dress7,
      badge: 'DIRECT COMMISSION',
      status: PremiumLeadStatus.newLead,
      actionLabel: 'SEND QUOTE',
      price: 'RS. 3.5K+',
      timeline: '10 DAYS',
    ),
    PremiumLead(
      id: 'tl2',
      clientName: 'Mehwish Ali',
      projectTitle: 'COUTURE EVENING GOWN',
      imageUrl: AppAssets.dress8,
      badge: 'BRIDAL CLIENT',
      status: PremiumLeadStatus.active,
      actionLabel: 'VIEW MEASUREMENTS',
      description:
          'Looking for a flowing silhouette with hand-embroidered bodice '
          'for a winter wedding reception.',
    ),
  ];

  static const shopkeeperTrends = [
    TrendMetric(
      label: 'Trending Texture',
      value: 'Sustainable Bamboo Linen',
      growthPercent: 240,
      progress: 0.92,
    ),
    TrendMetric(
      label: 'Trending Silhouette',
      value: 'Flowing Anarkali Cuts',
      growthPercent: 115,
      progress: 0.55,
    ),
  ];

  static const tailorTrends = [
    TrendMetric(
      label: 'Trending Technique',
      value: 'Hand-Embroidered Necklines',
      growthPercent: 185,
      progress: 0.88,
    ),
    TrendMetric(
      label: 'Trending Style',
      value: 'Pastel Bridal Lehengas',
      growthPercent: 132,
      progress: 0.62,
    ),
  ];

  static const shopkeeperTrendSuggestion =
      'Strategic Suggestion: premium lawn and silk blends are seeing higher '
      'conversion rates among bridal clientele this season.';

  static const tailorTrendSuggestion =
      'Strategic Suggestion: embroidered lawn suits and soft bridal lehengas '
      'are driving higher booking rates this season.';

  static const shopkeeperRecommendations = [
    ProfileRecommendation(
      id: 'sr1',
      name: 'Egyptian Cotton Giza',
      subtitle: 'BEST FOR SUMMER LAWN',
      imageUrl: AppAssets.dress5,
    ),
    ProfileRecommendation(
      id: 'sr2',
      name: 'Raw Tussar Silk',
      subtitle: 'BEST FOR BRIDAL WEAR',
      imageUrl: AppAssets.dress6,
    ),
  ];

  static const tailorRecommendations = [
    ProfileRecommendation(
      id: 'tr1',
      name: 'Hand-Embroidered Necklines',
      subtitle: 'SIGNATURE FINISHING TECHNIQUE',
      imageUrl: AppAssets.dress1,
    ),
    ProfileRecommendation(
      id: 'tr2',
      name: 'Precision Measurement Mapping',
      subtitle: 'PERFECT FIT WORKFLOW',
      imageUrl: AppAssets.dress2,
    ),
  ];
}
