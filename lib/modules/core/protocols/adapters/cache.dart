abstract class Cache {
  Future<bool> setBool(String key, bool value);
  bool getBool(String key);
}
