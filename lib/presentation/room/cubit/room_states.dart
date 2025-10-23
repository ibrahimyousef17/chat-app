abstract class RoomStates{}
class RoomInitialState extends RoomStates{}
class AddRoomLoadingState extends RoomStates{
  String loadingMessage ;
  AddRoomLoadingState({required this.loadingMessage});
}
class AddRoomErrorState extends RoomStates{
  String errorMessage ;
  AddRoomErrorState({required this.errorMessage});
}
class AddRoomSuccessState extends RoomStates{
}


