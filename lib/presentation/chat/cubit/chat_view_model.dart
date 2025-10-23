import 'package:chat_app/domain/entity/message.dart';
import 'package:chat_app/presentation/chat/cubit/chat_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_case/receive_message_use_case.dart';
import '../../../domain/use_case/send_message_use_case.dart';

class ChatViewModel extends Cubit<ChatStates>{
  SendMessageUseCase sendMessageUseCase;
  ReceiveMessageUseCase receiveMessageUseCase;
  ChatViewModel({required this.sendMessageUseCase,required this.receiveMessageUseCase}):super(ChatInitialState());

  TextEditingController messageController = TextEditingController();


  sendMessage(MessageEntity messageEntity) async {
    emit(ChatSendLoadingState());
   var either = await sendMessageUseCase.invoke(messageEntity);
    either.fold(
           (l) => emit(ChatSendErrorState(errorMessage: l.errorMessage)),
           (r) {
             emit(ChatSendSuccessState());
             receiveMessages(messageEntity.roomId);
           }
   );
  }

  receiveMessages(String roomId) async {
    emit(ChatReceiveLoadingState());
   var either = await receiveMessageUseCase.invoke(roomId);
    either.fold(
           (l) => emit(ChatReceiveErrorState(errorMessage: l.errorMessage)),
           (r) {
             emit(ChatReceiveSuccessState(querySnapShot: r));
           }
   );

  }
}