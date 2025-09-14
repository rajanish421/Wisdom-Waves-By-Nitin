import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../Model/discussion_model.dart';
import '../../../../utills/cloudinary_helper.dart';
import '../../../../utills/cloudinary_service.dart';

class DiscussionRepository {
  final _col = FirebaseFirestore.instance.collection('discussion');
  CloudinaryService cloudinaryService = CloudinaryService(cloudName: "dosossycv", apiKey: "219542351545111", apiSecret: "kt1637AQe1tauP1gnNP4Lqx5Fqk");

  Stream<List<DiscussionMessage>> messagesStream({int limit = 500}) {
    return _col
        .orderBy('timestamp', descending: false)
        .limit(limit)
        .snapshots()
        .map((snap) =>
        snap.docs.map((d) => DiscussionMessage.fromFirestore(d)).toList());
  }

  Future<void> sendMessage(DiscussionMessage message , String id) async {
    await _col.doc(id).set(message.toFirestoreMap());
  }


  Future<void> deleteMessage(String id) async {
    await _col.doc(id).delete();
  }




  Future<void> deleteImageFromFirestoreAndCloudinary({
    required String docId,
    required String imageUrl,
  }) async {
    try {
      // Step 1: Extract public_id from URL
      final publicId = CloudinaryHelper.extractPublicId(imageUrl);

      if (publicId.isEmpty) {
        print("Could not extract public_id ❌");
        return;
      }
      print(publicId);

      // Step 2: Delete from Cloudinary
      final success = await cloudinaryService.deleteImage(publicId);

      if (success) {
        // Step 3: Delete Firestore doc
        await FirebaseFirestore.instance
            .collection('discussion') // apna collection name dalna
            .doc(docId)
            .delete();

        print("✅ Deleted from Cloudinary & Firestore");
      } else {
        print("❌ Failed to delete from Cloudinary");
      }
    } catch (e) {
      print("Error: $e");
    }
  }


}
