class RoomEntity{
  String? id ;
  String? roomName ;
  String? roomDescription ;
  String? categoryId ;

  RoomEntity({
     this.id='',
    required this.categoryId,
    required this.roomName,
    required this.roomDescription,
});
}