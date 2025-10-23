import 'package:chat_app/domain/entity/failures.dart';
import 'package:chat_app/domain/entity/roomEntity.dart';
import 'package:chat_app/domain/repository/repository/room_repository.dart';
import 'package:dartz/dartz.dart';

class AddRoomUseCase{
  RoomRepository roomRepository ;
  AddRoomUseCase({required this.roomRepository});

  Future<Either<Failures, void>> invoke(RoomEntity roomEntity,String uid){
    return roomRepository.addRoomToFireStore(roomEntity, uid);
  }
}