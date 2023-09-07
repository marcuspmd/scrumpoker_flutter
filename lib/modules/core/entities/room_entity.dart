import 'package:dson_adapter/dson_adapter.dart';
import 'package:scrumpoker_flutter/modules/core/entities/average_entity.dart';
import 'package:scrumpoker_flutter/modules/core/entities/user_entity.dart';

class RoomEntity {
  final String id;
  final UserEntity myUser;
  final List<UserEntity> users;
  final AverageEntity? average;
  final bool isOwner;
  final bool isVoting;

  RoomEntity({
    required this.id,
    required this.myUser,
    required this.users,
    this.average,
    required this.isOwner,
    required this.isVoting,
  });

  static RoomEntity get empty => RoomEntity(
        id: '',
        myUser: UserEntity.empty,
        users: [],
        average: null,
        isOwner: false,
        isVoting: true,
      );

  RoomEntity copyWith({
    String? id,
    UserEntity? myUser,
    List<UserEntity>? users,
    AverageEntity? average,
    bool? isOwner,
    bool? isVoting,
  }) {
    return RoomEntity(
      id: id ?? this.id,
      myUser: myUser ?? this.myUser,
      users: users ?? this.users,
      average: average ?? this.average,
      isOwner: isOwner ?? this.isOwner,
      isVoting: isVoting ?? this.isVoting,
    );
  }

  RoomEntity clearAverage() {
    return RoomEntity(
      id: id,
      myUser: myUser,
      users: users,
      average: null,
      isOwner: isOwner,
      isVoting: isVoting,
    );
  }

  RoomEntity fromMap(Map<String, dynamic> map) {
    const dson = DSON();
    return dson.fromJson(map, RoomEntity.new);
  }
}
