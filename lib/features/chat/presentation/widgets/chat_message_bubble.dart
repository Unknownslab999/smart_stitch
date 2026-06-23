import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/models/mock_chat.dart';
import '../../../../shared/widgets/app_image.dart';

class ChatDateDivider extends StatelessWidget {
  const ChatDateDivider({super.key, this.label = 'TODAY'});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
          ),
          child: Text(
            label,
            style: AppTypography.labelMedium.copyWith(
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}

class ChatMessageBubble extends StatelessWidget {
  const ChatMessageBubble({
    super.key,
    required this.message,
  });

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final alignment =
        message.isOutgoing ? Alignment.centerRight : Alignment.centerLeft;

    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.78,
        ),
        child: Column(
          crossAxisAlignment: message.isOutgoing
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            _BubbleContent(message: message),
            const SizedBox(height: 4),
            Text(
              message.time,
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.textHint,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BubbleContent extends StatelessWidget {
  const _BubbleContent({required this.message});

  final ChatMessage message;

  Color get _backgroundColor => message.isOutgoing
      ? AppColors.primary
      : AppColors.surface;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(AppSpacing.radiusMd),
          topRight: const Radius.circular(AppSpacing.radiusMd),
          bottomLeft: Radius.circular(
            message.isOutgoing ? AppSpacing.radiusMd : AppSpacing.radiusSm,
          ),
          bottomRight: Radius.circular(
            message.isOutgoing ? AppSpacing.radiusSm : AppSpacing.radiusMd,
          ),
        ),
        border: message.isOutgoing
            ? null
            : Border.all(color: AppColors.divider),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(AppSpacing.radiusMd),
          topRight: const Radius.circular(AppSpacing.radiusMd),
          bottomLeft: Radius.circular(
            message.isOutgoing ? AppSpacing.radiusMd : AppSpacing.radiusSm,
          ),
          bottomRight: Radius.circular(
            message.isOutgoing ? AppSpacing.radiusSm : AppSpacing.radiusMd,
          ),
        ),
        child: switch (message.type) {
          ChatMessageType.text => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm + 2,
              ),
              child: Text(
                message.text ?? '',
                style: AppTypography.bodyMedium.copyWith(
                  height: 1.45,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ChatMessageType.image => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AspectRatio(
                  aspectRatio: 4 / 3,
                  child: _ChatImage(message: message),
                ),
                if (message.caption != null && message.caption!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Text(
                      message.caption!,
                      style: AppTypography.bodySmall.copyWith(
                        height: 1.4,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
              ],
            ),
          ChatMessageType.voice => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.md,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Row(
                      children: List.generate(
                        18,
                        (index) => Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 1),
                            height: 8 + (index % 4) * 4.0,
                            decoration: BoxDecoration(
                              color: AppColors.textSecondary.withValues(
                                alpha: 0.35 + (index % 3) * 0.15,
                              ),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    message.voiceDuration ?? '0:00',
                    style: AppTypography.bodySmall.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
        },
      ),
    );
  }
}

class _ChatImage extends StatelessWidget {
  const _ChatImage({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    if (message.localImageBytes != null) {
      return Image.memory(
        message.localImageBytes!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          color: AppColors.primaryLight,
          child: const Icon(Icons.image_outlined),
        ),
      );
    }

    return AppImage(
      source: message.imageUrl ?? '',
      fit: BoxFit.cover,
      errorIcon: Icons.image_outlined,
    );
  }
}
