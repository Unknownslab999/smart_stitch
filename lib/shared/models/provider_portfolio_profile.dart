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
      title: 'SILK LAPEL TUXEDO',
      saves: '1.2k Saves',
      imageUrl:
          'https://images.unsplash.com/photo-1583391733981-5c55a4f4f2c0?w=600',
    ),
    FeaturedWork(
      id: 's2',
      title: 'ITALIAN MERINO OVERCOAT',
      saves: '842 Saves',
      isPlaceholder: true,
    ),
  ];

  static const tailorFeatured = [
    FeaturedWork(
      id: 't1',
      title: 'CUSTOM BRIDAL LEHENGA',
      saves: '2.1k Saves',
      imageUrl:
          'https://images.unsplash.com/photo-1595777457583-95e059d581b8?w=600',
    ),
    FeaturedWork(
      id: 't2',
      title: 'BESPOKE CHARCOAL BLAZER',
      saves: '1.6k Saves',
      imageUrl:
          'https://images.unsplash.com/photo-1594938298603-c8148c4dae35?w=600',
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
      clientName: 'Arjun Sharma',
      projectTitle: 'HERITAGE SILK SHERWANI',
      imageUrl:
          'https://images.unsplash.com/photo-1594938298603-c8148c4dae35?w=600',
      badge: 'HIGH POTENTIAL',
      status: PremiumLeadStatus.newLead,
      actionLabel: 'SEND PROPOSAL',
      price: 'RS. 45K+',
      timeline: '14 DAYS',
    ),
    PremiumLead(
      id: 'sl2',
      clientName: 'Sarah Khan',
      projectTitle: 'DOUBLE-BREASTED BLAZER',
      imageUrl:
          'https://images.unsplash.com/photo-1595777457583-95e059d581b8?w=600',
      badge: 'GLOBAL CLIENT',
      status: PremiumLeadStatus.active,
      actionLabel: 'VIEW FULL REQUIREMENTS',
      description:
          'Seeking a sharp, structured fit for an upcoming gala. '
          'High-quality wool preferred.',
    ),
  ];

  static const tailorLeads = [
    PremiumLead(
      id: 'tl1',
      clientName: 'Komal Ayub',
      projectTitle: '3 PIECE LAWN SHALWAR KAMEEZ',
      imageUrl:
          'https://images.unsplash.com/photo-1617127365659-c47fa864d8bc?w=600',
      badge: 'DIRECT COMMISSION',
      status: PremiumLeadStatus.newLead,
      actionLabel: 'SEND QUOTE',
      price: 'RS. 3.5K+',
      timeline: '10 DAYS',
    ),
    PremiumLead(
      id: 'tl2',
      clientName: 'Meera Patel',
      projectTitle: 'COUTURE EVENING GOWN',
      imageUrl:
          'https://images.unsplash.com/photo-1566174053879-31528523f8ae?w=600',
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
      value: 'Oversized Deconstructed',
      growthPercent: 115,
      progress: 0.55,
    ),
  ];

  static const tailorTrends = [
    TrendMetric(
      label: 'Trending Technique',
      value: 'Half-Canvas Construction',
      growthPercent: 185,
      progress: 0.88,
    ),
    TrendMetric(
      label: 'Trending Style',
      value: 'Soft Neapolitan Shoulder',
      growthPercent: 132,
      progress: 0.62,
    ),
  ];

  static const shopkeeperTrendSuggestion =
      'Strategic Suggestion: linen blends are seeing higher conversion '
      'rates among premium clientele this season.';

  static const tailorTrendSuggestion =
      'Strategic Suggestion: unstructured tailoring and soft shoulders '
      'are driving higher booking rates for formalwear this season.';

  static const shopkeeperRecommendations = [
    ProfileRecommendation(
      id: 'sr1',
      name: 'Egyptian Cotton Giza',
      subtitle: 'BEST FOR FORMAL SHIRTS',
      imageUrl:
          'https://images.unsplash.com/photo-1558171813-4c088753af8f?w=200',
    ),
    ProfileRecommendation(
      id: 'sr2',
      name: 'Raw Tussar Silk',
      subtitle: 'BEST FOR ETHNIC OUTERWEAR',
      imageUrl:
          'https://images.unsplash.com/photo-1617104424971-3f2e1f69c3a2?w=200',
    ),
  ];

  static const tailorRecommendations = [
    ProfileRecommendation(
      id: 'tr1',
      name: 'Hand-Stitched Lapels',
      subtitle: 'SIGNATURE FINISHING TECHNIQUE',
      imageUrl:
          'https://images.unsplash.com/photo-1507679799987-c73779587ccf?w=200',
    ),
    ProfileRecommendation(
      id: 'tr2',
      name: '3D Body Mapping',
      subtitle: 'PRECISION FIT WORKFLOW',
      imageUrl:
          'https://images.unsplash.com/photo-1617137968427-85924c800a41?w=200',
    ),
  ];
}
