class CloudinaryHelper {
  static String extractPublicId(String url) {
    try {
      // Split by "/upload/"
      final parts = url.split("/upload/");
      if (parts.length > 1) {
        // take the last part after upload/
        String filePath = parts[1];

        // remove version (starts with v1234567/)
        filePath = filePath.replaceFirst(RegExp(r"^v[0-9]+/"), "");

        // remove extension (.jpg, .png etc.)
        filePath = filePath.replaceAll(RegExp(r"\.[a-zA-Z0-9]+$"), "");

        return filePath;
      }
      return "";
    } catch (e) {
      print("Error extracting public_id: $e");
      return "";
    }
  }
}
