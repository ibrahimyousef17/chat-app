import 'package:chat_app/data/database/shared_prefs/shared_prefs.dart';
import 'package:chat_app/data/model/userDto.dart';
import 'package:chat_app/domain/entity/failures.dart';
import 'package:chat_app/domain/entity/userEntity.dart';
import 'package:dartz/dartz.dart';

import '../../../domain/repository/data_source/auth_local_data_source.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  SharedPrefUtils sharedPrefUtils;
  AuthLocalDataSourceImpl({required this.sharedPrefUtils});
  @override
  Future<bool> saveUserToSharedPref(UserEntity userEntity) {
    //todo: save user
    var userDto = UserDto(id: userEntity.id, name: userEntity.name, email: userEntity.email);
    return sharedPrefUtils.saveUserInSharedPref(userDto);
  }

  @override
  Either<Failures, UserEntity> getUserFromSharedPref() {
    //todo:get user
   var either =  sharedPrefUtils.getUserFromPref();
   return either ;
  }

  @override
  Future<void> logout() {
    //todo: clear user
    return sharedPrefUtils.clearUser();
  }
}