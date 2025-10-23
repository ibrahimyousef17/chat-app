import 'package:chat_app/domain/entity/failures.dart';
import 'package:chat_app/domain/entity/message.dart';
import 'package:chat_app/domain/repository/data_source/chat_remote_data_source.dart';
import 'package:chat_app/domain/repository/repository/chat_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class ChatRepositoryImpl implements ChatRepository{
  ChatRemoteDataSource chatRemoteDataSource;
  ChatRepositoryImpl({required this.chatRemoteDataSource});
  @override
  Future<Either<Failures, Stream<QuerySnapshot<MessageEntity>>>> receiveMessage(String roomId) {
    return chatRemoteDataSource.receiveMessage(roomId);
  }

  @override
  Future<Either<Failures, void>> sendMessage(MessageEntity message) {
    return chatRemoteDataSource.sendMessage(message);
  }

}