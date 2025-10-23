import 'package:chat_app/domain/entity/message.dart';

class MessageDto extends MessageEntity{
  static const String collectionName = 'message';
  MessageDto({
    required super.roomId,
    required super.userId,
    required super.userName,
    required super.content, required String id,
    required super.dateTime
  });
  factory MessageDto.fromJson(Map<String,dynamic>? json)=>MessageDto(
      id: json?['id'] as String,
      roomId: json?['roomId'] as String,
      userId: json?['userId'] as String,
      userName: json?['userName'] as String,
      content: json?['content'] as String,
    dateTime: json?['dateTime'] as int,
  );
  
  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'roomId':roomId,
      'userId':userId,
      'userName':userName,
      'content':content,
      'dateTime':dateTime,
    };
  }
}