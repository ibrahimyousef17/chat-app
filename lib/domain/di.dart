import 'package:chat_app/data/firebase_utils/firebase_utils.dart';
import 'package:chat_app/data/repository/data_source/auth_remote_data_source_impl.dart';
import 'package:chat_app/data/repository/repository/auth_repository_impl.dart';
import 'package:chat_app/domain/repository/data_source/auth_remote_data_source.dart';
import 'package:chat_app/domain/repository/repository/auth_repository.dart';
import 'package:chat_app/domain/use_case/register_use_case.dart';

RegisterUseCase injectRegisterUseCase(){
  return RegisterUseCase(authRepository: injectAuthRepository());
}

AuthRepository injectAuthRepository(){
  return AuthRepositoryImpl(authRemoteDataSource: injectAuthRemoteDataSource());
}
AuthRemoteDataSource injectAuthRemoteDataSource(){
  return AuthRemoteDataSourceImpl(firebaseUtils: FirebaseUtils.getInstance());
}