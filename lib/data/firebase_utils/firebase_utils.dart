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
    if(connectivityResult==ConnectivityResult.mobile||connectivityResult==ConnectivityResult.wifi){
      //todo have internet
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
    //todo no internet
      return Left(NetworkError(errorMessage: 'Please check your internet'));
  }


  Future<Either<Failures,User?>> login(String email , String password)async{
    var connectivityResult = await Connectivity().checkConnectivity();
    if(connectivityResult==ConnectivityResult.mobile||connectivityResult==ConnectivityResult.wifi) {
      //todo have internet
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: email,
            password: password
        );
        return Right(credential.user);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          return Left(
              ServerError(errorMessage: 'No user found for that email.'));
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          return Left(ServerError(
              errorMessage: 'Wrong password provided for that user.'));
        } else if (e.code=='invalid-credential'){
          print('invalid-credential');
          return Left(ServerError(
              errorMessage: 'email or password not invalid'));
        }
      } catch (e) {
        print(e.toString());
        return Left(ServerError(errorMessage: e.toString()));
      }
    }
    //todo no internet
      return Left(NetworkError(errorMessage: 'Please check your internet'));
  }
}