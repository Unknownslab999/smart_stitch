import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/models/mock_chat.dart';

class ChatConversationAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ChatConversationAppBar({
    super.key,
    required this.thread,
    this.onCall,
    this.onMore,
  });

  final ChatThread thread;
  final VoidCallback? onCall;
  final VoidCallback? onMore;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
        onPressed: () => Navigator.of(context).maybePop(),
      ),
      titleSpacing: 0,
      title: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(thread.participantAvatarUrl),
            onBackgroundImageError: (_, _) {},
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              thread.participantName,
              style: AppTypography.titleMedium.copyWith(
                fontWeight: FontWeight.w700,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: onCall,
          icon: const Icon(Icons.phone_outlined),
          color: AppColors.textPrimary,
        ),
        IconButton(
          onPressed: onMore,
          icon: const Icon(Icons.more_vert_rounded),
          color: AppColors.textPrimary,
        ),
      ],
    );
  }
}
