import 'package:chat_app/presentation/home/cubit/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_case/get_room_use_case.dart';

class HomeScreenViewModel extends Cubit<HomeStates>{
  GetRoomUseCase getRoomUseCase ;
  HomeScreenViewModel({required this.getRoomUseCase}):super(HomeInitialState());

  getRoomFromFireStore(String uid)async{
    emit(GetRoomLoadingState(loadingMessage: 'Loading.....'));
    var either = await getRoomUseCase.invoke(uid);
    return either.fold(
            (l) => emit(GetRoomErrorState(errorMessage: l.errorMessage)),
            (r) => emit(GetRoomSuccessState(querySnapShot: r))
    );
  }
}