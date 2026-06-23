class MockQuotation {
  const MockQuotation({
    required this.id,
    required this.providerName,
    required this.price,
    required this.location,
    this.estimatedDays = 7,
    this.rating = 4.5,
    this.isUrgent = false,
  });

  final String id;
  final String providerName;
  final double price;
  final String location;
  final int estimatedDays;
  final double rating;
  final bool isUrgent;

  String get formattedPrice {
    final amount = price.round().toString();
    final buffer = StringBuffer('PKR ');
    for (var i = 0; i < amount.length; i++) {
      if (i > 0 && (amount.length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(amount[i]);
    }
    return buffer.toString();
  }

  static const pending = [
    MockQuotation(
      id: 'q1',
      providerName: 'Ali Faisal',
      price: 3566,
      location: 'Johar Town Near Emporium',
      estimatedDays: 5,
      rating: 4.6,
    ),
    MockQuotation(
      id: 'q2',
      providerName: 'Haider Ali',
      price: 3966,
      location: 'Dream Gardens',
      estimatedDays: 7,
      rating: 4.8,
    ),
  ];
}

class MockOrderHistory {
  const MockOrderHistory({
    required this.id,
    required this.providerName,
    required this.price,
    this.status = OrderHistoryStatus.done,
  });

  final String id;
  final String providerName;
  final double price;
  final OrderHistoryStatus status;

  String get formattedPrice {
    final amount = price.round().toString();
    final buffer = StringBuffer('PKR ');
    for (var i = 0; i < amount.length; i++) {
      if (i > 0 && (amount.length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(amount[i]);
    }
    return buffer.toString();
  }

  static const sampleData = [
    MockOrderHistory(
      id: 'h1',
      providerName: 'Haider Ali',
      price: 3966,
    ),
    MockOrderHistory(
      id: 'h2',
      providerName: 'Amir Mehmood',
      price: 5200,
    ),
    MockOrderHistory(
      id: 'h3',
      providerName: 'Fatima Khan',
      price: 8750,
    ),
  ];
}

enum OrderHistoryStatus {
  done('Done'),
  inProgress('In Progress'),
  cancelled('Cancelled');

  const OrderHistoryStatus(this.label);
  final String label;
}
