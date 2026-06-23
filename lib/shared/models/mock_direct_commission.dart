import '../../core/enums/user_role.dart';

class DirectCommissionRequest {
  const DirectCommissionRequest({
    required this.id,
    required this.customerName,
    required this.description,
    required this.budget,
    this.avatarUrl,
  });

  final String id;
  final String customerName;
  final String description;
  final double budget;
  final String? avatarUrl;

  String get formattedBudget {
    final amount = budget.round().toString();
    final buffer = StringBuffer('PKR ');
    for (var i = 0; i < amount.length; i++) {
      if (i > 0 && (amount.length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(amount[i]);
    }
    return buffer.toString();
  }

  static const tailorRequests = [
    DirectCommissionRequest(
      id: 'tc1',
      customerName: 'Komal Ayub',
      description: '3 Piece lawn shalwar kameez',
      budget: 3566,
    ),
    DirectCommissionRequest(
      id: 'tc2',
      customerName: 'Ruhan Khan',
      description: '3 Piece lawn shalwar kameez',
      budget: 3566,
    ),
    DirectCommissionRequest(
      id: 'tc3',
      customerName: 'Sana Saif',
      description: '3 Piece lawn shalwar kameez',
      budget: 3566,
    ),
  ];

  static const shopkeeperRequests = [
    DirectCommissionRequest(
      id: 'sc1',
      customerName: 'Komal Ayub',
      description: 'Raw Silk (Cream) — 15.5 meters',
      budget: 12700,
    ),
    DirectCommissionRequest(
      id: 'sc2',
      customerName: 'Ruhan Khan',
      description: 'Chantilly lace veil — 4 meters',
      budget: 3280,
    ),
    DirectCommissionRequest(
      id: 'sc3',
      customerName: 'Sana Saif',
      description: 'Pearl button set — 120 units',
      budget: 14400,
    ),
  ];

  static List<DirectCommissionRequest> forRole(UserRole role) {
    return switch (role) {
      UserRole.tailor => List.of(tailorRequests),
      UserRole.shopkeeper => List.of(shopkeeperRequests),
      UserRole.customer => const [],
    };
  }
}
