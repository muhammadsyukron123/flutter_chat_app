import '../model/user.dart';
import '../repositories/user_repository.dart';

class LoginUseCase {
  final UserRepository userRepository;

  LoginUseCase(this.userRepository);

  Future<User?> login(String email, String password) async {
    // Implement login logic here using UserRepository
    final user = await userRepository.getUserById(email);
    return user;
  }
}
