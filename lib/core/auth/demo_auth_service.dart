import '../enums/user_role.dart';
import '../routing/route_names.dart';
import '../../shared/models/mock_user.dart';

class DemoAuthService {
  DemoAuthService._();

  static const _credentials = <String, ({String password, MockUser user})>{
    'cust@gmail.com': (password: 'demo1', user: MockUser.customer),
    'tailor@gmail.com': (password: 'demo2', user: MockUser.tailor),
    'shopkeeper@gmail.com': (password: 'demo3', user: MockUser.shopkeeper),
  };

  static MockUser? authenticate({
    required String email,
    required String password,
  }) {
    final entry = _credentials[email.trim().toLowerCase()];
    if (entry == null || entry.password != password) {
      return null;
    }
    return entry.user;
  }

  static String homeRouteFor(UserRole role) {
    return switch (role) {
      UserRole.customer => RouteNames.customerHome,
      UserRole.tailor => RouteNames.tailorHome,
      UserRole.shopkeeper => RouteNames.shopkeeperHome,
    };
  }
}
