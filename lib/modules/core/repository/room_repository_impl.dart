import 'package:scrumpoker_flutter/modules/core/entities/room_entity.dart';
import 'package:scrumpoker_flutter/modules/core/protocols/adapters/i_socket.dart';
import 'package:scrumpoker_flutter/modules/core/protocols/repository/room_repository.dart';

class RoomRepositoryImpl implements RoomRepository {
  final ISocket _socket;

  RoomRepositoryImpl(this._socket);

  @override
  RoomEntity emitJoinRoom(String roomId) {
    _socket.joinRoom(roomId);

    RoomEntity room = RoomEntity.empty;
    room = room.copyWith(id: roomId);
    return room;
  }

  @override
  void emitChangeDeckOfCards(String deckOfCards) {
    _socket.changeDeckOfCards(deckOfCards);
  }

  @override
  void emitNewRoom() {
    _socket.newRoom();
  }

  @override
  void emitVote(String? vote) {
    _socket.vote(vote);
  }

  @override
  void emitIsSpectator() {
    _socket.isSpectator();
  }

  @override
  void emitClear() {
    _socket.clear();
  }

  @override
  void emitShowVotes() {
    _socket.showVotes();
  }

  @override
  void connect() {
    _socket.connect();
  }
}
