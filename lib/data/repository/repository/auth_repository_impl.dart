import 'package:chat_app/domain/entity/userEntity.dart';
import 'package:chat_app/domain/repository/data_source/auth_remote_data_source.dart';
import 'package:chat_app/domain/repository/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../domain/entity/failures.dart';
import '../../../domain/repository/data_source/auth_local_data_source.dart';

class AuthRepositoryImpl implements AuthRepository{
  AuthRemoteDataSource authRemoteDataSource ;
  AuthLocalDataSource authLocalDataSource;
  AuthRepositoryImpl({required this.authRemoteDataSource,required this.authLocalDataSource});
  @override
  Future<Either<Failures, UserEntity>> register(String email, String password,String name) async{
    var either =  await authRemoteDataSource.register(email, password,name);
    return either.fold(
            (l) => Left(l),
            (r) async {
      await authLocalDataSource.saveUserToSharedPref(r);
      return Right(r);
    }) ;
  }

  @override
  Future<Either<Failures, UserEntity>> login(String email, String password)async {
    var either =  await authRemoteDataSource.login(email, password);
    return either.fold((l) => Left(l), (r)async{
      await authLocalDataSource.saveUserToSharedPref(r);
      return Right(r);
    }) ;
  }

  @override
  Either<Failures, UserEntity> getUserFromSharedPref() {
   return authLocalDataSource.getUserFromSharedPref();
  }

  @override
  Future<void> logout() {
    return authLocalDataSource.logout();
  }
}