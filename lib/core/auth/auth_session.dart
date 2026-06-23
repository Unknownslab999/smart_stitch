import '../../shared/models/mock_user.dart';

class AuthSession {
  AuthSession._();

  static MockUser? _currentUser;

  static MockUser? get currentUser => _currentUser;

  static void signIn(MockUser user) => _currentUser = user;

  static void signOut() => _currentUser = null;

  static bool get isSignedIn => _currentUser != null;
}
