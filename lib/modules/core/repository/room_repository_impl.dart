import 'package:scrumpoker_flutter/modules/core/entities/average_entity.dart';
import 'package:scrumpoker_flutter/modules/core/entities/room_entity.dart';
import 'package:scrumpoker_flutter/modules/core/entities/user_entity.dart';
import 'package:scrumpoker_flutter/modules/core/protocols/adapters/i_socket.dart';
import 'package:scrumpoker_flutter/modules/core/protocols/repository/room_repository.dart';

class RoomRepositoryImpl implements RoomRepository {
  final ISocket _socket;

  RoomRepositoryImpl(this._socket);

  @override
  RoomEntity? emitJoinRoom(String? roomId) {
    if (roomId == null) {
      emitNewRoom();
      return null;
    }
    _socket.joinRoom(roomId);

    RoomEntity room = RoomEntity.empty;
    room = room.copyWith(id: roomId);
    return room;
  }

  @override
  void emitChangeDeckOfCards(String deckOfCards) {
    print(deckOfCards);
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

  @override
  void onClear() {
    // TODO: implement onClear
  }

  @override
  String? onId(String? id) {
    // TODO: implement onId
    throw UnimplementedError();
  }

  @override
  UserEntity? onIsSpectator(Map<String, dynamic>? data) {
    // TODO: implement onIsSpectator
    throw UnimplementedError();
  }

  @override
  String? onNewRoom(String? id) {
    // TODO: implement onNewRoom
    throw UnimplementedError();
  }

  @override
  List<UserEntity>? onRoomDetail(List? data) {
    // TODO: implement onRoomDetail
    throw UnimplementedError();
  }

  @override
  AverageEntity? onSd(Map<String, dynamic>? data) {
    // TODO: implement onSd
    throw UnimplementedError();
  }

  @override
  List<UserEntity>? onShowVotes(List? data) {
    // TODO: implement onShowVotes
    throw UnimplementedError();
  }

  @override
  UserEntity? onUserJoined(Map<String, dynamic>? data) {
    // TODO: implement onUserJoined
    throw UnimplementedError();
  }

  @override
  String? onUserLeft(String? id) {
    // TODO: implement onUserLeft
    throw UnimplementedError();
  }

  @override
  String? onVoted(String? id) {
    // TODO: implement onVoted
    throw UnimplementedError();
  }
}
