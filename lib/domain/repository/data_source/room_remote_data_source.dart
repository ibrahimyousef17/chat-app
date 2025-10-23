import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../entity/failures.dart';
import '../../entity/roomEntity.dart';

abstract class RoomRemoteDataSource{
  Future<Either<Failures,void>>  addRoomToFireStore(RoomEntity roomEntity , String uid);
  Future<Either<Failures, Stream<QuerySnapshot<RoomEntity>>>> getRoomFromFireStore(String uid);

}