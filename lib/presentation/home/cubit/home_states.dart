import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entity/roomEntity.dart';

abstract class HomeStates {}
 class HomeInitialState extends HomeStates{}


class GetRoomLoadingState extends HomeStates{
  String loadingMessage ;
  GetRoomLoadingState({required this.loadingMessage});
}
class GetRoomErrorState extends HomeStates{
  String errorMessage ;
  GetRoomErrorState({required this.errorMessage});
}
class GetRoomSuccessState extends HomeStates{
  Stream<QuerySnapshot<RoomEntity>> querySnapShot ;
  GetRoomSuccessState({required this.querySnapShot});
}