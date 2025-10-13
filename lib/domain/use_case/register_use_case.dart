import 'package:chat_app/domain/repository/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../entity/failures.dart';

class RegisterUseCase{
  AuthRepository authRepository ;
  RegisterUseCase({required this.authRepository});

  Future<Either<Failures, User?>?> invoke(String email , String password)async{
   return await authRepository.register(email, password);
  }
}