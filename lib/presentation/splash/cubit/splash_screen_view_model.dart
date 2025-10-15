import 'package:chat_app/presentation/splash/cubit/splash_screen_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_case/get_user_use_case.dart';

class SplashScreenViewModel extends Cubit<SplashStates>{
  GetUserUseCase getUserUseCase;
  SplashScreenViewModel({required this.getUserUseCase}):super(SplashInitialState());
  Future<void> getUser() async {
    emit(SplashLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    var either = getUserUseCase.invoke();
    either.fold(
          (l) {
        print("➡️ No user in cache: ${l.errorMessage}");
        emit(SplashNavigateToLoginState());
      },
          (r) {
        print("✅ Found user: ${r.name}");
        emit(SplashNavigateToHomeState(userEntity: r));
      },
    );
  }
}