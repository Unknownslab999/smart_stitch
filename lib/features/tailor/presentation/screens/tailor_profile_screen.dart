import 'package:flutter/material.dart';

import '../../../../core/routing/route_names.dart';
import '../../../../core/enums/user_role.dart';
import '../../../profile/presentation/screens/account_profile_screen.dart';
import '../utils/tailor_navigation.dart';

class TailorProfileScreen extends StatelessWidget {
  const TailorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AccountProfileScreen(
      role: UserRole.tailor,
      searchRoute: RouteNames.tailorSearch,
      navIndex: 3,
      onNavTap: (index) => handleTailorNavTap(context, index),
    );
  }
}
