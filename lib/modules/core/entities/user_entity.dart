import 'package:dson_adapter/dson_adapter.dart';

class UserEntity {
  final String id;
  final String? vote;
  final bool isVoted;
  final bool isAdmin;
  final bool isSpectator;

  UserEntity({
    required this.id,
    this.vote,
    required this.isVoted,
    required this.isAdmin,
    required this.isSpectator,
  });

  UserEntity copyWith({
    String? id,
    String? vote,
    bool? isVoted,
    bool? isAdmin,
    bool? isSpectator,
  }) {
    return UserEntity(
      id: id ?? this.id,
      vote: vote ?? this.vote,
      isVoted: isVoted ?? this.isVoted,
      isAdmin: isAdmin ?? this.isAdmin,
      isSpectator: isSpectator ?? this.isSpectator,
    );
  }

  UserEntity fromMap(Map<String, dynamic> map) {
    const dson = DSON();
    return dson.fromJson(map, UserEntity.new);
  }
}
