import 'package:scrumpoker_flutter/modules/core/entities/room_entity.dart';

abstract interface class RoomRepository {
  void newRoom();
  RoomEntity? joinRoom(String? roomId);
  void changeDeckOfCards(String deckOfCards);
  void vote(String? vote);
}
