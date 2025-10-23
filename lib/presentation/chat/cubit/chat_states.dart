import 'package:chat_app/domain/entity/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ChatStates{}
class ChatInitialState extends ChatStates{}
class ChatSendLoadingState extends ChatStates{}
class ChatSendErrorState extends ChatStates{
  String errorMessage ;
  ChatSendErrorState({required this.errorMessage});
}
class ChatSendSuccessState extends ChatStates{

}

class ChatReceiveLoadingState extends ChatStates{}
class ChatReceiveErrorState extends ChatStates{
  String errorMessage ;
  ChatReceiveErrorState({required this.errorMessage});
}
class ChatReceiveSuccessState extends ChatStates{
  Stream<QuerySnapshot<MessageEntity>> querySnapShot ;
  ChatReceiveSuccessState({required this.querySnapShot});
}