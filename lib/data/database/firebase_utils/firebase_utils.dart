import 'package:chat_app/data/model/userDto.dart';
import 'package:chat_app/domain/entity/failures.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  Future<Either<Failures,UserDto>> register(String email , String password,String name)async{
    var connectivityResult = await Connectivity().checkConnectivity();
    if(connectivityResult==ConnectivityResult.mobile||connectivityResult==ConnectivityResult.wifi){
      //todo have internet
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        //todo: save user
        if(credential.user==null){
          return Left(ServerError(errorMessage: 'Something went wrong, please register again'));
        }
        var userDto = UserDto(id: credential.user!.uid, name: name, email: email);
        await saveUserToFireStore(userDto);
        return Right(userDto) ;
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


  Future<Either<Failures,UserDto>> login(String email , String password)async{
    var connectivityResult = await Connectivity().checkConnectivity();
    if(connectivityResult==ConnectivityResult.mobile||connectivityResult==ConnectivityResult.wifi) {
      //todo have internet
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: email,
            password: password
        );
        if(credential.user==null){
          return Left(ServerError(errorMessage: 'Something went wrong, please login again'));
        }
        var userDto = await getUserFromFireStore(credential.user!.uid);
        if(userDto==null){
          return Left(ServerError(errorMessage: 'Something went wrong, please login again'));
        }
        return Right(userDto);
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

  CollectionReference<UserDto> getUserCollection(){
   var collection =  FirebaseFirestore.instance.collection(UserDto.collectionName).withConverter<UserDto>(
        fromFirestore: (snapshot,options)=>UserDto.fromJson(snapshot.data()),
        toFirestore: (userDto,options)=>userDto.toJson());
   return collection ;
  }

 Future<void> saveUserToFireStore(UserDto userDto){
  return getUserCollection().doc(userDto.id).set(userDto);
 }

 Future<UserDto?> getUserFromFireStore(String userId)async{
     var querySnapshot = await getUserCollection().doc(userId).get();
     return querySnapshot.data();
 }
}