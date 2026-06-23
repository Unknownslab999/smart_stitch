import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/models/selected_image.dart';
import '../../../../shared/services/photo_picker_service.dart';
import '../../../../shared/widgets/picked_image_widget.dart';

class SizeChartSection extends StatefulWidget {
  const SizeChartSection({super.key});

  @override
  State<SizeChartSection> createState() => _SizeChartSectionState();
}

class _SizeChartSectionState extends State<SizeChartSection> {
  static const _headers = ['', 'Length', 'Waist', 'Shoulders', 'Sleeve/L'];

  late final List<TextEditingController> _shirtControllers;
  late final List<TextEditingController> _trouserControllers;
  SelectedImage? _referencePhoto;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _shirtControllers = [
      TextEditingController(text: '47'),
      TextEditingController(text: '19'),
      TextEditingController(text: '19'),
      TextEditingController(text: '10'),
    ];
    _trouserControllers = [
      TextEditingController(text: '47'),
      TextEditingController(text: '19'),
      TextEditingController(text: '19'),
      TextEditingController(text: '10'),
    ];
  }

  @override
  void dispose() {
    for (final controller in [..._shirtControllers, ..._trouserControllers]) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _pickReferencePhoto() async {
    final image = await PhotoPickerService.showPickerSheet(context);
    if (image == null || !mounted) return;
    setState(() => _referencePhoto = image);
  }

  void _saveMeasurements() {
    setState(() => _isEditing = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _referencePhoto != null
              ? 'Measurements and reference photo saved'
              : 'Measurements saved',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Size Chart', style: AppTypography.titleLarge),
        const SizedBox(height: AppSpacing.md),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.primaryLight.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            border: Border.all(color: AppColors.inputBorder),
          ),
          child: Column(
            children: [
              _MeasurementTable(
                label: 'Shirt',
                headers: _headers,
                controllers: _shirtControllers,
                isEditing: _isEditing,
              ),
              const SizedBox(height: AppSpacing.md),
              _MeasurementTable(
                label: 'Trouser',
                headers: _headers,
                controllers: _trouserControllers,
                isEditing: _isEditing,
                lastColumnLabel: 'Poecha',
              ),
              const SizedBox(height: AppSpacing.md),
              if (_referencePhoto != null) ...[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Reference Photo',
                    style: AppTypography.labelLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusMd),
                      child: PickedImageWidget(
                        image: _referencePhoto!,
                        height: 140,
                        width: double.infinity,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Material(
                        color: AppColors.surface,
                        shape: const CircleBorder(),
                        child: InkWell(
                          onTap: () =>
                              setState(() => _referencePhoto = null),
                          customBorder: const CircleBorder(),
                          child: const Padding(
                            padding: EdgeInsets.all(6),
                            child: Icon(Icons.close_rounded, size: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
              ],
              SizedBox(
                height: 44,
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _pickReferencePhoto,
                  icon: const Icon(Icons.add_photo_alternate_outlined, size: 18),
                  label: Text(
                    _referencePhoto == null
                        ? 'Attach Measurement Photo'
                        : 'Change Reference Photo',
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textPrimary,
                    side: const BorderSide(color: AppColors.inputBorder),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusPill),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              SizedBox(
                height: 44,
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    if (_isEditing) {
                      _saveMeasurements();
                    } else {
                      setState(() => _isEditing = true);
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.textOnPrimary,
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusPill),
                    ),
                  ),
                  child: Text(
                    _isEditing ? 'Save Measurements' : 'Edit Measurements',
                    style: AppTypography.labelLarge.copyWith(
                      color: AppColors.textOnPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MeasurementTable extends StatelessWidget {
  const _MeasurementTable({
    required this.label,
    required this.headers,
    required this.controllers,
    required this.isEditing,
    this.lastColumnLabel,
  });

  final String label;
  final List<String> headers;
  final List<TextEditingController> controllers;
  final bool isEditing;
  final String? lastColumnLabel;

  @override
  Widget build(BuildContext context) {
    final displayHeaders = List<String>.from(headers);
    if (lastColumnLabel != null && displayHeaders.isNotEmpty) {
      displayHeaders[displayHeaders.length - 1] = lastColumnLabel!;
    }

    return Table(
      border: TableBorder.all(color: AppColors.inputBorder),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.8),
          ),
          children: displayHeaders
              .map(
                (header) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.sm,
                  ),
                  child: Text(
                    header,
                    style: AppTypography.bodySmall.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
              .toList(),
        ),
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.sm,
              ),
              child: Text(
                label,
                style: AppTypography.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            ...List.generate(controllers.length, (index) {
              final controller = controllers[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xs,
                  vertical: AppSpacing.xs,
                ),
                child: isEditing
                    ? TextField(
                        controller: controller,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9.]'),
                          ),
                        ],
                        style: AppTypography.bodySmall,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 8,
                          ),
                          filled: true,
                          fillColor: AppColors.surface,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: AppColors.inputBorder),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: AppSpacing.sm,
                        ),
                        child: Text(
                          controller.text,
                          style: AppTypography.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
              );
            }),
          ],
        ),
      ],
    );
  }
}
