import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import 'app_button.dart';

class PriceQuoteSheet extends StatefulWidget {
  const PriceQuoteSheet({
    super.key,
    required this.title,
    required this.subtitle,
    this.confirmLabel = 'Submit',
    this.initialValue = 5000,
  });

  final String title;
  final String subtitle;
  final String confirmLabel;
  final int initialValue;

  static const minAmount = 500;
  static const maxAmount = 100000;

  static Future<int?> show(
    BuildContext context, {
    required String title,
    required String subtitle,
    String confirmLabel = 'Submit',
    int initialValue = 5000,
  }) {
    return showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => PriceQuoteSheet(
        title: title,
        subtitle: subtitle,
        confirmLabel: confirmLabel,
        initialValue: initialValue,
      ),
    );
  }

  static String formatAmount(int amount) {
    final digits = amount.toString();
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(digits[i]);
    }
    return 'Rs. $buffer';
  }

  @override
  State<PriceQuoteSheet> createState() => _PriceQuoteSheetState();
}

class _PriceQuoteSheetState extends State<PriceQuoteSheet> {
  static const _rangeSpan = PriceQuoteSheet.maxAmount - PriceQuoteSheet.minAmount;

  late int _amount;
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _amount = widget.initialValue.clamp(
      PriceQuoteSheet.minAmount,
      PriceQuoteSheet.maxAmount,
    );
    _controller = TextEditingController(text: _amount.toString());
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  double get _sliderValue {
    return (_amount - PriceQuoteSheet.minAmount) / _rangeSpan;
  }

  void _setAmount(int value) {
    final clamped = value.clamp(
      PriceQuoteSheet.minAmount,
      PriceQuoteSheet.maxAmount,
    );
    setState(() => _amount = clamped);
    _controller.value = TextEditingValue(
      text: clamped.toString(),
      selection: TextSelection.collapsed(offset: clamped.toString().length),
    );
  }

  void _onSliderChanged(double value) {
    final raw = PriceQuoteSheet.minAmount + (value * _rangeSpan).round();
    final rounded = ((raw / 100).round() * 100).clamp(
      PriceQuoteSheet.minAmount,
      PriceQuoteSheet.maxAmount,
    );
    _setAmount(rounded);
  }

  void _onAmountSubmitted() {
    final parsed = int.tryParse(_controller.text.trim());
    if (parsed == null) {
      _setAmount(_amount);
      return;
    }
    _setAmount(parsed);
  }

  void _onAmountChanged(String value) {
    if (value.isEmpty) return;
    final parsed = int.tryParse(value);
    if (parsed == null) return;
    if (parsed >= PriceQuoteSheet.minAmount &&
        parsed <= PriceQuoteSheet.maxAmount) {
      setState(() => _amount = parsed);
    }
  }

  void _submit() {
    _onAmountSubmitted();
    Navigator.of(context).pop(_amount);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.lg,
          MediaQuery.paddingOf(context).bottom + AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.divider,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(widget.title, style: AppTypography.titleLarge),
            const SizedBox(height: AppSpacing.xs),
            Text(
              widget.subtitle,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              PriceQuoteSheet.formatAmount(_amount),
              textAlign: TextAlign.center,
              style: AppTypography.headlineMedium.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.primaryDark,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: AppColors.primary,
                inactiveTrackColor: AppColors.primaryLight,
                thumbColor: AppColors.primaryDark,
                overlayColor: AppColors.primary.withValues(alpha: 0.12),
              ),
              child: Slider(
                value: _sliderValue,
                onChanged: _onSliderChanged,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  PriceQuoteSheet.formatAmount(PriceQuoteSheet.minAmount),
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textHint,
                  ),
                ),
                Text(
                  PriceQuoteSheet.formatAmount(PriceQuoteSheet.maxAmount),
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textHint,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Or enter amount', style: AppTypography.labelLarge),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: _controller,
              focusNode: _focusNode,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                prefixText: 'Rs. ',
                hintText: '5000',
                filled: true,
                fillColor: AppColors.inputFill,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
              ),
              onSubmitted: (_) => _onAmountSubmitted(),
              onEditingComplete: _onAmountSubmitted,
              onChanged: _onAmountChanged,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Range: ${PriceQuoteSheet.formatAmount(PriceQuoteSheet.minAmount)} '
              '– ${PriceQuoteSheet.formatAmount(PriceQuoteSheet.maxAmount)}',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textHint,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            AppButton(label: widget.confirmLabel, onPressed: _submit),
            const SizedBox(height: AppSpacing.sm),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: AppTypography.labelLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
