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
      name: 'Amir Mehmood',
      specialty: 'Lahore silk Specialist',
      experienceYears: 15,
      imageUrl:
          'https://images.unsplash.com/photo-1558171813-4c088753af8f?w=400',
      meritScore: 4.8,
      location: 'Lahore',
    ),
    MockTailor(
      id: '2',
      name: 'Fatima Khan',
      specialty: 'Bridal Wear Expert',
      experienceYears: 12,
      imageUrl:
          'https://images.unsplash.com/photo-1583391733981-5c55a4f4f2c0?w=400',
      meritScore: 4.9,
      location: 'Karachi',
    ),
    MockTailor(
      id: '3',
      name: 'Hassan Ali',
      specialty: 'Men\'s Formal Specialist',
      experienceYears: 10,
      imageUrl:
          'https://images.unsplash.com/photo-1594938298603-c8148c4dae35?w=400',
      meritScore: 4.7,
      location: 'Islamabad',
    ),
  ];
}
