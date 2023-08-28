import 'package:scrumpoker_flutter/modules/core/entities/room_entity.dart';

abstract class RoomRepository {
  Future<RoomEntity> joinRoom(String? roomId);
}
