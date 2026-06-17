import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/ai/presentation/screens/ai_assistant_screen.dart';
import '../../features/auth/presentation/screens/create_account_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/customer/presentation/screens/customer_placeholder_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/shopkeeper/presentation/screens/shopkeeper_inventory_screen.dart';
import '../../features/tailor/presentation/screens/tailor_dashboard_screen.dart';
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
        path: RouteNames.aiAssistant,
        builder: (context, state) => const AiAssistantScreen(),
      ),
      GoRoute(
        path: RouteNames.tailorDashboard,
        builder: (context, state) => const TailorDashboardScreen(),
      ),
      GoRoute(
        path: RouteNames.shopkeeperInventory,
        builder: (context, state) => const ShopkeeperInventoryScreen(),
      ),
    ],
  );

  static void _onCustomerNavTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(RouteNames.customerHome);
      case 1:
        context.go(RouteNames.customerSearch);
      case 2:
        context.go(RouteNames.customerOrders);
      case 3:
        context.go(RouteNames.customerProfile);
    }
  }
}
