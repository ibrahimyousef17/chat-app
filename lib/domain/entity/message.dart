class MessageEntity{
  String id ;
  String roomId ;
  String userId ;
  String userName ;
  String content ;
  int dateTime ;
  MessageEntity({ this.id='',required this.roomId,required this.userId,required this.content,required this.userName,required this.dateTime});
}