import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const _lastSeenKey = 'lastSeenAnnouncements';

  static Future<void> setLastSeen(int count) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lastSeenKey, count);
  }

  static Future<int> getLastSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_lastSeenKey) ?? 0;
  }
}
