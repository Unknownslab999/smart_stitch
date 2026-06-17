enum UserRole {
  customer('Customer'),
  tailor('Tailor'),
  shopkeeper('Shopkeeper');

  const UserRole(this.label);
  final String label;

  static UserRole fromLabel(String label) {
    return UserRole.values.firstWhere(
      (role) => role.label.toLowerCase() == label.toLowerCase(),
      orElse: () => UserRole.customer,
    );
  }
}
