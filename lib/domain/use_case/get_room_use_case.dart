import 'package:chat_app/domain/entity/failures.dart';

import 'package:chat_app/domain/entity/roomEntity.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dartz/dartz.dart';

import '../repository/repository/room_repository.dart';

class GetRoomUseCase{
  RoomRepository roomRepository ;
  GetRoomUseCase({required this.roomRepository});

  Future<Either<Failures, Stream<QuerySnapshot<RoomEntity>>>> invoke(String uid){
    return roomRepository.getRoomFromFireStore(uid);
  }
}