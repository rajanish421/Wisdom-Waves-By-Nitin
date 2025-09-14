import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class CdnService {
  final String cloudName;
  final String uploadPreset;

  CdnService({
    required this.cloudName,
    required this.uploadPreset,
  });

  Future<String?> uploadImage(File imageFile) async {
    final url =
    Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/image/upload");

    final request = http.MultipartRequest("POST", url)
      ..fields['upload_preset'] = uploadPreset
      ..fields['folder'] = "Announcement Images"
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request.send();
    if (response.statusCode == 200) {
      final resStr = await response.stream.bytesToString();
      final data = jsonDecode(resStr);
      return data['secure_url'];
    } else {
      print("Cloudinary upload error: ${response.statusCode}");
      return null;
    }
  }
}
