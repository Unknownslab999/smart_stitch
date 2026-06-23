import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/models/mock_chat.dart';
import '../../../../shared/widgets/app_image.dart';

class ChatThreadTile extends StatelessWidget {
  const ChatThreadTile({
    super.key,
    required this.thread,
    required this.onTap,
  });

  final ChatThread thread;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: AppImage(
                  source: thread.participantAvatarUrl,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            thread.participantName,
                            style: AppTypography.titleMedium.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Text(
                          thread.lastMessageTime,
                          style: AppTypography.bodySmall.copyWith(
                            color: thread.hasUnread
                                ? AppColors.primaryDark
                                : AppColors.textHint,
                            fontWeight: thread.hasUnread
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    if (thread.orderLabel != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        thread.orderLabel!,
                        style: AppTypography.labelMedium.copyWith(
                          color: AppColors.primaryDark,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      thread.lastMessage,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.bodySmall.copyWith(
                        color: thread.hasUnread
                            ? AppColors.textPrimary
                            : AppColors.textSecondary,
                        fontWeight:
                            thread.hasUnread ? FontWeight.w500 : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              if (thread.hasUnread) ...[
                const SizedBox(width: AppSpacing.sm),
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
