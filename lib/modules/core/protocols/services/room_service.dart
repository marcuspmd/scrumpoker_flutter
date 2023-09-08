import 'package:scrumpoker_flutter/modules/core/entities/room_entity.dart';

abstract interface class RoomService {
  void connect();

  void emitChangeDeckOfCards(String deckOfCards);
  void emitClear();
  void emitIsSpectator();
  RoomEntity emitJoinRoom(String roomId);
  void emitNewRoom();
  void emitShowVotes();
  void emitVote(String? vote);
}
