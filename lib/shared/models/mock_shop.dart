import '../../core/constants/app_assets.dart';

class MockShop {
  const MockShop({
    required this.id,
    required this.name,
    required this.specialty,
    required this.experienceYears,
    required this.imageUrl,
    required this.meritScore,
    required this.location,
  });

  final String id;
  final String name;
  final String specialty;
  final int experienceYears;
  final String imageUrl;
  final double meritScore;
  final String location;

  static const List<MockShop> sampleData = [
    MockShop(
      id: '1',
      name: 'Amir Mehmood',
      specialty: 'Lahore Silk Specialist',
      experienceYears: 15,
      imageUrl: AppAssets.dress5,
      meritScore: 4.6,
      location: 'Lahore',
    ),
    MockShop(
      id: '2',
      name: 'Silk House',
      specialty: 'Premium Fabrics',
      experienceYears: 20,
      imageUrl: AppAssets.dress6,
      meritScore: 4.8,
      location: 'Karachi',
    ),
    MockShop(
      id: '3',
      name: 'Lace & More',
      specialty: 'Lace & Accessories',
      experienceYears: 8,
      imageUrl: AppAssets.dress7,
      meritScore: 4.5,
      location: 'Rawalpindi',
    ),
  ];
}
