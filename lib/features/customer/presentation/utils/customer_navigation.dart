import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/route_names.dart';

void handleCustomerNavTap(BuildContext context, int index) {
  switch (index) {
    case 0:
      context.go(RouteNames.customerHome);
    case 1:
      context.go(RouteNames.customerChat);
    case 2:
      context.go(RouteNames.customerOrders);
    case 3:
      context.go(RouteNames.customerProfile);
  }
}
