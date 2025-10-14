import 'package:chat_app/domain/repository/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../entity/failures.dart';

class LoginUseCase{
  AuthRepository authRepository ;
  LoginUseCase({required this.authRepository});

  Future<Either<Failures, User?>?> invoke(String email , String password)async{
   return await authRepository.login(email, password);
  }
}