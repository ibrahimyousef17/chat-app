import 'package:chat_app/domain/entity/failures.dart';
import 'package:chat_app/domain/entity/userEntity.dart';
import 'package:chat_app/domain/repository/data_source/auth_remote_data_source.dart';
import 'package:dartz/dartz.dart';
import '../../database/firebase_utils/firebase_utils.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{
  FirebaseUtils firebaseUtils ;
  AuthRemoteDataSourceImpl({required this.firebaseUtils});
  @override
  Future<Either<Failures, UserEntity>> register(String email, String password,String name) async{
    var either = await firebaseUtils.register(email, password,name);
    return either ;
  }

  @override
  Future<Either<Failures, UserEntity>> login(String email, String password) async{
    var either = await firebaseUtils.login(email, password);
    return either ;
  }
}