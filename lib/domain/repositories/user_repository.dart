import '../model/user.dart';

abstract class UserRepository {
  Future<User?> getUserById(String userId);
}

