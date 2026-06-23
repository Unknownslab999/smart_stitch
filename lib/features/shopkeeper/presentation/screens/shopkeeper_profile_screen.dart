import 'package:flutter/material.dart';

import '../../../../core/routing/route_names.dart';
import '../../../../core/enums/user_role.dart';
import '../../../profile/presentation/screens/account_profile_screen.dart';
import '../utils/shopkeeper_navigation.dart';

class ShopkeeperProfileScreen extends StatelessWidget {
  const ShopkeeperProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AccountProfileScreen(
      role: UserRole.shopkeeper,
      searchRoute: RouteNames.shopkeeperSearch,
      navIndex: 3,
      onNavTap: (index) => handleShopkeeperNavTap(context, index),
    );
  }
}
