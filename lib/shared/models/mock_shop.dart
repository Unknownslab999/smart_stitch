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
      specialty: 'Lahore silk Specialist',
      experienceYears: 15,
      imageUrl:
          'https://images.unsplash.com/photo-1558171813-4c088753af8f?w=400',
      meritScore: 4.6,
      location: 'Lahore',
    ),
    MockShop(
      id: '2',
      name: 'Silk House',
      specialty: 'Premium Fabrics',
      experienceYears: 20,
      imageUrl:
          'https://images.unsplash.com/photo-1617104424971-3f2e1f69c3a2?w=400',
      meritScore: 4.8,
      location: 'Karachi',
    ),
    MockShop(
      id: '3',
      name: 'Lace & More',
      specialty: 'Lace & Accessories',
      experienceYears: 8,
      imageUrl:
          'https://images.unsplash.com/photo-1583391733981-5c55a4f4f2c0?w=400',
      meritScore: 4.5,
      location: 'Rawalpindi',
    ),
  ];
}
