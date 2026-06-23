import 'package:flutter/material.dart';

import '../../../../core/routing/route_names.dart';
import '../../../../core/enums/user_role.dart';
import '../../../profile/presentation/screens/provider_portfolio_screen.dart';

class TailorPortfolioScreen extends StatelessWidget {
  const TailorPortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderPortfolioScreen(
      role: UserRole.tailor,
      searchRoute: RouteNames.tailorSearch,
    );
  }
}
