import 'package:scrumpoker_flutter/modules/core/entities/room_entity.dart';
import 'package:scrumpoker_flutter/modules/core/protocols/adapters/i_socket.dart';
import 'package:scrumpoker_flutter/modules/core/protocols/repository/room_repository.dart';

class RoomRepositoryImpl implements RoomRepository {
  final ISocket _socket;

  RoomRepositoryImpl(this._socket);

  @override
  RoomEntity? joinRoom(String? roomId) {
    if (roomId == null) {
      newRoom();
      return null;
    }
    _socket.joinRoom(roomId);

    RoomEntity room = RoomEntity.empty;
    room = room.copyWith(id: roomId);
    return room;
  }

  @override
  void changeDeckOfCards(String deckOfCards) {
    print(deckOfCards);
  }

  @override
  void newRoom() {
    _socket.newRoom();
  }

  @override
  vote(String? vote) {
    _socket.vote(vote);
  }
}
