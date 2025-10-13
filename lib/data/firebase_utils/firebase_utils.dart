import 'package:chat_app/domain/entity/failures.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUtils{
  static FirebaseUtils? _instance ;
  FirebaseUtils._();
  static FirebaseUtils getInstance(){
    _instance??=FirebaseUtils._();
    return _instance! ;
  }
  Future<Either<Failures,User?>> register(String email , String password)async{
    var connectivityResult = await Connectivity().checkConnectivity();
    if(connectivityResult==ConnectivityResult.mobile||connectivityResult==ConnectivityResult.mobile){
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        return Right(credential.user) ;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
          return Left(ServerError(errorMessage: 'The password provided is too weak.'));
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          return Left(ServerError(errorMessage: 'The account already exists for that email.'));
        }
      } catch (e) {
        print(e);
        return Left(ServerError(errorMessage: 'The account already exists for that email.'));

      }
    }
      return Left(NetworkError(errorMessage: 'Please check your internet'));
  }
}