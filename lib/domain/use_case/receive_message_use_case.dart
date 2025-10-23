import 'package:chat_app/domain/entity/failures.dart';
import 'package:chat_app/domain/entity/message.dart';
import 'package:chat_app/domain/repository/repository/chat_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class ReceiveMessageUseCase{
  ChatRepository chatRepository;
  ReceiveMessageUseCase({required this.chatRepository});

  Future<Either<Failures, Stream<QuerySnapshot<MessageEntity>>>> invoke(String roomId){
    return chatRepository.receiveMessage(roomId);
  }
}