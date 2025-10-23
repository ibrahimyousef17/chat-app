import 'package:chat_app/data/database/firebase_utils/firebase_utils.dart';
import 'package:chat_app/data/model/messageDto.dart';
import 'package:chat_app/domain/entity/failures.dart';
import 'package:chat_app/domain/entity/message.dart';
import 'package:chat_app/domain/repository/data_source/chat_remote_data_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource{
  FirebaseUtils firebaseUtils;
  ChatRemoteDataSourceImpl({required this.firebaseUtils});
  @override
  Future<Either<Failures, Stream<QuerySnapshot<MessageEntity>>>> receiveMessage(String roomId) {
   return firebaseUtils.receiveMessages(roomId);
  }

  @override
  Future<Either<Failures, void>> sendMessage(MessageEntity message) {
    var messageEntity = MessageDto(id: message.id, roomId: message.roomId, userId: message.userId, userName: message.userName, content: message.content,dateTime: message.dateTime);
    return firebaseUtils.sendMessage(messageEntity);
  }
}