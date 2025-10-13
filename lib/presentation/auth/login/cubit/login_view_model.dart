import 'package:chat_app/presentation/auth/login/cubit/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginViewModel extends Cubit<LoginStates>{
  LoginViewModel():super(LoginInitialState());

  //todo: hold data
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
final  formKey = GlobalKey<FormState>();
}