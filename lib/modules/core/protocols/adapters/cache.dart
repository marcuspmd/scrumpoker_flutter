abstract class Cache {
  Future<bool> setBool(String key, bool value);
  bool getBool(String key);
  Future<bool> setString(String key, String value);
  String getString(String key);
}
