import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../entity/failures.dart';
import '../../entity/message.dart';

abstract class ChatRemoteDataSource{
  Future<Either<Failures,void>> sendMessage(MessageEntity message);
  Future<Either<Failures, Stream<QuerySnapshot<MessageEntity>>>> receiveMessage(String roomId);
}