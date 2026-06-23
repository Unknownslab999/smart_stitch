import '../../core/enums/user_role.dart';

class MockUser {
  const MockUser({
    required this.email,
    required this.fullName,
    required this.role,
    required this.rating,
  });

  final String email;
  final String fullName;
  final UserRole role;
  final double rating;

  static const customer = MockUser(
    email: 'cust@gmail.com',
    fullName: 'Komal Shah',
    role: UserRole.customer,
    rating: 4.5,
  );

  static const tailor = MockUser(
    email: 'tailor@gmail.com',
    fullName: 'Nida Hussain',
    role: UserRole.tailor,
    rating: 4,
  );

  static const shopkeeper = MockUser(
    email: 'shopkeeper@gmail.com',
    fullName: 'Ahmed Khan',
    role: UserRole.shopkeeper,
    rating: 4.5,
  );
}
