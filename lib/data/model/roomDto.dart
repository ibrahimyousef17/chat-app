import 'package:chat_app/domain/entity/roomEntity.dart';

class RoomDto extends RoomEntity{
  static const String collectionName = 'Room';
  RoomDto({
   required super.id,
   required super.categoryId,
   required super.roomName,
   required super.roomDescription,
});

  factory RoomDto.fromJson(Map<String,dynamic>? json)=>RoomDto(
      id: json?['id'] as String?,
      categoryId: json?['categoryId'] as String?,
      roomName: json?['roomName'] as String?,
      roomDescription: json?['roomDescription'] as String?
  );

  Map<String , dynamic> toJson(){
    return {
      'id': id,
      'categoryId': categoryId,
      'roomName': roomName,
      'roomDescription': roomDescription,
    };
  }
}