import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../../Model/file_model.dart';

class PdfViewerScreen extends StatefulWidget {
  final UploadModel pdf;

  const PdfViewerScreen({Key? key, required this.pdf}) : super(key: key);

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  bool _isLoading = true;
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.pdf.name)),
      body: Stack(
        children: [
          /// ✅ PDF Viewer
          SfPdfViewer.network(
            widget.pdf.url,
            canShowScrollHead: true,
            canShowScrollStatus: true,
            onDocumentLoaded: (details) {
              setState(() {
                _isLoading = false;
                _hasError = false;
              });
            },
            onDocumentLoadFailed: (details) {
              print(details.description);
              setState(() {
                _isLoading = false;
                _hasError = true;
              });
            },
          ),

          /// ⏳ Loading Indicator
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),

          /// ❌ Error Message
          if (_hasError)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 48),
                  const SizedBox(height: 12),
                  const Text(
                    "Failed to load PDF",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isLoading = true;
                        _hasError = false;
                      });
                    },
                    child: const Text("Retry"),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
