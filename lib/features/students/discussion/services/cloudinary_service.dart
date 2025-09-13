// features/students/discussion/services/cloudinary_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class CloudinaryService {
  final String cloudName;
  final String uploadPreset;
  final String folder; // optional folder in your Cloudinary account

  CloudinaryService({
    required this.cloudName,
    required this.uploadPreset,
    this.folder = 'coaching_discussion',
  });

  /// Generic upload - resourceType: 'image' or 'video' or 'auto'
  Future<String?> uploadFile(File file, {String resourceType = 'auto'}) async {
    final uri = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/$resourceType/upload');
    final request = http.MultipartRequest('POST', uri);

    request.fields['upload_preset'] = uploadPreset;
    request.fields['folder'] = folder;
    // Add any other fields (e.g., context, tags) if needed

    final multipartFile = await http.MultipartFile.fromPath('file', file.path);
    request.files.add(multipartFile);

    final streamed = await request.send();
    final response = await http.Response.fromStream(streamed);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> body = json.decode(response.body);
      return body['secure_url'] as String?;
    } else {
      // error - log body for debugging
      print('Cloudinary upload error: ${response.statusCode} - ${response.body}');
      return null;
    }
  }

  Future<String?> uploadImage(File file) => uploadFile(file, resourceType: 'image');

  /// Upload audio (Cloudinary treats audio as 'video' resource type in some endpoints)
  Future<String?> uploadAudio(File file) => uploadFile(file, resourceType: 'video');
}
