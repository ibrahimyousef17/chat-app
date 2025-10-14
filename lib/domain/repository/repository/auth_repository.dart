import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../entity/failures.dart';

abstract class AuthRepository{

  Future<Either<Failures, User?>> register(String email, String password);
  Future<Either<Failures, User?>> login(String email, String password);
}