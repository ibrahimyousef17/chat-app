import 'package:chat_app/domain/entity/userEntity.dart';
import 'package:dartz/dartz.dart';

import '../../entity/failures.dart';

abstract class AuthLocalDataSource {
  Future<bool> saveUserToSharedPref(UserEntity userEntity);
  Either<Failures,UserEntity> getUserFromSharedPref();
  Future<void> logout();
}