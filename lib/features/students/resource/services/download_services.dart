import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class DownloadService {
  static Future<String> _getFilePath(String fileName) async {
    final dir = await getApplicationDocumentsDirectory();
    return "${dir.path}/$fileName";
  }

  /// Download file with progress
  static Future<String?> downloadFile(
      String url,
      String fileName,
      void Function(int received, int total) onProgress,
      ) async {
    final savePath = await _getFilePath(fileName);

    try {
      Dio dio = Dio();
      await dio.download(
        url,
        savePath,
        onReceiveProgress: onProgress, // 🔑 progress callback
      );
      return savePath;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> isFileDownloaded(String fileName) async {
    final path = await _getFilePath(fileName);
    return File(path).existsSync();
  }

  static Future<String?> getLocalFilePath(String fileName) async {
    final path = await _getFilePath(fileName);
    return File(path).existsSync() ? path : null;
  }

  static Future<void> deleteFile(String fileName) async {
    final path = await _getFilePath(fileName);
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
