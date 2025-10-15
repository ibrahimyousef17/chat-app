import 'package:chat_app/data/database/shared_prefs/shared_prefs.dart';
import 'package:chat_app/data/repository/data_source/auth_local_data_source_impl.dart';
import 'package:chat_app/data/repository/data_source/auth_remote_data_source_impl.dart';
import 'package:chat_app/data/repository/repository/auth_repository_impl.dart';
import 'package:chat_app/domain/repository/data_source/auth_local_data_source.dart';
import 'package:chat_app/domain/repository/data_source/auth_remote_data_source.dart';
import 'package:chat_app/domain/repository/repository/auth_repository.dart';
import 'package:chat_app/domain/use_case/get_user_use_case.dart';
import 'package:chat_app/domain/use_case/log_out_use_case.dart';
import 'package:chat_app/domain/use_case/login_use_case.dart';
import 'package:chat_app/domain/use_case/register_use_case.dart';
import '../data/database/firebase_utils/firebase_utils.dart';

RegisterUseCase injectRegisterUseCase(){
  return RegisterUseCase(authRepository: injectAuthRepository());
}
LoginUseCase injectLoginUseCase(){
  return LoginUseCase(authRepository: injectAuthRepository());
}
GetUserUseCase injectGetUserUseCase(){
  return GetUserUseCase(authRepository: injectAuthRepository());
}

LogoutUseCase injectLogoutUseCase(){
  return LogoutUseCase(authRepository: injectAuthRepository());
}

AuthRepository injectAuthRepository(){
  return AuthRepositoryImpl(authRemoteDataSource: injectAuthRemoteDataSource(), authLocalDataSource: injectAuthLocalDataSource(),);
}
AuthRemoteDataSource injectAuthRemoteDataSource(){
  return AuthRemoteDataSourceImpl(firebaseUtils: FirebaseUtils.getInstance());
}
AuthLocalDataSource injectAuthLocalDataSource(){
  return AuthLocalDataSourceImpl(sharedPrefUtils: SharedPrefUtils.getInstance());
}