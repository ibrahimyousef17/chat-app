import 'package:chat_app/domain/entity/failures.dart';
import 'package:chat_app/domain/entity/userEntity.dart';
import 'package:chat_app/domain/repository/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserUseCase{
  AuthRepository authRepository;
  GetUserUseCase({required this.authRepository});
  Either<Failures, UserEntity> invoke(){
    var either = authRepository.getUserFromSharedPref();
    return either ;
  }
}