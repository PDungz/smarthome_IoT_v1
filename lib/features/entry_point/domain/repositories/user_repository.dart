import '../entities/user.dart';

abstract class UserRepository {
  Future<User?> getUser();
  Future<bool> putUser(User user, String password);
}
