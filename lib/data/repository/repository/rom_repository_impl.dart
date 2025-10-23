import 'package:chat_app/domain/entity/failures.dart';
import 'package:chat_app/domain/entity/roomEntity.dart';
import 'package:chat_app/domain/repository/data_source/room_remote_data_source.dart';
import 'package:chat_app/domain/repository/repository/room_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class RoomRepositoryImpl implements RoomRepository{
  RoomRemoteDataSource roomRemoteDataSource ;
  RoomRepositoryImpl({required this.roomRemoteDataSource});
  @override
  Future<Either<Failures, void>> addRoomToFireStore(RoomEntity roomEntity, String uid) {
    return roomRemoteDataSource.addRoomToFireStore(roomEntity, uid);
  }

  @override
  Future<Either<Failures, Stream<QuerySnapshot<RoomEntity>>>> getRoomFromFireStore(String uid) {
    return roomRemoteDataSource.getRoomFromFireStore(uid);
  }

}