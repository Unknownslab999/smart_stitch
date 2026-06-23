import 'package:flutter/material.dart';

class MockSelectableProvider {
  const MockSelectableProvider({
    required this.id,
    required this.name,
    required this.rating,
    required this.avatarColor,
  });

  final String id;
  final String name;
  final double rating;
  final Color avatarColor;

  static const List<MockSelectableProvider> tailors = [
    MockSelectableProvider(
      id: '1',
      name: 'Rehan Khan',
      rating: 4,
      avatarColor: Color(0xFFC5A88E),
    ),
    MockSelectableProvider(
      id: '2',
      name: 'Nadir',
      rating: 4,
      avatarColor: Color(0xFFE8D5C4),
    ),
    MockSelectableProvider(
      id: '3',
      name: 'Salim khan',
      rating: 4,
      avatarColor: Color(0xFFC5A88E),
    ),
    MockSelectableProvider(
      id: '4',
      name: 'Ruhab',
      rating: 4,
      avatarColor: Color(0xFFE8D5C4),
    ),
  ];

  static const List<MockSelectableProvider> shops = [
    MockSelectableProvider(
      id: 's1',
      name: 'Silk House',
      rating: 4.5,
      avatarColor: Color(0xFFC5A88E),
    ),
    MockSelectableProvider(
      id: 's2',
      name: 'Lace & More',
      rating: 4,
      avatarColor: Color(0xFFE8D5C4),
    ),
    MockSelectableProvider(
      id: 's3',
      name: 'Fabric World',
      rating: 4,
      avatarColor: Color(0xFFC5A88E),
    ),
    MockSelectableProvider(
      id: 's4',
      name: 'Thread Co.',
      rating: 4.5,
      avatarColor: Color(0xFFE8D5C4),
    ),
  ];
}
