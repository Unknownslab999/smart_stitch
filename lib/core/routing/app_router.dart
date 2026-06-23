import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/ai/presentation/screens/ai_assistant_screen.dart';
import '../../features/auth/presentation/screens/create_account_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/customer/presentation/screens/customer_placeholder_screen.dart';
import '../../features/customer/presentation/screens/provider_profile_screen.dart';
import '../../features/customer/presentation/screens/send_request_screen.dart';
import '../../core/routing/send_request_args.dart';
import '../../core/enums/provider_type.dart';
import '../../features/customer/presentation/utils/customer_navigation.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/shopkeeper/presentation/screens/shopkeeper_home_screen.dart';
import '../../features/tailor/presentation/screens/tailor_home_screen.dart';
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
      ),
      GoRoute(
        path: RouteNames.customerHome,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: RouteNames.customerSearch,
        builder: (context, state) => CustomerPlaceholderScreen(
          title: 'Search',
          navIndex: 1,
          onNavTap: (index) => _onCustomerNavTap(context, index),
        ),
      ),
      GoRoute(
        path: RouteNames.customerOrders,
        builder: (context, state) => CustomerPlaceholderScreen(
          title: 'Orders',
          navIndex: 2,
          onNavTap: (index) => _onCustomerNavTap(context, index),
        ),
      ),
      GoRoute(
        path: RouteNames.customerProfile,
        builder: (context, state) => CustomerPlaceholderScreen(
          title: 'Profile',
          navIndex: 3,
          onNavTap: (index) => _onCustomerNavTap(context, index),
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
        path: RouteNames.shopkeeperHome,
        builder: (context, state) => const ShopkeeperHomeScreen(),
      ),
    ],
  );

  static void _onCustomerNavTap(BuildContext context, int index) {
    handleCustomerNavTap(context, index);
  }
}
