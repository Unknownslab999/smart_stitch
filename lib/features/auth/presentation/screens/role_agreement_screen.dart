import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/enums/user_role.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../data/role_agreement_content.dart';
import '../../../../shared/widgets/app_button.dart';

class RoleAgreementScreen extends StatelessWidget {
  const RoleAgreementScreen({
    super.key,
    required this.role,
    this.previewOnly = false,
  });

  final UserRole role;
  final bool previewOnly;

  RoleAgreementContent get _content => RoleAgreementContent.forRole(role);

  void _onAgree(BuildContext context) {
    final destination = switch (role) {
      UserRole.customer => RouteNames.customerHome,
      UserRole.tailor => RouteNames.tailorHome,
      UserRole.shopkeeper => RouteNames.shopkeeperHome,
    };
    context.go(destination);
  }

  @override
  Widget build(BuildContext context) {
    final content = _content;
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.pop(),
        ),
        title: Text(
          previewOnly ? 'Agreement' : 'Review Agreement',
          style: AppTypography.titleLarge,
        ),
        backgroundColor: AppColors.background,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.sm,
                AppSpacing.lg,
                AppSpacing.lg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    content.title,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryDark,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    content.intro,
                    style: AppTypography.bodyMedium.copyWith(
                      height: 1.5,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  ...content.clauses.map(
                    (clause) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: _AgreementClauseTile(clause: clause),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    content.acceptanceText,
                    style: AppTypography.bodyMedium.copyWith(
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!previewOnly)
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.sm,
                AppSpacing.lg,
                bottomPadding + AppSpacing.lg,
              ),
              child: AppButton(
                label: 'I Agree',
                onPressed: () => _onAgree(context),
              ),
            ),
        ],
      ),
    );
  }
}

class _AgreementClauseTile extends StatelessWidget {
  const _AgreementClauseTile({required this.clause});

  final AgreementClause clause;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, right: AppSpacing.sm),
          child: Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: AppColors.textPrimary,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: AppTypography.bodyMedium.copyWith(
                    height: 1.5,
                    color: AppColors.textPrimary,
                  ),
                  children: [
                    if (clause.label != null)
                      TextSpan(
                        text: '${clause.label}: ',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    TextSpan(text: clause.body),
                  ],
                ),
              ),
              if (clause.subPoints.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.sm),
                ...clause.subPoints.map(
                  (point) => Padding(
                    padding: const EdgeInsets.only(
                      left: AppSpacing.md,
                      bottom: AppSpacing.xs,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '• ',
                          style: AppTypography.bodyMedium.copyWith(
                            height: 1.45,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            point,
                            style: AppTypography.bodyMedium.copyWith(
                              height: 1.45,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
