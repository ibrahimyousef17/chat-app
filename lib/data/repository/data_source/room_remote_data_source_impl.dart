import 'package:chat_app/data/database/firebase_utils/firebase_utils.dart';
import 'package:chat_app/data/model/roomDto.dart';
import 'package:chat_app/domain/entity/roomEntity.dart';
import 'package:chat_app/domain/repository/data_source/room_remote_data_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../domain/entity/failures.dart';

class RoomRemoteDataSourceImpl implements RoomRemoteDataSource{
  FirebaseUtils firebaseUtils ;
  RoomRemoteDataSourceImpl({required this.firebaseUtils});
  @override
  Future<Either<Failures,void>>  addRoomToFireStore(RoomEntity roomEntity , String uid) async{
    var room = RoomDto(id: roomEntity.id, categoryId: roomEntity.categoryId, roomName: roomEntity.roomName, roomDescription: roomEntity.roomDescription) ;
    var either = await firebaseUtils.addRoomToFireStore(room, uid);
    return either ;
  }

  @override
  Future<Either<Failures, Stream<QuerySnapshot<RoomEntity>>>> getRoomFromFireStore(String uid) {
    return firebaseUtils.getRooms(uid);
  }

}