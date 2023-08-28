import 'package:asp/asp.dart';
import 'package:scrumpoker_flutter/modules/core/entities/room_entity.dart';

// atoms
final room = Atom<RoomEntity>(RoomEntity.empty);
final loading = Atom(true);
final darkMode = Atom(false);

// actions
final changeSchema = Atom.action();
final joinRoom = Atom<String?>(null);
