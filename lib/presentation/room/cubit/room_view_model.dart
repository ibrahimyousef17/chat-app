import 'package:chat_app/domain/entity/roomEntity.dart';
import 'package:chat_app/presentation/room/cubit/room_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_case/add_room_use_case.dart';

class RoomViewModel extends Cubit<RoomStates>{
  AddRoomUseCase addRoomUseCase ;
  RoomViewModel({required this.addRoomUseCase}):super(RoomInitialState());

  TextEditingController roomName =TextEditingController();
  TextEditingController roomDesc =TextEditingController();
  final  formKey = GlobalKey<FormState>();

  addRoomToFireStore(RoomEntity roomEntity,String uid)async{
    emit(AddRoomLoadingState(loadingMessage: 'Loading....'));
    var either = await  addRoomUseCase.invoke(roomEntity, uid);
    either.fold((l) => emit(AddRoomErrorState(errorMessage: l.errorMessage)),
            (r) => emit(AddRoomSuccessState()));
  }
}