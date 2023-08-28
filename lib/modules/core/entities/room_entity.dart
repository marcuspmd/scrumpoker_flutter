import 'package:dson_adapter/dson_adapter.dart';
import 'package:scrumpoker_flutter/modules/core/entities/average_entity.dart';
import 'package:scrumpoker_flutter/modules/core/entities/user_entity.dart';

class RoomEntity {
  final String id;
  final List<UserEntity> users;
  final AverageEntity? average;

  RoomEntity({
    required this.id,
    required this.users,
    this.average,
  });

  static RoomEntity get empty => RoomEntity(
        id: '',
        users: [],
        average: null,
      );

  RoomEntity copyWith({
    String? id,
    List<UserEntity>? users,
    AverageEntity? average,
  }) {
    return RoomEntity(
      id: id ?? this.id,
      users: users ?? this.users,
      average: average ?? this.average,
    );
  }

  RoomEntity fromMap(Map<String, dynamic> map) {
    const dson = DSON();
    return dson.fromJson(map, RoomEntity.new);
  }
}
