import 'package:chat_app/domain/entity/userEntity.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../entity/failures.dart';

abstract class AuthRepository{

  Future<Either<Failures, UserEntity>> register(String email, String password,String name);
  Future<Either<Failures, UserEntity>> login(String email, String password);
  Either<Failures,UserEntity> getUserFromSharedPref();
  Future<void> logout();
}