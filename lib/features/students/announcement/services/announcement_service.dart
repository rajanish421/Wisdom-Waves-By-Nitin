import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../Model/announcement_model.dart';

class AnnouncementService {
  final _db = FirebaseFirestore.instance;

  Stream<List<Announcement>> getAnnouncements() {
    return _db
        .collection('announcements')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => Announcement.fromMap(doc.data())).toList());
  }

  Future<void> addAnnouncement(Announcement ann) async {
    final docRef = _db.collection('announcements').doc();
    final annWithId = Announcement(
      announcementId: docRef.id,
      title: ann.title,
      message: ann.message,
      imageUrl: ann.imageUrl,
      createdAt: ann.createdAt,
    );
    await docRef.set(annWithId.toMap());
  }


  Future<Announcement?> getAnnouncementById(String id) async {
    final doc = await _db.collection('announcements').doc(id).get();
    if (doc.exists) {
      return Announcement.fromMap(doc.data()!);
    }
    return null;
  }
}
