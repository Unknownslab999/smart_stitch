class MockQuotation {
  const MockQuotation({
    required this.id,
    required this.providerName,
    required this.price,
    required this.estimatedDays,
    required this.rating,
    required this.isUrgent,
  });

  final String id;
  final String providerName;
  final double price;
  final int estimatedDays;
  final double rating;
  final bool isUrgent;
}
