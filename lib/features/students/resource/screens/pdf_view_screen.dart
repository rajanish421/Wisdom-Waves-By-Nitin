import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:wisdom_waves_by_nitin/features/students/resource/screens/pdf_preview_screen.dart';
import 'package:wisdom_waves_by_nitin/features/students/resource/services/file_services.dart';
import '../../../../Model/file_model.dart';

/// Shows a list of PDFs for a subject
class PdfLibrary extends StatefulWidget {
  final String className;
  final String subject;

  const PdfLibrary({Key? key, required this.className , required this.subject}) : super(key: key);

  @override
  State<PdfLibrary> createState() => _PdfLibraryState();
}

class _PdfLibraryState extends State<PdfLibrary> {
  FileService fileService = FileService();
  
  @override
  Widget build(BuildContext context) {
   return FutureBuilder(future:fileService.getPdfs(widget.className, widget.subject) , builder: (context, snapshot) {
     if (!snapshot.hasData || snapshot.data!.isEmpty) return Center(child: Text("No pdf"));
     final pdfs = snapshot.data;

     return ListView.builder(
       itemCount: pdfs!.length,
       itemBuilder: (context, index) {
         final pdf = pdfs[index];
         return Card(
           margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
           child: ListTile(
             leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
             title: Text(pdf.name),
             subtitle: Text("Class: ${pdf.className} | Subject: ${pdf.subject}"),
             trailing: const Icon(Icons.arrow_forward_ios),
             onTap: () {
               Navigator.push(
                 context,
                 MaterialPageRoute(
                   builder: (_) => PdfViewerScreen(pdf: pdf),
                 ),
               );
             },
           ),
         );
       },
     );
   },);
  }
}

/// Opens a single PDF in viewer
// class PdfViewerScreen extends StatelessWidget {
//   final UploadModel pdf;
//
//   const PdfViewerScreen({Key? key, required this.pdf}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(pdf.name)),
//       body: SfPdfViewer.network(
//         "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf", // ✅ Directly load PDF from Cloudinary
//         canShowScrollHead: true,
//         canShowScrollStatus: true,
//       ), // ✅ directly loads from Cloudinary URL
//     );
//   }
// }
