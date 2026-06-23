import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/models/selected_image.dart';
import '../../../../shared/services/photo_picker_service.dart';
import '../../../../shared/widgets/ai_prompt_chip.dart';
import '../../../../shared/widgets/picked_image_widget.dart';

class _AiMessage {
  const _AiMessage({
    required this.isUser,
    required this.text,
    this.imageBytes,
  });

  final bool isUser;
  final String text;
  final Uint8List? imageBytes;
}

class AiAssistantScreen extends StatefulWidget {
  const AiAssistantScreen({super.key});

  @override
  State<AiAssistantScreen> createState() => _AiAssistantScreenState();
}

class _AiAssistantScreenState extends State<AiAssistantScreen> {
  static const _suggestedPrompts = [
    'Suggest a trendy neckline design',
    'How do I style a short frock with palazzos?',
    'Quality and neatness checklist for my tailor',
  ];

  final _messageController = TextEditingController();
  final List<_AiMessage> _messages = [];
  SelectedImage? _pendingImage;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  Future<void> _attachImage() async {
    final image = await PhotoPickerService.showPickerSheet(context);
    if (image == null || !mounted) return;
    setState(() => _pendingImage = image);
  }

  void _sendMessage([String? preset]) {
    final text = (preset ?? _messageController.text).trim();
    final hasImage = _pendingImage != null;
    if (text.isEmpty && !hasImage) return;

    final imageBytes = _pendingImage?.bytes;
    setState(() {
      _messages.add(
        _AiMessage(
          isUser: true,
          text: text.isEmpty
              ? 'Shared a reference image for styling advice.'
              : text,
          imageBytes: imageBytes,
        ),
      );
      _messages.add(
        _AiMessage(
          isUser: false,
          text: hasImage
              ? 'Thanks for the image! I can see the design reference. '
                  'For a polished look, consider pairing structured shoulders '
                  'with a softer drape at the waist. Would you like fabric '
                  'or neckline suggestions next?'
              : 'Great question. I\'ll tailor my advice to your style '
                  'preferences — share a photo anytime for more specific tips.',
        ),
      );
      _messageController.clear();
      _pendingImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.pop(),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.auto_awesome_rounded,
              color: AppColors.primary,
              size: 22,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text('SmartStitch AI', style: AppTypography.titleLarge),
          ],
        ),
        centerTitle: true,
        backgroundColor: AppColors.background,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                if (_messages.isEmpty) ...[
                  Text(
                    '${_getGreeting()}, Komal.',
                    style: AppTypography.headlineMedium,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  ..._suggestedPrompts.map(
                    (prompt) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: AiPromptChip(
                        text: prompt,
                        onTap: () => _sendMessage(prompt),
                      ),
                    ),
                  ),
                ] else
                  ..._messages.map(
                    (message) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: _AiMessageBubble(message: message),
                    ),
                  ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: AppSpacing.lg,
              right: AppSpacing.lg,
              top: AppSpacing.md,
              bottom: MediaQuery.of(context).padding.bottom + AppSpacing.md,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface,
              boxShadow: [
                BoxShadow(
                  color: AppColors.cardShadow,
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_pendingImage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: PickedImagePreviewChip(
                      image: _pendingImage!,
                      onRemove: () => setState(() => _pendingImage = null),
                    ),
                  ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: _pendingImage != null
                              ? 'Ask about this image...'
                              : 'Message',
                          hintStyle: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textHint,
                          ),
                          filled: true,
                          fillColor: AppColors.inputFill,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.md,
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(AppSpacing.radiusPill),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Material(
                      color: AppColors.primary,
                      shape: const CircleBorder(),
                      child: InkWell(
                        onTap: _attachImage,
                        customBorder: const CircleBorder(),
                        child: const SizedBox(
                          width: 44,
                          height: 44,
                          child: Icon(
                            Icons.add_rounded,
                            color: AppColors.textOnPrimary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    IconButton(
                      onPressed: () => _sendMessage(),
                      icon: const Icon(Icons.send_rounded),
                      color: AppColors.textPrimary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AiMessageBubble extends StatelessWidget {
  const _AiMessageBubble({required this.message});

  final _AiMessage message;

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.82,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: isUser ? AppColors.primary : AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: isUser ? null : Border.all(color: AppColors.divider),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (message.imageBytes != null) ...[
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusSm),
                    child: Image.memory(
                      message.imageBytes!,
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                ],
                Text(
                  message.text,
                  style: AppTypography.bodyMedium.copyWith(height: 1.45),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
