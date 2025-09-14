import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart'; // add in pubspec.yaml: crypto: ^3.0.3

class CloudinaryService {
  final String cloudName;
  final String apiKey;
  final String apiSecret;

  CloudinaryService({
    required this.cloudName,
    required this.apiKey,
    required this.apiSecret,
  });

  Future<bool> deleteImage(String publicId) async {
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      // Generate signature string
      final signatureString =
          "public_id=$publicId&timestamp=$timestamp$apiSecret";
      final signature =
      sha1.convert(utf8.encode(signatureString)).toString();
      final url = Uri.parse(
          "https://api.cloudinary.com/v1_1/$cloudName/image/destroy");
      final response = await http.post(
        url,
        body: {
          "public_id": publicId,
          "api_key": apiKey,
          "timestamp": timestamp.toString(),
          "signature": signature,
        },
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        return result['result'] == 'ok';
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
