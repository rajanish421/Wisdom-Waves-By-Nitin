import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class CachedImageWidget extends StatefulWidget {
  final String imageUrl; // Cloudinary URL
  final String className;
  final String subject;
  final String imageName; // filename for saving locally

  const CachedImageWidget({
    super.key,
    required this.imageUrl,
    required this.className,
    required this.subject,
    required this.imageName,
  });

  @override
  State<CachedImageWidget> createState() => _CachedImageWidgetState();

  /// ✅ Static helper to get cached file without rebuilding the widget
  static Future<File> getCachedFile({
    required String imageUrl,
    required String className,
    required String subject,
    required String imageName,
  }) async {
    final dir = await getApplicationDocumentsDirectory();
    final folderPath = '${dir.path}/$className/$subject';
    final folder = Directory(folderPath);

    if (!folder.existsSync()) {
      folder.createSync(recursive: true);
    }

    final filePath = '$folderPath/$imageName';
    final file = File(filePath);

    if (file.existsSync()) {
      // Already downloaded
      return file;
    } else {
      // Download from URL and save
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        await file.writeAsBytes(response.bodyBytes);
        return file;
      } else {
        throw Exception('Failed to download image');
      }
    }
  }
}

class _CachedImageWidgetState extends State<CachedImageWidget> {
  late Future<File> _imageFileFuture;

  @override
  void initState() {
    super.initState();
    _imageFileFuture = CachedImageWidget.getCachedFile(
      imageUrl: widget.imageUrl,
      className: widget.className,
      subject: widget.subject,
      imageName: widget.imageName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File>(
      future: _imageFileFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Icon(Icons.error, color: Colors.red));
        } else if (snapshot.hasData) {
          return Image.file(snapshot.data!, fit: BoxFit.cover);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
