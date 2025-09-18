import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wisdom_waves_by_nitin/Custom_Widget/toast_message.dart';

class StudentQrPage extends StatefulWidget {
  final String userId;
  final String name;
  final String batchId;

  const StudentQrPage({
    super.key,
    required this.userId,
    required this.name,
    required this.batchId,
  });

  @override
  State<StudentQrPage> createState() => _StudentQrPageState();
}

class _StudentQrPageState extends State<StudentQrPage> {
  final GlobalKey globalKey = GlobalKey();
  final String externalDir = '/storage/emulated/0/Download/Student_QR';

  /// Capture QR as bytes with white background
  Future<Uint8List?> _captureQrBytes() async {
    try {
      RenderRepaintBoundary boundary =
      globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);

      final whitePaint = Paint()..color = Colors.white;
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(
        recorder,
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      );
      canvas.drawRect(
          Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
          whitePaint);
      canvas.drawImage(image, Offset.zero, Paint());
      final picture = recorder.endRecording();
      final img = await picture.toImage(image.width, image.height);
      ByteData? byteData = await img.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      debugPrint("❌ Capture Error: $e");
      return null;
    }
  }

  /// Request storage permission
  Future<bool> _requestPermission() async {
    if (Platform.isAndroid) {
      if (await Permission.manageExternalStorage.isGranted ||
          await Permission.storage.isGranted) return true;

      var status = await Permission.manageExternalStorage.request();
      if (!status.isGranted) {
        status = await Permission.storage.request();
      }
      return status.isGranted;
    } else {
      final status = await Permission.photos.request();
      return status.isGranted;
    }
  }

  /// Save QR code
  Future<void> _saveQrCode() async {
    try {
      bool granted = await _requestPermission();
      if (!granted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
                "⚠️ Storage permission is required to save QR"),
            action: SnackBarAction(
              label: "Settings",
              onPressed: () => openAppSettings(),
            ),
          ),
        );
        return;
      }

      Uint8List? pngBytes = await _captureQrBytes();
      if (pngBytes == null) return;

      final dir = Directory(externalDir);
      if (!await dir.exists()) await dir.create(recursive: true);

      String fileName = 'qr_${widget.userId}';
      int i = 1;
      while (await File('${dir.path}/$fileName.png').exists()) {
        fileName = 'qr_${widget.userId}_$i';
        i++;
      }

      final file = await File('${dir.path}/$fileName.png').create();
      await file.writeAsBytes(pngBytes);

      if (!mounted) return;
      ToastMessage.show(message: "✅ QR Code saved at: ${file.path}",gravity:ToastGravity.TOP,backgroundColor: Colors.green,toastLength: Toast.LENGTH_LONG);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Error: $e")),
      );
    }
  }

  /// Share QR code
  Future<void> _shareQrCode() async {
    try {
      Uint8List? pngBytes = await _captureQrBytes();
      if (pngBytes == null) return;

      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/qr_${widget.userId}.png');
      await file.writeAsBytes(pngBytes);

      await Share.shareXFiles([XFile(file.path)],
          text: "Here is my QR Code for attendance 📲");
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Error sharing QR: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final qrData = jsonEncode({
      "userId": widget.userId,
      "name": widget.name,
      "batchId": widget.batchId,
    });

    return Scaffold(
      appBar: AppBar(title: const Text("My QR Code")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RepaintBoundary(
              key: globalKey,
              child: QrImageView(
                data: qrData,
                version: QrVersions.auto,
                size: 200.0,
                gapless: true,
                embeddedImage: AssetImage('assets/icons/logo.png'), // Your logo
                embeddedImageStyle: QrEmbeddedImageStyle(
                  size: const Size(40, 40), // Size of the logo
              ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _saveQrCode,
              icon: const Icon(Icons.download),
              label: const Text("📥 Download QR"),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _shareQrCode,
              icon: const Icon(Icons.share),
              label: const Text("📤 Share QR"),
            ),
          ],
        ),
      ),
    );
  }
}
