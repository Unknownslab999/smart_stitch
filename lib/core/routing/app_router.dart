import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/ai/presentation/screens/ai_assistant_screen.dart';
import '../../features/auth/presentation/screens/create_account_screen.dart';
import '../../features/auth/presentation/screens/role_agreement_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/chat/presentation/screens/chat_conversation_screen.dart';
import '../../features/chat/presentation/screens/chat_list_screen.dart';
import '../../features/customer/presentation/screens/customer_orders_screen.dart';
import '../../features/customer/presentation/screens/customer_placeholder_screen.dart';
import '../../features/customer/presentation/screens/provider_profile_screen.dart';
import '../../features/customer/presentation/screens/send_request_screen.dart';
import '../../core/routing/send_request_args.dart';
import '../../core/enums/provider_type.dart';
import '../../features/customer/presentation/utils/customer_navigation.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/shopkeeper/presentation/screens/shopkeeper_home_screen.dart';
import '../../features/shopkeeper/presentation/screens/shopkeeper_placeholder_screen.dart';
import '../../features/shopkeeper/presentation/screens/shopkeeper_profile_screen.dart';
import '../../features/shopkeeper/presentation/utils/shopkeeper_navigation.dart';
import '../../features/tailor/presentation/screens/tailor_home_screen.dart';
import '../../features/tailor/presentation/screens/tailor_placeholder_screen.dart';
import '../../features/tailor/presentation/screens/tailor_profile_screen.dart';
import '../../features/provider_orders/presentation/screens/provider_orders_screen.dart';
import '../../core/enums/user_role.dart';
import '../../features/tailor/presentation/utils/tailor_navigation.dart';
import 'route_names.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.splash,
    routes: [
      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteNames.createAccount,
        builder: (context, state) => const CreateAccountScreen(),
        routes: [
          GoRoute(
            path: 'agreement',
            builder: (context, state) {
              final extra = state.extra;
              final previewOnly = extra is Map &&
                  (extra['previewOnly'] as bool? ?? false);
              final role = extra is UserRole
                  ? extra
                  : extra is Map
                      ? extra['role'] as UserRole?
                      : null;
              return RoleAgreementScreen(
                role: role ?? UserRole.tailor,
                previewOnly: previewOnly,
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: RouteNames.customerHome,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: RouteNames.customerSearch,
        builder: (context, state) => CustomerPlaceholderScreen(
          title: 'Search',
          navIndex: 0,
          onNavTap: (index) => _onCustomerNavTap(context, index),
          showBottomNav: false,
          showBackButton: true,
        ),
      ),
      GoRoute(
        path: RouteNames.customerChat,
        routes: [
          GoRoute(
            path: ':threadId',
            builder: (context, state) => ChatConversationScreen(
              threadId: state.pathParameters['threadId']!,
            ),
          ),
        ],
        builder: (context, state) => ChatListScreen(
          role: UserRole.customer,
          searchRoute: RouteNames.customerSearch,
          conversationRoutePrefix: RouteNames.customerChat,
          onNavTap: (index) => _onCustomerNavTap(context, index),
        ),
      ),
      GoRoute(
        path: RouteNames.customerOrders,
        builder: (context, state) => const CustomerOrdersScreen(),
      ),
      GoRoute(
        path: RouteNames.customerProfile,
        builder: (context, state) => CustomerPlaceholderScreen(
          title: 'Profile',
          navIndex: 3,
          onNavTap: (index) => _onCustomerNavTap(context, index),
          onSearchTap: () => context.push(RouteNames.customerSearch),
        ),
      ),
      GoRoute(
        path: RouteNames.customerSendRequest,
        builder: (context, state) => SendRequestScreen(
          args: state.extra as SendRequestArgs?,
        ),
      ),
      GoRoute(
        path: '${RouteNames.customerTailorProfile}/:id',
        builder: (context, state) => ProviderProfileScreen(
          type: ProviderType.tailor,
          providerId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '${RouteNames.customerShopProfile}/:id',
        builder: (context, state) => ProviderProfileScreen(
          type: ProviderType.shopkeeper,
          providerId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: RouteNames.aiAssistant,
        builder: (context, state) => const AiAssistantScreen(),
      ),
      GoRoute(
        path: RouteNames.tailorHome,
        builder: (context, state) => const TailorHomeScreen(),
      ),
      GoRoute(
        path: RouteNames.tailorSearch,
        builder: (context, state) => TailorPlaceholderScreen(
          title: 'Search',
          navIndex: 0,
          onNavTap: (index) => _onTailorNavTap(context, index),
          showBottomNav: false,
          showBackButton: true,
        ),
      ),
      GoRoute(
        path: RouteNames.tailorChat,
        routes: [
          GoRoute(
            path: ':threadId',
            builder: (context, state) => ChatConversationScreen(
              threadId: state.pathParameters['threadId']!,
            ),
          ),
        ],
        builder: (context, state) => ChatListScreen(
          role: UserRole.tailor,
          searchRoute: RouteNames.tailorSearch,
          conversationRoutePrefix: RouteNames.tailorChat,
          onNavTap: (index) => _onTailorNavTap(context, index),
        ),
      ),
      GoRoute(
        path: RouteNames.tailorOrders,
        builder: (context, state) => ProviderOrdersScreen(
          role: UserRole.tailor,
          searchRoute: RouteNames.tailorSearch,
          onNavTap: (index) => _onTailorNavTap(context, index),
        ),
      ),
      GoRoute(
        path: RouteNames.tailorProfile,
        builder: (context, state) => const TailorProfileScreen(),
      ),
      GoRoute(
        path: RouteNames.shopkeeperHome,
        builder: (context, state) => const ShopkeeperHomeScreen(),
      ),
      GoRoute(
        path: RouteNames.shopkeeperSearch,
        builder: (context, state) => ShopkeeperPlaceholderScreen(
          title: 'Search',
          navIndex: 0,
          onNavTap: (index) => _onShopkeeperNavTap(context, index),
          showBottomNav: false,
          showBackButton: true,
        ),
      ),
      GoRoute(
        path: RouteNames.shopkeeperChat,
        routes: [
          GoRoute(
            path: ':threadId',
            builder: (context, state) => ChatConversationScreen(
              threadId: state.pathParameters['threadId']!,
            ),
          ),
        ],
        builder: (context, state) => ChatListScreen(
          role: UserRole.shopkeeper,
          searchRoute: RouteNames.shopkeeperSearch,
          conversationRoutePrefix: RouteNames.shopkeeperChat,
          onNavTap: (index) => _onShopkeeperNavTap(context, index),
        ),
      ),
      GoRoute(
        path: RouteNames.shopkeeperOrders,
        builder: (context, state) => ProviderOrdersScreen(
          role: UserRole.shopkeeper,
          searchRoute: RouteNames.shopkeeperSearch,
          onNavTap: (index) => _onShopkeeperNavTap(context, index),
        ),
      ),
      GoRoute(
        path: RouteNames.shopkeeperProfile,
        builder: (context, state) => const ShopkeeperProfileScreen(),
      ),
    ],
  );

  static void _onShopkeeperNavTap(BuildContext context, int index) {
    handleShopkeeperNavTap(context, index);
  }

  static void _onCustomerNavTap(BuildContext context, int index) {
    handleCustomerNavTap(context, index);
  }

  static void _onTailorNavTap(BuildContext context, int index) {
    handleTailorNavTap(context, index);
  }
}
