import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateChecker {
  static const String repositoryOwner = 'rajanish421';
  static const String repositoryName = 'Wisdom-Waves-By-Nitin';


  static Future<String> getCurrentVersion()async{
    try{
      PackageInfo packageInfo =  await PackageInfo.fromPlatform();
      String currentVersion = packageInfo.version;

      return currentVersion;
    }catch(err){
      return err.toString();
    }
  }

  static Future<void> checkLatestVersion(BuildContext context) async {
    try {
      // Get installed version
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String currentVersion = packageInfo.version;
      print("Current $currentVersion");

      final response = await http.get(Uri.parse(
        'https://api.github.com/repos/$repositoryOwner/$repositoryName/releases/latest',
      ));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final String latestVersion = data['tag_name'];

        // Get APK download URL
        final assets = data['assets'] as List<dynamic>;
        String? newAppUrl;
        for (final asset in assets) {
          newAppUrl = asset['browser_download_url'];
        }

        if (newAppUrl == null) {
          debugPrint("❌ No APK file found in release.");
          return;
        }
        print("Latest $latestVersion");
        // Compare versions
        if (currentVersion != latestVersion) {
          showAnimatedUpdateDialog(context, newAppUrl);
        } else {
          debugPrint("✅ App is up-to-date.");
        }
      } else {
        debugPrint(
            '❌ Failed to fetch GitHub release info. Status: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("❌ Error checking update: $e");
    }
  }

  // static void _showUpdateSnackbar(BuildContext context, String newAppUrl) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: const Text("🚀 New Update Available!"),
  //       action: SnackBarAction(
  //         label: "Update",
  //         onPressed: () {
  //           launchUrl(
  //             Uri.parse(newAppUrl),
  //             mode: LaunchMode.externalApplication,
  //           );
  //         },
  //       ),
  //       duration: const Duration(days: 1), // stays until dismissed
  //     ),
  //   );
  // }

static  void showAnimatedUpdateDialog(BuildContext context, String apkUrl) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Update Available",
      barrierDismissible: false,
      barrierColor: Colors.black54, // semi-transparent background
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.system_update, size: 60, color: Colors.blue),
                const SizedBox(height: 15),
                const Text(
                  "🚀 New Update Available!",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Update now to enjoy the latest features, improvements, and bug fixes.",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black87,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Later"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () async {
                        Navigator.of(context).pop();
                        final uri = Uri.parse(apkUrl);

                          await launchUrl(uri,
                              mode: LaunchMode.externalApplication);

                      },
                      child: const Text("Update Now"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position:
          Tween(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(
            CurvedAnimation(parent: anim1, curve: Curves.easeOutBack),
          ),
          child: ScaleTransition(
            scale: CurvedAnimation(parent: anim1, curve: Curves.easeOutBack),
            child: child,
          ),
        );
      },
    );
  }

}
