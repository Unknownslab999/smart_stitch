import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/route_names.dart';

void handleTailorNavTap(BuildContext context, int index) {
  switch (index) {
    case 0:
      context.go(RouteNames.tailorHome);
    case 1:
      context.go(RouteNames.tailorChat);
    case 2:
      context.go(RouteNames.tailorOrders);
    case 3:
      context.go(RouteNames.tailorProfile);
  }
}
