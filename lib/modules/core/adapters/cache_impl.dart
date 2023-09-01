import 'package:scrumpoker_flutter/modules/core/protocols/adapters/cache.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheImpl implements Cache {
  final SharedPreferences prefs;

  CacheImpl(this.prefs);

  @override
  bool getBool(String key) {
    return prefs.getBool(key) ?? false;
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    return prefs.setBool(key, value);
  }

  @override
  String getString(String key) {
    return prefs.getString(key) ?? '';
  }

  @override
  Future<bool> setString(String key, String value) async {
    return prefs.setString(key, value);
  }
}
