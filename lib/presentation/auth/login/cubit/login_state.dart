import 'package:chat_app/domain/entity/userEntity.dart';

abstract class LoginStates {}
class LoginInitialState extends LoginStates {}
class LoginLoadingState extends LoginStates{
  String loadingMessage ;
  LoginLoadingState({required this.loadingMessage});
}
class LoginErrorState extends LoginStates{
  String errorMessage ;
  LoginErrorState({required this.errorMessage});
}
class LoginSuccessState extends LoginStates{
  UserEntity userEntity ;
  LoginSuccessState({required this.userEntity});
}