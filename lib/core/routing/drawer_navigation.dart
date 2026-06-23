import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/data/role_agreement_content.dart';
import '../enums/user_role.dart';
import 'route_names.dart';

void handleDrawerNavigation(
  BuildContext context,
  UserRole role,
  String label,
) {
  final route = _routeForDrawerItem(role, label);
  if (route != null) {
    context.go(route);
  }
}

String? _routeForDrawerItem(UserRole role, String label) {
  final agreementTitle = RoleAgreementContent.forRole(role).title;
  if (label == agreementTitle) {
    return switch (role) {
      UserRole.customer => RouteNames.customerAgreement,
      UserRole.tailor => RouteNames.tailorAgreement,
      UserRole.shopkeeper => RouteNames.shopkeeperAgreement,
    };
  }

  return switch (label) {
    'Profile' => switch (role) {
        UserRole.customer => RouteNames.customerProfile,
        UserRole.tailor => RouteNames.tailorProfile,
        UserRole.shopkeeper => RouteNames.shopkeeperProfile,
      },
    'Portfolio' => switch (role) {
        UserRole.tailor => RouteNames.tailorPortfolio,
        UserRole.shopkeeper => RouteNames.shopkeeperPortfolio,
        UserRole.customer => null,
      },
    'Orders' => switch (role) {
        UserRole.customer => RouteNames.customerOrders,
        UserRole.tailor => RouteNames.tailorOrders,
        UserRole.shopkeeper => RouteNames.shopkeeperOrders,
      },
    'Order History' => switch (role) {
        UserRole.customer => RouteNames.customerOrders,
        UserRole.tailor => RouteNames.tailorOrders,
        UserRole.shopkeeper => RouteNames.shopkeeperOrders,
      },
    _ => null,
  };
}
