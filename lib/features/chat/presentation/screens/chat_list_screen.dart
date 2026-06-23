import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/auth/auth_session.dart';
import '../../../../core/enums/user_role.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/models/mock_chat.dart';
import '../../../../shared/models/mock_user.dart';
import '../../../../shared/widgets/app_drawer.dart';
import '../../../../shared/widgets/app_header_bar.dart';
import '../../../../shared/widgets/customer_bottom_nav_bar.dart';
import '../widgets/chat_thread_tile.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({
    super.key,
    required this.role,
    required this.searchRoute,
    required this.conversationRoutePrefix,
    required this.onNavTap,
  });

  final UserRole role;
  final String searchRoute;
  final String conversationRoutePrefix;
  final ValueChanged<int> onNavTap;

  MockUser get _user {
    final current = AuthSession.currentUser;
    if (current != null && current.role == role) return current;
    return switch (role) {
      UserRole.tailor => MockUser.tailor,
      UserRole.shopkeeper => MockUser.shopkeeper,
      UserRole.customer => MockUser.customer,
    };
  }

  String get _subtitle => switch (role) {
        UserRole.customer =>
          'Chat with tailors and shopkeepers you have active orders with.',
        UserRole.tailor => 'Chat with customers you are currently working with.',
        UserRole.shopkeeper =>
          'Chat with customers you are currently working with.',
      };

  @override
  Widget build(BuildContext context) {
    final threads = ChatThread.forRole(role);

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: SmartStitchDrawer(user: _user),
      appBar: AppHeaderBar(
        showDrawerButton: true,
        onSearchTap: () => context.push(searchRoute),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, color: AppColors.divider),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.sm,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Chat', style: AppTypography.titleLarge),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  _subtitle,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: threads.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: Text(
                        'No active conversations yet. Chats unlock when you '
                        'have an order in progress.',
                        textAlign: TextAlign.center,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ),
                  )
                : ListView.separated(
                    itemCount: threads.length,
                    separatorBuilder: (context, index) => const Divider(
                      height: 1,
                      indent: 88,
                      color: AppColors.divider,
                    ),
                    itemBuilder: (context, index) {
                      final thread = threads[index];
                      return ChatThreadTile(
                        thread: thread,
                        onTap: () => context.push(
                          '$conversationRoutePrefix/${thread.id}',
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: CustomerBottomNavBar(
        currentIndex: 1,
        onTap: onNavTap,
      ),
    );
  }
}
