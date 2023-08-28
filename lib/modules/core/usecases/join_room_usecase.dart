import 'package:scrumpoker_flutter/modules/core/entities/room_entity.dart';
import 'package:scrumpoker_flutter/modules/core/protocols/repository/room_repository.dart';

class JoinRoomUsecase {
  final RoomRepository _roomRepository;

  JoinRoomUsecase(this._roomRepository);

  Future<RoomEntity> execute(String? roomId) async {
    return _roomRepository.joinRoom(roomId);
  }
}
