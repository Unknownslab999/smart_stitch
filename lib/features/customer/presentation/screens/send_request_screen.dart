import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/auth/auth_session.dart';
import '../../../../core/enums/provider_type.dart';
import '../../../../core/enums/request_type.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/routing/send_request_args.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/models/mock_selectable_provider.dart';
import '../../../../shared/models/mock_shop.dart';
import '../../../../shared/models/mock_tailor.dart';
import '../../../../shared/models/mock_user.dart';
import '../../../../shared/models/provider_profile.dart';
import '../../../../shared/services/request_recipient_service.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_header_bar.dart';
import '../../../../shared/widgets/app_drawer.dart';
import '../../../../shared/widgets/customer_bottom_nav_bar.dart';
import '../utils/customer_navigation.dart';
import '../widgets/file_upload_section.dart';
import '../widgets/provider_profile_header.dart';
import '../widgets/provider_selector_row.dart';
import '../widgets/request_status_overlay.dart';
import '../widgets/size_chart_section.dart';

class SendRequestScreen extends StatefulWidget {
  const SendRequestScreen({super.key, this.args});

  final SendRequestArgs? args;

  @override
  State<SendRequestScreen> createState() => _SendRequestScreenState();
}

class _SendRequestScreenState extends State<SendRequestScreen> {
  late RequestType _requestType;
  String? _selectedProviderId;
  String? _fileName;
  final _descriptionController = TextEditingController();

  bool get _isPersonal => widget.args?.isPersonal ?? false;

  bool get _isBroadcast => !_isPersonal && _selectedProviderId == null;

  List<MockSelectableProvider> get _providers {
    return switch (_requestType) {
      RequestType.tailoring => MockTailor.sampleData
          .asMap()
          .entries
          .map(
            (entry) => MockSelectableProvider(
              id: entry.value.id,
              name: entry.value.name,
              rating: entry.value.meritScore,
              avatarColor: entry.key.isOdd
                  ? const Color(0xFFC5A88E)
                  : const Color(0xFFE8D5C4),
            ),
          )
          .toList(),
      RequestType.material => MockShop.sampleData
          .asMap()
          .entries
          .map(
            (entry) => MockSelectableProvider(
              id: entry.value.id,
              name: entry.value.name,
              rating: entry.value.meritScore,
              avatarColor: entry.key.isOdd
                  ? const Color(0xFFC5A88E)
                  : const Color(0xFFE8D5C4),
            ),
          )
          .toList(),
    };
  }

  String get _providerLabel => switch (_requestType) {
        RequestType.tailoring => 'Tailors',
        RequestType.material => 'Shopkeepers',
      };

  @override
  void initState() {
    super.initState();
    _requestType = widget.args?.requestType ?? RequestType.tailoring;
    _selectedProviderId = widget.args?.providerId;
  }

  String? get _selectedProviderName {
    if (_selectedProviderId == null) return null;
    for (final provider in _providers) {
      if (provider.id == _selectedProviderId) return provider.name;
    }
    return null;
  }

  double get _personalRating {
    final profile = ProviderProfile.findById(
      switch (_requestType) {
        RequestType.tailoring => ProviderType.tailor,
        RequestType.material => ProviderType.shopkeeper,
      },
      _selectedProviderId ?? '',
    );
    return profile?.rating ?? 4;
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _onRequestTypeChanged(RequestType type) {
    if (_isPersonal) return;
    setState(() {
      _requestType = type;
      _selectedProviderId = null;
    });
  }

  void _mockUpload() {
    setState(() {
      _fileName = 'design_sketch.png';
    });
  }

  Future<void> _sendRequest() async {
    if (_isPersonal && _selectedProviderId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to send personal request')),
      );
      return;
    }

    await RequestStatusOverlay.show(context);
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthSession.currentUser ?? MockUser.customer;

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: SmartStitchDrawer(user: user),
      appBar: AppHeaderBar(
        showDrawerButton: !_isPersonal,
        leading: _isPersonal
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () => context.pop(),
              )
            : null,
        onSearchTap: () => context.push(RouteNames.customerSearch),
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
            if (_isPersonal && widget.args?.providerName != null) ...[
              SelectedProviderBanner(
                name: widget.args!.providerName!,
                roleLabel: _requestType.label,
                imageUrl: widget.args!.providerImageUrl ?? '',
                rating: _personalRating,
              ),
              const SizedBox(height: AppSpacing.lg),
            ] else ...[
              _RequestTypeToggle(
                selected: _requestType,
                onChanged: _onRequestTypeChanged,
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
            FileUploadSection(
              fileName: _fileName,
              onUpload: _mockUpload,
            ),
            if (_requestType == RequestType.tailoring) ...[
              const SizedBox(height: AppSpacing.lg),
              const SizeChartSection(),
            ],
            const SizedBox(height: AppSpacing.lg),
            Text(
              _isPersonal ? 'Note Box' : 'Description',
              style: AppTypography.titleLarge,
            ),
            const SizedBox(height: AppSpacing.sm),
            TextFormField(
              controller: _descriptionController,
              maxLines: 4,
              style: AppTypography.bodyMedium,
              decoration: InputDecoration(
                hintText: 'Enter comments........',
                hintStyle: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textHint,
                ),
                filled: true,
                fillColor: AppColors.primaryLight.withValues(alpha: 0.35),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                  borderSide: const BorderSide(color: AppColors.inputBorder),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                  borderSide: const BorderSide(color: AppColors.inputBorder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
              ),
            ),
            if (!_isPersonal) ...[
              const SizedBox(height: AppSpacing.lg),
              _BroadcastInfoBanner(
                requestType: _requestType,
                isBroadcast: _isBroadcast,
                selectedName: _selectedProviderName,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                '$_providerLabel (optional)',
                style: AppTypography.titleLarge,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Tap someone to send only to them, or leave unselected to send to '
                '${RequestRecipientService.broadcastLabel(_requestType)}.',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textHint,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              ProviderSelectorRow(
                providers: _providers,
                selectedId: _selectedProviderId,
                onSelected: (id) => setState(() {
                  _selectedProviderId =
                      _selectedProviderId == id ? null : id;
                }),
                onSearch: () => context.push(RouteNames.customerSearch),
              ),
            ],
            const SizedBox(height: AppSpacing.xl),
            AppButton(
              label: 'Send Request',
              onPressed: _sendRequest,
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
      bottomNavigationBar: CustomerBottomNavBar(
        currentIndex: 0,
        onTap: (index) => handleCustomerNavTap(context, index),
      ),
    );
  }
}

class _BroadcastInfoBanner extends StatelessWidget {
  const _BroadcastInfoBanner({
    required this.requestType,
    required this.isBroadcast,
    this.selectedName,
  });

  final RequestType requestType;
  final bool isBroadcast;
  final String? selectedName;

  @override
  Widget build(BuildContext context) {
    final message = isBroadcast
        ? 'This request will be sent to '
            '${RequestRecipientService.broadcastLabel(requestType)} '
            '(${requestType == RequestType.tailoring ? MockTailor.sampleData.length : MockShop.sampleData.length} recipients).'
        : 'This request will be sent only to $selectedName.';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isBroadcast ? Icons.groups_rounded : Icons.person_rounded,
            color: AppColors.primaryDark,
            size: 22,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              message,
              style: AppTypography.bodySmall.copyWith(
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RequestTypeToggle extends StatelessWidget {
  const _RequestTypeToggle({
    required this.selected,
    required this.onChanged,
  });

  final RequestType selected;
  final ValueChanged<RequestType> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
      ),
      child: Row(
        children: RequestType.values.map((type) {
          final isSelected = selected == type;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(type),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
                ),
                child: Text(
                  type.label,
                  textAlign: TextAlign.center,
                  style: AppTypography.labelLarge.copyWith(
                    color: isSelected
                        ? AppColors.textOnPrimary
                        : AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
