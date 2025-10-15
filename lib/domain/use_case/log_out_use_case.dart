import '../repository/repository/auth_repository.dart';

class LogoutUseCase{
   AuthRepository authRepository;
  LogoutUseCase({required this.authRepository});

  Future<void> invoke() async {
    return await authRepository.logout();
  }
}