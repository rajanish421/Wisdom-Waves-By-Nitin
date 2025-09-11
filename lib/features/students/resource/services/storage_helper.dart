import 'dart:io';
import 'package:path_provider/path_provider.dart';

class StorageHelper {
  /// Returns free storage space in MB
  static Future<int> getFreeSpaceMB() async {
    final dir = await getApplicationDocumentsDirectory();
    final stat = await dir.stat();
    final fs = await dir.stat();
    // This is a placeholder, different plugins give better info
    // (like `disk_space` package for accurate free space)
    return 500; // Pretend 500 MB free (replace with real package if needed)
  }

  static Future<bool> hasEnoughSpace(int requiredMB) async {
    int free = await getFreeSpaceMB();
    return free > requiredMB;
  }
}
