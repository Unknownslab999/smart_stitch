import '../../core/constants/app_assets.dart';

class MockTailor {
  const MockTailor({
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

  static const List<MockTailor> sampleData = [
    MockTailor(
      id: '1',
      name: 'Ayesha Mehmood',
      specialty: 'Bridal & Lawn Specialist',
      experienceYears: 15,
      imageUrl: AppAssets.dress1,
      meritScore: 4.8,
      location: 'Lahore',
    ),
    MockTailor(
      id: '2',
      name: 'Fatima Khan',
      specialty: 'Bridal Lehenga Expert',
      experienceYears: 12,
      imageUrl: AppAssets.dress2,
      meritScore: 4.9,
      location: 'Karachi',
    ),
    MockTailor(
      id: '3',
      name: 'Sana Malik',
      specialty: 'Festive & Party Wear',
      experienceYears: 10,
      imageUrl: AppAssets.dress3,
      meritScore: 4.7,
      location: 'Islamabad',
    ),
  ];
}
