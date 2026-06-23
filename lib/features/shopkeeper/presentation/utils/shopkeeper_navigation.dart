import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/route_names.dart';

void handleShopkeeperNavTap(BuildContext context, int index) {
  switch (index) {
    case 0:
      context.go(RouteNames.shopkeeperHome);
    case 1:
      context.go(RouteNames.shopkeeperChat);
    case 2:
      context.go(RouteNames.shopkeeperOrders);
    case 3:
      context.go(RouteNames.shopkeeperProfile);
  }
}
