import 'package:chat_app/data/firebase_utils/firebase_utils.dart';
import 'package:chat_app/domain/entity/failures.dart';
import 'package:chat_app/domain/repository/data_source/auth_remote_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{
  FirebaseUtils firebaseUtils ;
  AuthRemoteDataSourceImpl({required this.firebaseUtils});
  @override
  Future<Either<Failures, User?>> register(String email, String password) async{
    var either = await firebaseUtils.register(email, password);
    return either ;
  }
}