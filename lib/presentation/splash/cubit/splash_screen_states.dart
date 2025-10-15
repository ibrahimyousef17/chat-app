import 'package:chat_app/domain/entity/userEntity.dart';

abstract class SplashStates{}

class SplashNavigateToHomeState extends SplashStates{
  UserEntity userEntity;
  SplashNavigateToHomeState({required this.userEntity});
}
class SplashNavigateToLoginState extends SplashStates{}
class SplashLoadingState extends SplashStates{}
class SplashInitialState extends SplashStates{}