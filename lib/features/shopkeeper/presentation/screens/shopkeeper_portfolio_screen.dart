import 'package:flutter/material.dart';

import '../../../../core/routing/route_names.dart';
import '../../../../core/enums/user_role.dart';
import '../../../profile/presentation/screens/provider_portfolio_screen.dart';

class ShopkeeperPortfolioScreen extends StatelessWidget {
  const ShopkeeperPortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderPortfolioScreen(
      role: UserRole.shopkeeper,
      searchRoute: RouteNames.shopkeeperSearch,
    );
  }
}
