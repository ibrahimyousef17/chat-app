import 'dart:async';

import 'package:chat_app/domain/di.dart';
import 'package:chat_app/presentation/auth/cubit/auth_cubit.dart';
import 'package:chat_app/presentation/auth/login/login_screen.dart';
import 'package:chat_app/presentation/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/home_screen.dart';
import 'cubit/splash_screen_states.dart';
import 'cubit/splash_screen_view_model.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = 'splash screen';
  var viewModel = SplashScreenViewModel(getUserUseCase: injectGetUserUseCase());

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashScreenViewModel, SplashStates>(
      bloc: viewModel..getUser(),
      listener: (context, state) {
         if(state is SplashNavigateToLoginState){
          Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
        }else if(state is SplashNavigateToHomeState){
          AuthViewModel.getProvider(context).setUser(state.userEntity);
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        }
      },
      child: Container(
        child: Image.asset(AppAssets.splashScreen, fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,),
      ),
    );
  }
}
