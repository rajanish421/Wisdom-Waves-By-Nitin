import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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

  Future<void> _saveQrCode() async {
    try {
      // ✅ Request permission properly
      if (Platform.isAndroid) {
        if (await Permission.manageExternalStorage.isDenied ||
            await Permission.storage.isDenied) {
          var status = await Permission.manageExternalStorage.request();

          if (!status.isGranted) {
            status = await Permission.storage.request();
          }

          if (!status.isGranted) {
            // 👉 Ask user to enable in settings
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("⚠️ Storage permission is required to save QR"),
                action: SnackBarAction(
                  label: "Settings",
                  onPressed: () {
                    openAppSettings();
                  },
                ),
              ),
            );
            return;
          }
        }
      }

      // ✅ Capture QR as image
      RenderRepaintBoundary boundary =
      globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // ✅ Save file to correct path
      String savePath;
      if (Platform.isAndroid) {
        savePath = "/storage/emulated/0/Download"; // Downloads folder
      } else {
        final dir = await getApplicationDocumentsDirectory();
        savePath = dir.path;
      }

      final file = File('$savePath/qrcode_${widget.userId}.png');
      await file.writeAsBytes(pngBytes);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("✅ QR Code saved at: ${file.path}")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Error: $e")),
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
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveQrCode,
              child: const Text("📥 Download QR"),
            ),
          ],
        ),
      ),
    );
  }
}
