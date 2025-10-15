import 'package:chat_app/domain/entity/userEntity.dart';
import 'package:chat_app/presentation/auth/cubit/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_case/log_out_use_case.dart';

class AuthViewModel extends Cubit<AuthStates> {
  LogoutUseCase logoutUseCase;
  AuthViewModel({required this.logoutUseCase}) : super(AuthInitialStates());
  UserEntity? currentUser ;

 static AuthViewModel getProvider(context)=>BlocProvider.of(context);

  void setUser(UserEntity user) {
    currentUser = user ;
    emit(AuthExistUser());
  }

  Future<void> clearUser() async {
    await logoutUseCase.invoke();
    currentUser = null ;
    emit(AuthClearUser());
  }
}