import 'package:chat_app/domain/entity/failures.dart';
import 'package:chat_app/domain/entity/message.dart';
import 'package:chat_app/domain/repository/repository/chat_repository.dart';
import 'package:dartz/dartz.dart';

class SendMessageUseCase{
  ChatRepository chatRepository ;
  SendMessageUseCase({required this.chatRepository});

  Future<Either<Failures, void>> invoke(MessageEntity message){
    return chatRepository.sendMessage(message);
  }
}