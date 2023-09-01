import 'package:scrumpoker_flutter/modules/core/entities/room_entity.dart';

abstract interface class RoomRepository {
  Future<RoomEntity> joinRoom(String? roomId);
  Future<void> changeDeckOfCards(String deckOfCards);
}
