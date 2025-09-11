import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../Model/file_model.dart';
import '../widgets/image.dart';
import 'full_screen_image.dart';

class ImagesScreen extends StatefulWidget {
  final String className;
  final String subject;

  const ImagesScreen({
    super.key,
    required this.className,
    required this.subject,
  });

  @override
  State<ImagesScreen> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<UploadModel>> getImages() async {
    QuerySnapshot snapshot = await _firestore
        .collection('files')
        .where('className', isEqualTo: widget.className)
        .where('subject', isEqualTo: widget.subject)
        .where('type', isEqualTo: 'images')
        .get();

    return snapshot.docs
        .map((doc) => UploadModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('${widget.subject} Images'),
      // ),
      body: FutureBuilder<List<UploadModel>>(
        future: getImages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading images'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No images found'));
          } else {
            final images = snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: images.length,
              itemBuilder: (context, index) {
                final image = images[index];

                return GestureDetector(
                  onTap: () async {
                    try {
                      // Get the cached file from your CachedImageWidget logic
                      final file = await CachedImageWidget.getCachedFile(
                        imageUrl: image.url,
                        className: image.className,
                        subject: image.subject,
                        imageName: image.name,
                      );

                      if (!mounted) return;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FullScreenImage(imageFile: file),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Error opening image')),
                      );
                    }
                  },
                  child: CachedImageWidget(
                    imageUrl: image.url,
                    className: image.className,
                    subject: image.subject,
                    imageName: image.name,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
