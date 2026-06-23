import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/auth/auth_session.dart';
import '../../../../core/enums/user_role.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/models/mock_user.dart';
import '../../../../shared/models/selected_image.dart';
import '../../../../shared/models/user_account_profile.dart';
import '../../../../shared/services/photo_picker_service.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_drawer.dart';
import '../../../../shared/widgets/app_header_bar.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../shared/widgets/customer_bottom_nav_bar.dart';

class AccountProfileScreen extends StatefulWidget {
  const AccountProfileScreen({
    super.key,
    required this.role,
    required this.searchRoute,
    required this.navIndex,
    required this.onNavTap,
  });

  final UserRole role;
  final String searchRoute;
  final int navIndex;
  final ValueChanged<int> onNavTap;

  @override
  State<AccountProfileScreen> createState() => _AccountProfileScreenState();
}

class _AccountProfileScreenState extends State<AccountProfileScreen> {
  late UserAccountProfile _profile;
  SelectedImage? _localAvatar;
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _cityController;
  late TextEditingController _businessController;
  late TextEditingController _specialtyController;
  late TextEditingController _experienceController;

  MockUser get _user {
    final current = AuthSession.currentUser;
    if (current != null && current.role == widget.role) return current;
    return switch (widget.role) {
      UserRole.customer => MockUser.customer,
      UserRole.tailor => MockUser.tailor,
      UserRole.shopkeeper => MockUser.shopkeeper,
    };
  }

  @override
  void initState() {
    super.initState();
    _profile = UserAccountProfile.fromUser(_user);
    _nameController = TextEditingController(text: _profile.fullName);
    _phoneController = TextEditingController(text: _profile.phone);
    _addressController = TextEditingController(text: _profile.address);
    _cityController = TextEditingController(text: _profile.city ?? '');
    _businessController =
        TextEditingController(text: _profile.businessName ?? '');
    _specialtyController = TextEditingController(text: _profile.specialty ?? '');
    _experienceController = TextEditingController(
      text: _profile.experienceYears?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _businessController.dispose();
    _specialtyController.dispose();
    _experienceController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    setState(() {
      _profile = _profile.copyWith(
        fullName: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        address: _addressController.text.trim(),
        city: _cityController.text.trim(),
        businessName: _businessController.text.trim(),
        specialty: _specialtyController.text.trim(),
        experienceYears: int.tryParse(_experienceController.text.trim()),
      );
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully')),
    );
  }

  Future<void> _changePhoto() async {
    final image = await PhotoPickerService.showPickerSheet(context);
    if (image == null || !mounted) return;
    setState(() => _localAvatar = image);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile photo updated')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: SmartStitchDrawer(user: _user),
      appBar: AppHeaderBar(
        showDrawerButton: true,
        onSearchTap: () => context.push(widget.searchRoute),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, color: AppColors.divider),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('My Profile', style: AppTypography.titleLarge),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Manage your account details. Verified fields cannot be changed.',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Center(
              child: GestureDetector(
                onTap: _changePhoto,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 52,
                      backgroundColor: AppColors.primaryLight,
                      backgroundImage: _localAvatar != null
                          ? MemoryImage(_localAvatar!.bytes)
                          : _profile.avatarUrl != null
                              ? NetworkImage(_profile.avatarUrl!)
                              : null,
                      child: _localAvatar == null &&
                              _profile.avatarUrl == null
                          ? Icon(
                              Icons.person_rounded,
                              size: 52,
                              color: AppColors.textSecondary,
                            )
                          : null,
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.background,
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.camera_alt_rounded,
                          size: 16,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Center(
              child: Text(
                'Tap to change profile photo',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            AppTextField(
              label: 'Full Name',
              controller: _nameController,
              hint: 'Enter your full name',
            ),
            const SizedBox(height: AppSpacing.md),
            _ReadOnlyField(
              label: 'Email',
              value: _profile.email,
              helper: 'Email cannot be changed after registration',
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              label: 'Phone Number',
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              hint: '+92 300 0000000',
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              label: widget.role == UserRole.shopkeeper
                  ? 'Shop Address'
                  : 'Address',
              controller: _addressController,
              maxLines: 2,
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              label: 'City',
              controller: _cityController,
            ),
            if (_profile.hasCnic) ...[
              const SizedBox(height: AppSpacing.md),
              _ReadOnlyField(
                label: 'CNIC',
                value: _profile.cnic!,
                helper: 'Verified at registration — contact support to update',
              ),
            ],
            if (widget.role == UserRole.shopkeeper) ...[
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                label: 'Business / Shop Name',
                controller: _businessController,
              ),
            ],
            if (widget.role == UserRole.tailor) ...[
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                label: 'Specialty',
                controller: _specialtyController,
                hint: 'e.g. Formal, Bridal, Ethnic Wear',
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                label: 'Years of Experience',
                controller: _experienceController,
                keyboardType: TextInputType.number,
              ),
            ],
            if (_profile.hasSecurityWallet) ...[
              const SizedBox(height: AppSpacing.xl),
              Text(
                'Account Verification',
                style: AppTypography.titleMedium.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              _ReadOnlyField(
                label: 'Registration Fee (Rs. 2,000)',
                value: _profile.registrationFeePaid ? 'Paid' : 'Pending',
              ),
              const SizedBox(height: AppSpacing.md),
              _ReadOnlyField(
                label: 'Security Wallet Balance',
                value:
                    'Rs. ${_profile.securityWalletBalance.toStringAsFixed(0)} / 10,000 target',
                helper:
                    '10% is deducted per order until Rs. 10,000 is reached',
              ),
              const SizedBox(height: AppSpacing.md),
              _ReadOnlyField(
                label: 'Account Status',
                value: _profile.accountStatus,
              ),
            ],
            if (widget.role == UserRole.customer) ...[
              const SizedBox(height: AppSpacing.xl),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  border: Border.all(color: AppColors.divider),
                ),
                child: Text(
                  'Keep your name, phone, and address accurate. These details '
                  'are used for order delivery, disputes, and official '
                  'SmartStitch records.',
                  style: AppTypography.bodySmall.copyWith(height: 1.45),
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.xl),
            AppButton(label: 'Save Changes', onPressed: _saveProfile),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
      bottomNavigationBar: CustomerBottomNavBar(
        currentIndex: widget.navIndex,
        onTap: widget.onNavTap,
      ),
    );
  }
}

class _ReadOnlyField extends StatelessWidget {
  const _ReadOnlyField({
    required this.label,
    required this.value,
    this.helper,
  });

  final String label;
  final String value;
  final String? helper;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label, style: AppTypography.labelLarge),
            const SizedBox(width: AppSpacing.xs),
            Icon(
              Icons.lock_outline_rounded,
              size: 14,
              color: AppColors.textHint,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: Border.all(color: AppColors.inputBorder),
          ),
          child: Text(
            value,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        if (helper != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            helper!,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textHint,
              height: 1.3,
            ),
          ),
        ],
      ],
    );
  }
}
