import 'package:chat_app/domain/entity/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../entity/failures.dart';

abstract class ChatRepository{
  Future<Either<Failures,void>> sendMessage(MessageEntity message);
  Future<Either<Failures, Stream<QuerySnapshot<MessageEntity>>>> receiveMessage(String roomId);
}