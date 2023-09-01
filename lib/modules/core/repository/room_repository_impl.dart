import 'package:scrumpoker_flutter/modules/core/entities/room_entity.dart';
import 'package:scrumpoker_flutter/modules/core/entities/user_entity.dart';
import 'package:scrumpoker_flutter/modules/core/protocols/repository/room_repository.dart';

class RoomRepositoryImpl implements RoomRepository {
  @override
  Future<RoomEntity> joinRoom(String? roomId) async {
    if (roomId == null) {
      return await _createRoom();
    }

    RoomEntity room = RoomEntity.empty;
    room = room.copyWith(id: roomId);
    return room;
  }

  @override
  Future<void> changeDeckOfCards(String deckOfCards) async {
    print(deckOfCards);
  }

  Future<RoomEntity> _createRoom() async {
    UserEntity myUser =
        UserEntity(id: '2', isVoted: false, isAdmin: true, isSpectator: false);
    return Future.value(RoomEntity(
        id: 'Play',
        myUser: myUser,
        users: [
          UserEntity(id: '1', isVoted: false, isAdmin: true, isSpectator: true),
          myUser,
          UserEntity(
              id: '3', isVoted: false, isAdmin: true, isSpectator: false),
          UserEntity(
              id: '4', isVoted: false, isAdmin: true, isSpectator: false),
          UserEntity(
              id: '5', isVoted: false, isAdmin: true, isSpectator: false),
        ],
        average: null,
        isOwner: true,
        isVoting: false));
  }
}
