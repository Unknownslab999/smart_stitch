import '../../core/constants/app_assets.dart';
import '../../core/enums/provider_type.dart';
import 'mock_shop.dart';
import 'mock_tailor.dart';
import 'portfolio_item.dart';

class ProviderProfile {
  const ProviderProfile({
    required this.id,
    required this.type,
    required this.name,
    required this.specialty,
    required this.imageUrl,
    required this.location,
    required this.following,
    required this.projects,
    required this.rating,
    required this.experienceYears,
    required this.portfolio,
    required this.reviews,
  });

  final String id;
  final ProviderType type;
  final String name;
  final String specialty;
  final String imageUrl;
  final String location;
  final int following;
  final int projects;
  final double rating;
  final int experienceYears;
  final List<PortfolioItem> portfolio;
  final List<ProviderReview> reviews;

  String get roleLabel => type.label;

  static final _portfolioImages = AppAssets.dresses;

  static final _fabricImages = [
    AppAssets.dress5,
    AppAssets.dress6,
    AppAssets.dress7,
    AppAssets.dress8,
  ];

  static List<PortfolioItem> _buildPortfolio(
    String prefix,
    List<String> images,
    List<String> titles,
  ) {
    return List.generate(images.length, (index) {
      return PortfolioItem(
        id: '$prefix-$index',
        title: titles[index % titles.length],
        imageUrl: images[index % images.length],
      );
    });
  }

  static List<ProviderReview> _defaultReviews(String providerName) {
    return [
      ProviderReview(
        customerName: 'Ayesha R.',
        rating: 5,
        comment:
            'Excellent work from $providerName. Perfect fitting and finishing.',
        date: '2 weeks ago',
      ),
      ProviderReview(
        customerName: 'Hira M.',
        rating: 4.5,
        comment: 'Beautiful stitching and delivered on time. Highly recommended.',
        date: '1 month ago',
      ),
      ProviderReview(
        customerName: 'Sana M.',
        rating: 4,
        comment: 'Very professional. Will order again.',
        date: '2 months ago',
      ),
    ];
  }

  static ProviderProfile? findById(ProviderType type, String id) {
    return switch (type) {
      ProviderType.tailor => _fromTailor(
          MockTailor.sampleData.where((t) => t.id == id).firstOrNull,
        ),
      ProviderType.shopkeeper => _fromShop(
          MockShop.sampleData.where((s) => s.id == id).firstOrNull,
        ),
    };
  }

  static ProviderProfile? _fromTailor(MockTailor? tailor) {
    if (tailor == null) return null;

    final projectCount = switch (tailor.id) {
      '1' => 10000,
      '2' => 8500,
      _ => 4200,
    };

    return ProviderProfile(
      id: tailor.id,
      type: ProviderType.tailor,
      name: tailor.name,
      specialty: tailor.specialty,
      imageUrl: tailor.imageUrl,
      location: tailor.location,
      following: switch (tailor.id) {
        '1' => 400,
        '2' => 320,
        _ => 180,
      },
      projects: projectCount,
      rating: tailor.meritScore,
      experienceYears: tailor.experienceYears,
      portfolio: _buildPortfolio(
        tailor.id,
        _portfolioImages,
        const [
          'Bridal Lehenga',
          'Lawn 3-Piece',
          'Silk Kurti',
          'Embroidered Frock',
          'Casual Shalwar Kameez',
          'Party Wear',
        ],
      ),
      reviews: _defaultReviews(tailor.name),
    );
  }

  static ProviderProfile? _fromShop(MockShop? shop) {
    if (shop == null) return null;

    return ProviderProfile(
      id: shop.id,
      type: ProviderType.shopkeeper,
      name: shop.name,
      specialty: shop.specialty,
      imageUrl: shop.imageUrl,
      location: shop.location,
      following: switch (shop.id) {
        '1' => 250,
        '2' => 510,
        _ => 190,
      },
      projects: switch (shop.id) {
        '1' => 3200,
        '2' => 7800,
        _ => 1500,
      },
      rating: shop.meritScore,
      experienceYears: shop.experienceYears,
      portfolio: _buildPortfolio(
        shop.id,
        _fabricImages,
        const [
          'Premium Silk',
          'Cotton Collection',
          'Lace & Trim',
          'Bridal Fabric',
        ],
      ),
      reviews: _defaultReviews(shop.name),
    );
  }
}

extension<T> on Iterable<T> {
  T? get firstOrNull {
    final iterator = this.iterator;
    if (iterator.moveNext()) return iterator.current;
    return null;
  }
}
