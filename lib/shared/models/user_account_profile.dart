import '../../core/enums/user_role.dart';
import 'mock_user.dart';

class UserAccountProfile {
  const UserAccountProfile({
    required this.role,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.address,
    this.city,
    this.cnic,
    this.businessName,
    this.specialty,
    this.experienceYears,
    this.avatarUrl,
    this.registrationFeePaid = false,
    this.securityWalletBalance = 0,
    this.accountStatus = 'Active',
  });

  final UserRole role;
  final String fullName;
  final String email;
  final String phone;
  final String address;
  final String? city;
  final String? cnic;
  final String? businessName;
  final String? specialty;
  final int? experienceYears;
  final String? avatarUrl;
  final bool registrationFeePaid;
  final double securityWalletBalance;
  final String accountStatus;

  bool get hasCnic => cnic != null && cnic!.isNotEmpty;
  bool get hasBusinessFields =>
      role == UserRole.shopkeeper || role == UserRole.tailor;
  bool get hasSecurityWallet =>
      role == UserRole.tailor || role == UserRole.shopkeeper;

  UserAccountProfile copyWith({
    String? fullName,
    String? phone,
    String? address,
    String? city,
    String? businessName,
    String? specialty,
    int? experienceYears,
    String? avatarUrl,
  }) {
    return UserAccountProfile(
      role: role,
      fullName: fullName ?? this.fullName,
      email: email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      city: city ?? this.city,
      cnic: cnic,
      businessName: businessName ?? this.businessName,
      specialty: specialty ?? this.specialty,
      experienceYears: experienceYears ?? this.experienceYears,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      registrationFeePaid: registrationFeePaid,
      securityWalletBalance: securityWalletBalance,
      accountStatus: accountStatus,
    );
  }

  static UserAccountProfile fromUser(MockUser user) {
    return switch (user.role) {
      UserRole.customer => UserAccountProfile(
          role: user.role,
          fullName: user.fullName,
          email: user.email,
          phone: '+92 300 1234567',
          address: 'House 12, Block C, Johar Town',
          city: 'Lahore',
          avatarUrl:
              'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200',
        ),
      UserRole.tailor => UserAccountProfile(
          role: user.role,
          fullName: user.fullName,
          email: user.email,
          phone: '+92 321 9876543',
          address: 'Shop 4, Women\'s Tailors Market, Anarkali',
          city: 'Lahore',
          cnic: '35202-1234567-1',
          specialty: 'Bridal & Lawn Wear',
          experienceYears: 12,
          avatarUrl:
              'https://images.unsplash.com/photo-1583391733981-5c55a4f4f2c0?w=200',
          registrationFeePaid: true,
          securityWalletBalance: 4200,
        ),
      UserRole.shopkeeper => UserAccountProfile(
          role: user.role,
          fullName: user.fullName,
          email: user.email,
          phone: '+92 333 4455667',
          address: 'Fabric Street, Shah Alam Market',
          city: 'Lahore',
          cnic: '35201-7654321-9',
          businessName: 'Ahmed Fabrics & Lace House',
          avatarUrl:
              'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=200',
          registrationFeePaid: true,
          securityWalletBalance: 6800,
        ),
    };
  }
}
