import 'package:chat_app/presentation/auth/register/cubit/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/use_case/register_use_case.dart';

class RegisterViewModel extends Cubit<RegisterStates>{
  RegisterUseCase registerUseCase ;
  RegisterViewModel({required this.registerUseCase}):super(RegisterInitialState());

  //todo: hold data
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final  formKey = GlobalKey<FormState>();

  //todo: handle logic

register()async{
  emit(RegisterLoadingState(loadingMessage: 'Loading....'));
  var either =await  registerUseCase.invoke(emailController.text, passwordController.text,userNameController.text);
  either.fold(
          (l) => emit(RegisterErrorState(errorMessage: l.errorMessage)),
          (r) => emit(RegisterSuccessState(userEntity: r)));
}
}