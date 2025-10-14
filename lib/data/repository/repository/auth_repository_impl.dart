import 'package:chat_app/domain/repository/data_source/auth_remote_data_source.dart';
import 'package:chat_app/domain/repository/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/entity/failures.dart';

class AuthRepositoryImpl implements AuthRepository{
  AuthRemoteDataSource authRemoteDataSource ;
  AuthRepositoryImpl({required this.authRemoteDataSource});
  @override
  Future<Either<Failures, User?>> register(String email, String password) async{
    var either =  await authRemoteDataSource.register(email, password);
    return either ;
  }

  @override
  Future<Either<Failures, User?>> login(String email, String password)async {
    var either =  await authRemoteDataSource.login(email, password);
    return either ;
  }
}