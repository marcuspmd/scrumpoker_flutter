import 'package:scrumpoker_flutter/modules/core/entities/average_entity.dart';
import 'package:scrumpoker_flutter/modules/core/entities/room_entity.dart';
import 'package:scrumpoker_flutter/modules/core/entities/user_entity.dart';

abstract interface class RoomRepository {
  void connect();

  void emitChangeDeckOfCards(String deckOfCards);
  void emitClear();
  void emitIsSpectator();
  RoomEntity? emitJoinRoom(String? roomId);
  void emitNewRoom();
  void emitShowVotes();
  void emitVote(String? vote);

  void onClear();
  String? onId(String? id);
  UserEntity? onIsSpectator(Map<String, dynamic>? data);
  String? onNewRoom(String? id);
  List<UserEntity>? onRoomDetail(List<dynamic>? data);
  AverageEntity? onSd(Map<String, dynamic>? data);
  List<UserEntity>? onShowVotes(List<dynamic>? data);
  UserEntity? onUserJoined(Map<String, dynamic>? data);
  String? onUserLeft(String? id);
  String? onVoted(String? id);
}
