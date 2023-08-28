import 'package:asp/asp.dart';
import 'package:scrumpoker_flutter/atoms/core_atom.dart';
import 'package:scrumpoker_flutter/modules/core/protocols/adapters/cache.dart';

class CoreReduce extends Reducer {
  final Cache prefs;

  CoreReduce({required this.prefs}) {
    bool initialDarkMode = prefs.getBool('darkMode');
    darkMode.value = initialDarkMode;
    on(() => [joinRoom], _joinRoom);
    on(() => [changeSchema], _changeSchema);
  }

  _joinRoom() {
    if (joinRoom.value == null) return;
    loading.value = true;
    room.value = room.value.copyWith(
      id: joinRoom.value,
    );
    joinRoom.value = joinRoom.value;
  }

  _changeSchema() {
    darkMode.value = !darkMode.value;
    prefs.setBool('darkMode', darkMode.value);
  }
}
