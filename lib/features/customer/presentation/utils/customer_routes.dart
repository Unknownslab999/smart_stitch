import '../../../../core/routing/route_names.dart';

abstract final class CustomerRoutes {
  static String tailorProfile(String id) => '${RouteNames.customerTailorProfile}/$id';

  static String shopProfile(String id) => '${RouteNames.customerShopProfile}/$id';
}
