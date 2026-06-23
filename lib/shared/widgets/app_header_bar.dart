import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import 'smart_stitch_logo.dart';

class HeaderSearchField extends StatelessWidget {
  const HeaderSearchField({
    super.key,
    this.onTap,
    this.autofocus = false,
    this.readOnly = true,
    this.onChanged,
    this.controller,
  });

  final VoidCallback? onTap;
  final bool autofocus;
  final bool readOnly;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    if (readOnly) {
      return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.inputFill,
            borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
            border: Border.all(color: AppColors.inputBorder),
          ),
          child: Row(
            children: [
              Icon(
                Icons.search_rounded,
                size: 20,
                color: AppColors.textHint,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Search',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textHint,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
        border: Border.all(color: AppColors.inputBorder),
      ),
      child: TextField(
        controller: controller,
        autofocus: autofocus,
        onChanged: onChanged,
        style: AppTypography.bodyMedium,
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: AppTypography.bodyMedium.copyWith(
            color: AppColors.textHint,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            size: 20,
            color: AppColors.textHint,
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 40,
            minHeight: 40,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: AppSpacing.sm,
          ),
          isDense: true,
        ),
      ),
    );
  }
}

class AppHeaderBar extends StatelessWidget implements PreferredSizeWidget {
  const AppHeaderBar({
    super.key,
    this.leading,
    this.onSearchTap,
    this.showDrawerButton = false,
    this.showLogo = true,
    this.searchReadOnly = true,
    this.bottom,
  });

  final Widget? leading;
  final VoidCallback? onSearchTap;
  final bool showDrawerButton;
  final bool showLogo;
  final bool searchReadOnly;
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0),
      );

  @override
  Widget build(BuildContext context) {
    Widget? resolvedLeading = leading;

    if (resolvedLeading == null && showDrawerButton) {
      resolvedLeading = Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu_rounded),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      );
    }

    return AppBar(
      leading: resolvedLeading,
      automaticallyImplyLeading: false,
      title: HeaderSearchField(
        readOnly: searchReadOnly,
        onTap: onSearchTap,
        autofocus: !searchReadOnly,
      ),
      centerTitle: true,
      titleSpacing: AppSpacing.sm,
      backgroundColor: AppColors.background,
      elevation: 0,
      scrolledUnderElevation: 0,
      actions: [
        if (showLogo)
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: Center(
              child: SmartStitchLogo(
                variant: SmartStitchLogoVariant.iconOnly,
                height: 32,
                maxWidth: 32,
              ),
            ),
          ),
      ],
      bottom: bottom,
    );
  }
}
