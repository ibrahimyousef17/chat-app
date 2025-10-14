import 'package:chat_app/presentation/auth/login/cubit/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/use_case/login_use_case.dart';

class LoginViewModel extends Cubit<LoginStates>{
  LoginUseCase loginUseCase ;
  LoginViewModel({required this.loginUseCase}):super(LoginInitialState());

  //todo: hold data
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
final  formKey = GlobalKey<FormState>();
//todo: handle logic
login() async {
  emit(LoginLoadingState(loadingMessage: 'Loading....'));
  var either =await  loginUseCase.invoke(emailController.text, passwordController.text);
  either?.fold(
          (l) => emit(LoginErrorState(errorMessage: l.errorMessage)),
          (r) => emit(LoginSuccessState()));
}

}