import 'package:flutter/material.dart';

import '../../../../core/routing/route_names.dart';
import '../../../../core/enums/user_role.dart';
import '../../../profile/presentation/screens/account_profile_screen.dart';
import '../utils/customer_navigation.dart';

class CustomerProfileScreen extends StatelessWidget {
  const CustomerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AccountProfileScreen(
      role: UserRole.customer,
      searchRoute: RouteNames.customerSearch,
      navIndex: 3,
      onNavTap: (index) => handleCustomerNavTap(context, index),
    );
  }
}
